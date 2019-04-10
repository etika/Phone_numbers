class PhoneNumber < ApplicationRecord
    START_PHONE_NUMBER = 1_111_111_111
    FINISH_PHONE_NUMBER = 9_999_999_999

    validates :number,
              uniqueness: true,
              numericality: true,
              inclusion: START_PHONE_NUMBER..FINISH_PHONE_NUMBER

    class << self
      def stringified(number)
        number.to_s.insert(3, '-').insert(7,'-')
      end

      def convert_to_integer(number)
        return unless number
        number.tr('^0-9', '').to_i
      end
    end
  end

