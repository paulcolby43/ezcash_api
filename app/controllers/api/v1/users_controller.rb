class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :generate_api_token]
  before_action :authenticate, except: [:show]
  load_and_authorize_resource
  
#  include ActionController::HttpAuthentication::Basic::ControllerMethods 
  
  # GET /users
  def index
#    @users = User.all
#    Rails.logger.debug "******logged in? #{logged_in?} #{current_user.blank? ? '' : current_user.user_name}"
#    @users = User.user_name(params[:user_name])
    @users = current_user.company.users.user_name(params[:user_name])
    .company_id(params[:company_id])
#    .user_name(params[:user_name])
#    .yard_id(params[:yardid])
#    render json: @users
    render json: JSON.pretty_generate(JSON.parse(@users.to_json))
  end
  
  # GET /users/:id
  def show
#    render json: @user
    render json: JSON.pretty_generate(@user.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render error: {error: 'Unable to create User.'}, status: 400
    end
  end
  
  # PUT /users/:id
  def update
    if @user
      @user.update(user_params)
#      render json: {message: 'User successfully updated.'}, status: 200
      render json: @user, status: 200
    else
      render error: {error: 'Unable to update User.'}, status: 400
    end
  end
  
  # DELETE /users/:id
  def destroy
    if @user
      @user.destroy
      render json: {message: 'User successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete User.'}, status: 400
    end
  end
  
  # GET /users/:id/generate_api_token
  def generate_api_token
    if @user
      @user.set_auth_token
      render json: JSON.pretty_generate(@user.as_json)
    end
    rescue ActiveRecord::RecordNotFound
      head :not_found
#    if @user = authenticate_with_http_basic { |u, p| User.authenticate(u, p) }
#      @user.set_auth_token
#      render json: JSON.pretty_generate(@user.as_json)
#    else
#      request_http_basic_authentication
#    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit()
  end
  
end