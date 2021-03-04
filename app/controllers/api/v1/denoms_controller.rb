class Api::V1::DenomsController < ApplicationController
  before_action :set_denom, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /denoms
  def index
#    @denoms = Denom.all
#    @denoms = Denom.denomination(params[:denomination])
    @denoms = current_user.company.denoms.denomination(params[:denomination])
    .device(params[:dev_id])
    .device(params[:device_id])
    .cassette_nbr(params[:cassette_nbr])
    .cassette_id(params[:cassette_id])
    .currency_type(params[:currency_type])
#    render json: @denoms
    render json: JSON.pretty_generate(JSON.parse(@denoms.to_json))
  end
  
  # GET /denoms/:id
  def show
#    render json: @denom
    render json: JSON.pretty_generate(JSON.parse(@denom.to_json))
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /denoms
  def create
    @denom = Denom.new(denom_params)
    if @denom.save
      render json: @denom, status: 201
    else
      render error: {error: 'Unable to create Denom.'}, status: 400
    end
  end
  
  # PUT /denoms/:id
  def update
    if @denom
      @denom.update(denom_params)
#      render json: {message: 'Denom successfully updated.'}, status: 200
      render json: @denom, status: 200
    else
      render error: {error: 'Unable to update Denom.'}, status: 400
    end
  end
  
  # DELETE /denoms/:id
  def destroy
    if @denom
      @denom.destroy
      render json: {message: 'Denom successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Denom.'}, status: 400
    end
  end
  
  private
  
  def set_denom
#    @denom = Denom.find(params[:id])
    @denom = Denom.find([params[:id], params[:dev_id]])
  end
  
  def denom_params
    params.require(:denom).permit()
  end
      
end