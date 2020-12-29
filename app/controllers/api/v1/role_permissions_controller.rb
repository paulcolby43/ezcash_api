class Api::V1::RolePermissionsController < ApplicationController
  before_action :set_role_permission, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /role_permissions
  def index
#    @role_permissions = RolePermission.all
    @role_permissions = RolePermission.role_id(params[:RoleID])
    .permission_id(params[:PermissionID])
#    .limit(role_permissions_limit)
    render json: JSON.pretty_generate(JSON.parse(@role_permissions.to_json))
  end
  
  # GET /role_permissions/:id
  def show
#    render json: @role_permission
    render json: JSON.pretty_generate(JSON.parse(@role_permission.to_json))
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /role_permissions
  def create
    @role_permission = RolePermission.new(role_permission_params)
    if @role_permission.save
      render json: @role_permission, status: 201
    else
      render error: {error: 'Unable to create RolePermission.'}, status: 400
    end
  end
  
  # PUT /role_permissions/:id
  def update
    if @role_permission
      @role_permission.update(role_permission_params)
#      render json: {message: 'RolePermission successfully updated.'}, status: 200
      render json: @role_permission, status: 200
    else
      render error: {error: 'Unable to update RolePermission.'}, status: 400
    end
  end
  
  # DELETE /role_permissions/:id
  def destroy
    if @role_permission
      @role_permission.destroy
      render json: {message: 'RolePermission successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete RolePermission.'}, status: 400
    end
  end
  
  private
  
  def set_role_permission
#    @role_permission = RolePermission.find(params[:id])
    @role_permission = RolePermission.find([params[:id], params[:RoleID]])
  end
  
  def role_permissions_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 10
  end
  
  def role_permission_params
    params.require(:role_permission).permit()
  end
  
end