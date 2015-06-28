class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def process_payment
    customer = Stripe::Customer.create email: email, card: card_token

    Stripe::Charge.create customer: customer.id ,
                          amount: 120,
                          description: 'clot-ticket-test1',
                          currency: 'usd'

  end
end


