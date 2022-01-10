class Transaction < ApplicationRecord

  
  belongs_to :bank_account
  
  validate :positive_balance, on: :create
  
  def positive_balance
    errors.add(:customer_id, "so big summa") unless amount_cents < bank_account.balance_cents
  end

end
