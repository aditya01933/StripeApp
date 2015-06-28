class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tickets = Ticket.all
    respond_with(@tickets)
  end

  def show
    respond_with(@ticket)
  end

  def new
    @ticket = Ticket.new
    respond_with(@ticket)
  end

  def edit
  end

  def create
   @ticket = Ticket.new ticket_params.merge(email: stripe_params["stripeEmail"],
                                                               card_token: stripe_params["stripeToken"])
    raise "Please, check ticket errors" unless @ticket.valid?
    @ticket.process_payment
    @ticket.user_id = 1
    @ticket.event_id = 1
    @ticket.save
    redirect_to @ticket, notice: 'ticket was successfully created.'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new
    
    
  end

  def update      
    @ticket.update(ticket_params)
    respond_with(@ticket)
  end

  def destroy
    @ticket.destroy
    respond_with(@ticket)
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:user_id)
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end
end
