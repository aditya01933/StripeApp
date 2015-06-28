class AddStripeCardTokenToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :card_token, :string
  end
end
