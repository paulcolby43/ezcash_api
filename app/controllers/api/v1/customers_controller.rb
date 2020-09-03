class Api::V1::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]
  
  # GET /customers
  def index
    @customers = Customer.all
    @customers = Customer.company_number(params[:CompanyNumber])
    .limit(customers_limit)
#    render json: @customers
    render json: JSON.pretty_generate(JSON.parse(@customers.to_json))
  end
  
  # GET /customers/:id
  def show
#    render json: @customer
    render json: JSON.pretty_generate(JSON.parse(@customer.to_json))
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render json: @customer, status: 201
    else
      render error: {error: 'Unable to create Customer.'}, status: 400
    end
  end
  
  # PUT /customers/:id
  def update
    if @customer
      @customer.update(customer_params)
#      render json: {message: 'Customer successfully updated.'}, status: 200
      render json: @customer, status: 200
    else
      render error: {error: 'Unable to update Customer.'}, status: 400
    end
  end
  
  # DELETE /customers/:id
  def destroy
    if @customer
      @customer.destroy
      render json: {message: 'Customer successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Customer.'}, status: 400
    end
  end
  
  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customers_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 10
  end
  
  def parse_datetime(datetime)
    unless datetime.blank?
      begin
         Time.parse(datetime)
      rescue ArgumentError
         nil
      end
    else
      nil
    end
  end
  
  def customer_params
    params.require(:customer).permit(:NameF, :NameL, :CompanyNumber)
  end
      
end