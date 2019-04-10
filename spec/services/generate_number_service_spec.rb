require 'rails_helper'

describe GenerateNumberService do
  context 'record one phone number' do
    let(:user) { 'user_name' }
    let(:number) { nil }
    let(:phone_number_params) { { user: user, number: number } }
    let(:db_record) { PhoneNumber.last }

    it 'creates record with user first number' do

      expect { described_class.call(phone_number_params) }.to change(PhoneNumber, :count).by(1)
      expect(db_record.number).to eq PhoneNumber::START_PHONE_NUMBER
      expect(db_record.user).to eq user
      expect(db_record.fancy_number).to be false
    end

    context 'fancy phone' do
      let(:number) { '111-222-333' }

      before { described_class.call(phone_number_params) }

      it 'creates custom number' do
        expect(db_record.number).to eq number.tr('-', '').to_i
        expect(db_record.user).to eq user
        expect(db_record.fancy_number).to be true
      end

      context 'fancy number already exist' do
        it 'creates random phone number' do
          expect { described_class.call(phone_number_params) }.to change(PhoneNumber, :count).by(1)
          expect(db_record.number).to eq PhoneNumber::START_PHONE_NUMBER
          expect(db_record.user).to eq user
          expect(db_record.fancy_number).to be false
        end
      end
    end
  end
end
