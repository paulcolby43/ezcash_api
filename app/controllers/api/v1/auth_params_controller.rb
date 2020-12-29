class Api::V1::AuthParamsController < ApplicationController
  before_action :set_auth_param, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /auth_params
  def index
#    @auth_params = AuthParam.all
#    @auth_params = AuthParam.device(params[:dev_id])
    @auth_params = current_user.company.auth_params.device(params[:dev_id])
    .device(params[:device_id])
    .param_name(params[:param_name])
    .description(params[:description])
    .active_flag(params[:active_flag])
    .clone_flag(params[:clone_flag])
    .val1_desc(params[:val1_desc])
    .val1(params[:val1])
    .val2_desc(params[:val2_desc])
    .val2(params[:val2])
    .val3_desc(params[:val3_desc])
    .val3(params[:val3])
    .limit(auth_params_limit)
#    render json: @auth_params
    render json: JSON.pretty_generate(@auth_params.as_json)
  end
  
  # GET /auth_params/:id
  def show
#    render json: @auth_param
    render json: JSON.pretty_generate(@auth_param.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /auth_params
  def create
    @auth_param = AuthParam.new(auth_param_params)
    if @auth_param.save
      render json: @auth_param, status: 201
    else
      render error: {error: 'Unable to create AuthParam.'}, status: 400
    end
  end
  
  # PUT /auth_params/:id
  def update
    if @auth_param
      @auth_param.update(auth_param_params)
#      render json: {message: 'AuthParam successfully updated.'}, status: 200
      render json: @auth_param, status: 200
    else
      render error: {error: 'Unable to update AuthParam.'}, status: 400
    end
  end
  
  # DELETE /auth_params/:id
  def destroy
    if @auth_param
      @auth_param.destroy
      render json: {message: 'AuthParam successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete AuthParam.'}, status: 400
    end
  end
  
  private
  
  def auth_params_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 100
  end
  
  def set_auth_param
    @auth_param = AuthParam.find(params[:id])
  end
  
  def auth_param_params
    params.require(:auth_param).permit()
  end
  
end