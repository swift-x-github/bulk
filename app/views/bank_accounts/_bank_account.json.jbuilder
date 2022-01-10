json.extract! bank_account, :id, :organization_name, :balance_cents, :iban, :bic, :created_at, :updated_at
json.url bank_account_url(bank_account, format: :json)
