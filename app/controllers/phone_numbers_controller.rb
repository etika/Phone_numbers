class PhoneNumbersController < ApplicationController
  def new
    @number = GenerateNumberService.call(number_params)

    respond_to do |format|
      format.json do
        render json: { user: phone_number.user, number: PhoneNumber.stringified(phone_number.number) }
      end
    end
  end

  private

  attr_reader :phone_number

  def phone_number_params
    params.permit(:number, :user)
  end
end
