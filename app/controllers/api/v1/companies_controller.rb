class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /companies
  def index
#    @companies = Company.all
    @companies = Company.company_number(params[:CompanyNumber])
#    .limit(companies_limit)
#    render json: @companies
    render json: JSON.pretty_generate(@companies.as_json)
  end
  
  # GET /companies/:id
  def show
#    render json: @company
    render json: JSON.pretty_generate(@company.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /companies
  def create
    @company = Company.new(company_params)
    if @company.save
      render json: @company, status: 201
    else
      render error: {error: 'Unable to create Company.'}, status: 400
    end
  end
  
  # PUT /companies/:id
  def update
    if @company
      @company.update(company_params)
#      render json: {message: 'Company successfully updated.'}, status: 200
      render json: @company, status: 200
    else
      render error: {error: 'Unable to update Company.'}, status: 400
    end
  end
  
  # DELETE /companies/:id
  def destroy
    if @company
      @company.destroy
      render json: {message: 'Company successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Company.'}, status: 400
    end
  end
  
  private
  
  def set_company
    @company = Company.find(params[:id])
  end
  
  def companies_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 10
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
  
  def company_params
    params.require(:company).permit(:NameF, :NameL, :CompanyNumber)
  end
  
end