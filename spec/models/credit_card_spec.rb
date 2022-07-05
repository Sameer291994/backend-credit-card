require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  subject { FactoryBot.build :credit_card }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:limit) }
    it { is_expected.to validate_length_of(:card_number).is_at_most(19) }
    it "validates that its Luhn 10" do
    subject.validate
    expect(subject.errors[:card_number]).to_not include('is not valid')
    end
    it "validates that its not Luhn 10" do
    subject.card_number = "1234567"
    subject.validate
    expect(subject.errors[:card_number]).to include('is not valid')
    end
  end
end