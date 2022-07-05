class CreditCard < ApplicationRecord
  validates :name, presence: true
  validates :limit, presence: true
  validates :card_number, format: { with: /\A\d+\z/, message: "Integer only. No Alphanumerics allowed." }, uniqueness: true, length: {maximum: 19.bytes}
  validate :validate_card_number

  def validate_card_number
    number = card_number.gsub(/\D/, '').reverse

    sum, i = 0, 0
    number.each_char do |ch|
      n = ch.to_i
      n *= 2 if i.odd?
      n = 1 + (n - 10) if n >= 10
      sum += n
      i += 1
    end

    unless (sum % 10).zero?
      errors.add(:card_number, "is not valid")
    end
  end
end
