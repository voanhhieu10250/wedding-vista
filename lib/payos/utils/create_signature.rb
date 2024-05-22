require "openssl"
require_relative "sort_obj_by_key"
require_relative "convert_obj_to_query_str"

def create_signature_from_obj(data, key)
  return nil if data.nil? || key.empty?

  sorted_data_by_key = sort_obj_by_key(data)
  data_query_str = convert_obj_to_query_str(sorted_data_by_key)
  OpenSSL::HMAC.hexdigest("sha256", key, data_query_str)
end

def create_signature_of_payment_request(data, key)
  return nil if data.nil? || key.empty?

  amount = data[:amount]
  cancel_url = data[:cancelUrl]
  description = data[:description]
  order_code = data[:orderCode]
  return_url = data[:returnUrl]
  data_str = "amount=#{amount}&cancelUrl=#{cancel_url}&description=#{description}&orderCode=#{order_code}&returnUrl=#{return_url}"
  OpenSSL::HMAC.hexdigest("sha256", key, data_str)
end
