class Api::V1::CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]
#  before_action :authenticate
  load_and_authorize_resource
  
  # GET /cards
  def index
#    @cards = Card.all
#    @cards = current_user.company.cards.customer_id(params[:CustomerID])
    @cards = Card.customer_id(params[:CustomerID])
    .device(params[:DevID])
    .company_number(params[:CompanyNumber])
    .barcode(params[:Barcode])
    .transaction_id(params[:TranID])
    .used(params[:Used])
    .account_id(params[:ActID])
    .start_time(parse_datetime(params[:start_time]))
    .end_time(parse_datetime(params[:end_time]))
    .order("date_time DESC")
    .limit(cards_limit)
#    render json: @cards
    render json: JSON.pretty_generate(@cards.as_json)
  end
  
  # GET /cards/:id
  def show
#    render json: @card
    render json: JSON.pretty_generate(@card.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /cards
  def create
    @card = Card.new(card_params)
    if @card.save
      render json: @card, status: 201
    else
      render error: {error: 'Unable to create Card.'}, status: 400
    end
  end
  
  # PUT /cards/:id
  def update
    if @card
      @card.update(card_params)
#      render json: {message: 'Card successfully updated.'}, status: 200
      render json: @card, status: 200
    else
      render error: {error: 'Unable to update Card.'}, status: 400
    end
  end
  
  # DELETE /cards/:id
  def destroy
    if @card
      @card.destroy
      render json: {message: 'Card successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Card.'}, status: 400
    end
  end
  
  # GET /cards/encode
  def encode
    amount = params[:amount].blank? ? 0 : params[:amount]
    payment_nbr = params[:payment_nbr]
    date = params[:date].blank? ? Date.today.to_s : params[:date]
    dev_id = params[:dev_id]
    barcode = SecureRandom.alphanumeric(10).upcase
    company_nbr = current_user.blank? ? nil : current_user.company_id
    @card = Card.new(card_amt: amount, avail_amt: amount, card_nbr: payment_nbr, receipt_nbr: payment_nbr, dev_id: dev_id, issued_date: date, 
      last_activity_date: date, card_status: 'AC', bank_id_nbr: 111101, barcodeHash: barcode, IssuingCompanyNbr: company_nbr)
    if @card.save
#      render json: @card, status: 201
      render plain: "SUCCESS #{barcode}"
    else
#      render error: {error: 'Unable to create Card.'}, status: 400
      render plain: "FAILED"
    end
  end
  
  # GET /cards/void
  def void
    amount = params[:amount]
    payment_nbr = params[:payment_nbr]
    date = "#{params[:date]} 00:00:00"
    @card = Card.where(card_amt: amount, card_nbr: payment_nbr, issued_date: date).first
    unless @card.blank?
      if @card.avail_amt.zero?
        # Card was already paid
        render plain: "REJECTED"
      elsif @card.avail_amt == @card.card_amt
        # Card has not been paid yet
        @card.card_status = 'VD'
        if @card.save
          render plain: "SUCCESS"
        else
          render plain: "FAILED"
        end
      else
        original_amount = @card.card_amt
        available_amount = @card.avail_amt
        paid_amount = original_amount - available_amount
        @card.card_status = 'VD'
        if @card.save
          render plain: "PARTIALPAY #{paid_amount} of #{original_amount}"
        else
          render plain: "FAILED"
        end
      end
    else
      render plain: "FAILED"
    end
  end
  
  private
  
  def set_card
    @card = Card.find(params[:id])
  end
  
  def cards_limit
    (1..1000).include?(params[:limit].to_i) ?  params[:limit] : 100
  end
  
  def parse_datetime(datetime)
    unless datetime.blank?
      begin
#         Time.parse(datetime)
        datetime.to_datetime
      rescue ArgumentError
         nil
      end
    else
      nil
    end
  end
  
  def card_params
    params.require(:card).permit()
  end
      
end