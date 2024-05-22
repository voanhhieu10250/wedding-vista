class PaymentsController < ApplicationController
  def show; end

  def create
    # Amount in VND
    @amount = if params[:payment][:amount].present?
                params[:payment][:amount].to_i
              else
                500
              end

    flash[:notice] = "Payment with amount of #{@amount} was successful"
    redirect_to payment_url
  end

  def hello
    render "show"
  end
end
