require "httparty"
require "json"
require_relative "utils/create_signature"
require_relative "custom_error"
require_relative "constants"

class PayOS
  include HTTParty
  base_uri "https://api-merchant.payos.vn"
  headers "Content-Type" => "application/json"

  attr_reader :client_id, :api_key, :checksum_key

  def initialize
    @client_id = ENV.fetch("PAYOS_CLIENT_ID", nil)
    @api_key = ENV.fetch("PAYOS_API_KEY", nil)
    @checksum_key = ENV.fetch("PAYOS_CHECKSUM_KEY", nil)
  end


  # {
  #  :bin=>"970448",
  #  :accountNumber=>"CAS0974155013",
  #  :accountName=>"VO ANH HIEU",
  #  :amount=>10000,
  #  :description=>"CS0O5GCGTG0 Thanh Toan ABC",
  #  :orderCode=>12,
  #  :currency=>"VND",
  #  :paymentLinkId=>"b8ba2924a4dc48aebba8506d65c25c05",
  #  :status=>"PENDING",
  #  :checkoutUrl=>"https://pay.payos.vn/web/b8ba2924a4dc48aebba8506d65c25c05",
  #  :qrCode=>"00020101021238570010A000000727012700069704480113CAS09741550130208QRIBFTTA53037045405100005802VN62300826CS0O5GCGTG0 Thanh Toan ABC6304F4E5"
  # }
  def create_payment_link(payment_data)
    required_keys = %i[orderCode amount returnUrl cancelUrl description]
    missing_keys = required_keys.select do |key|
      payment_data[key].nil? || payment_data[key].blank?
    end

    unless missing_keys.empty?
      msg_error = "#{ERROR_MESSAGE::INVALID_PARAMETER} #{missing_keys.join(', ')} must not be undefined or null."
      raise ArgumentError, msg_error
    end

    url = "/v2/payment-requests"
    signature_payment_request = create_signature_of_payment_request(payment_data, @checksum_key)

    response = self.class.post(url, headers: auth_headers,
                                    body: payment_data.merge(signature: signature_payment_request).to_json)

    handle_response(response) do |parsed_response|
      payment_link_res_signature = create_signature_from_obj(parsed_response[:data], @checksum_key)
      if payment_link_res_signature != parsed_response[:signature]
        raise StandardError, ERROR_MESSAGE::DATA_NOT_INTEGRITY
      end

      parsed_response[:data]
    end
  end

  def get_payment_link_information(order_id)
    validate_order_id(order_id)
    url = "/v2/payment-requests/#{order_id}"

    response = self.class.get(url, headers: auth_headers)

    handle_response(response) do |parsed_response|
      payment_link_info_res_signature = create_signature_from_obj(parsed_response[:data], @checksum_key)
      if payment_link_info_res_signature != parsed_response[:signature]
        raise StandardError, ERROR_MESSAGE::DATA_NOT_INTEGRITY
      end

      parsed_response[:data]
    end
  end

  def confirm_webhook(webhook_url)
    raise ArgumentError, ERROR_MESSAGE::INVALID_PARAMETER if webhook_url.nil? || webhook_url.empty?

    url = "/confirm-webhook"
    data = { webhookUrl: webhook_url }

    response = self.class.post(url, headers: auth_headers, body: data.to_json)

    handle_response(response)
    webhook_url
  end

  def cancel_payment_link(order_id, cancellation_reason = nil)
    validate_order_id(order_id)
    url = "/v2/payment-requests/#{order_id}/cancel"
    data = cancellation_reason ? { cancellationReason: cancellation_reason } : {}

    response = self.class.post(url, headers: auth_headers, body: data.to_json)

    handle_response(response) do |parsed_response|
      cancel_payment_link_response_signature = create_signature_from_obj(parsed_response[:data], @checksum_key)
      if cancel_payment_link_response_signature != parsed_response[:signature]
        raise StandardError, ERROR_MESSAGE::DATA_NOT_INTEGRITY
      end

      parsed_response[:data]
    end
  end

  def verify_payment_webhook_data(webhook_body)
    data = webhook_body[:data]
    signature = webhook_body[:signature]

    raise ArgumentError, ERROR_MESSAGE::NO_DATA if data.nil?
    raise ArgumentError, ERROR_MESSAGE::NO_SIGNATURE if signature.nil?

    sign_data = create_signature_from_obj(data, @checksum_key)
    raise StandardError, ERROR_MESSAGE::DATA_NOT_INTEGRITY if sign_data != signature

    data
  end

  private

  def auth_headers
    {
      "x-client-id" => @client_id,
      "x-api-key" => @api_key
    }
  end

  def validate_order_id(order_id)
    if order_id.nil? || (order_id.is_a?(Integer) && (order_id <= 0)) || (order_id.is_a?(String) && order_id.empty?)
      raise ArgumentError, ERROR_MESSAGE::INVALID_PARAMETER
    end
  end

  def handle_response(response)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    unless parsed_response[:code] == "00"
      raise PayOSError.new(code: parsed_response[:code], message: parsed_response[:desc])
    end

    yield parsed_response if block_given?
  rescue JSON::ParserError
    raise StandardError, "Invalid JSON response"
  end
end
