json.extract! transaction, :id, :counterparty_name, :counterparty_iban, :counterparty_bic, :amount_cents, :amount_currency, :description, :bank_account_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
