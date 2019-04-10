class GenerateNumberService
  def self.call(phone_number_params)
    params_hash = phone_number_params.to_h.symbolize_keys
    new(params_hash).call
  end

  def initialize(user:, number: nil)
    @user = user
    @number = PhoneNumber.convert_to_integer(number)

  end

  def call
    PhoneNumber.create(user: user, number: pick_number, fancy_number: fancy_number?)
  end

  private

  attr_reader :user, :number

  def pick_number
    return number if fancy_number?

    last_avaliable_number = PhoneNumber.where(fancy_number: false).last
    return PhoneNumber::START_PHONE_NUMBER unless last_avaliable_number

    find_next_number(last_avaliable_number.number)
  end

  def find_next_number(number)
    i = 1
    next_number = number + i
    until PhoneNumber.new(number: next_number).valid?
      next_number = number + i
      i += 1
    end
    next_number
  end

  def fancy_number?
    number.present? && PhoneNumber.new(number: number).valid?
  end
end
