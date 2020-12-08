class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  # GET /users
  def index
    @users = User.all
#    @users = User.user_name(params[:user_name])
#    .user_name(params[:user_name])
#    .yard_id(params[:yardid])
#    render json: @users
    render json: JSON.pretty_generate(JSON.parse(@users.to_json))
  end
  
  # GET /users/:id
  def show
#    render json: @user
    render json: JSON.pretty_generate(JSON.parse(@user.to_json))
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
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit()
  end
      
end