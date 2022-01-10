class GatewayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create

    data_parsed  = JSON.parse(request.raw_post)
    @organization_name = data_parsed["organization_name"]
    @organization_bic  = data_parsed["organization_bic"]
    @organization_iban = data_parsed["organization_iban"]
    @credit_transfers  = data_parsed["credit_transfers"]
   
    @customer = BankAccount.where(organization_name: @organization_name, 
                                         bic: @organization_bic,
                                         iban: @organization_iban, ).first
   
    @array = @credit_transfers.map { |g| (g["amount"].to_f)*100}

    if @customer.balance_cents.to_i > @array.sum.to_i
      
      @credit_transfers.map do |tr| 

      Transaction.transaction do
        @customer.update(balance_cents: @customer.balance_cents - (tr["amount"].to_f * 100).to_i)
        Rails.logger.info "balance has been changed"
        Transaction.create(amount_cents: (tr["amount"].to_f * 100 * (-1)).to_i,
                           amount_currency: 'EUR',
                           counterparty_name: tr["counterparty_name"],
                           counterparty_iban: tr["counterparty_iban"],
                           counterparty_bic: tr["counterparty_bic"],
                           description: tr["description"],
                           bank_account_id: @customer.id )
        Rails.logger.info "transaction has been created"
      end
    end
      render status: :created, body: @customer.balance_cents
    else
      render  status: :unprocessable_entity, body: "Not OK"
    end
  end
end
