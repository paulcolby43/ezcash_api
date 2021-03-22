class Api::V1::EzPermissionDescsController < ApplicationController
  before_action :set_ez_permission_desc, only: [:show, :update, :destroy]
  before_action :authenticate
  load_and_authorize_resource
  
  # GET /ez_permission_descs
  def index
    @ez_permission_descs = EzPermissionDesc.all
#    @ez_permission_descs = EzPermissionDesc.role_id(params[:RoleID])
#    .permission_id(params[:PermissionID])
#    .limit(ez_permission_descs_limit)
    render json: JSON.pretty_generate(JSON.parse(@ez_permission_descs.to_json))
  end
  
  # GET /ez_permission_descs/:id
  def show
#    render json: @ez_permission_desc
    render json: JSON.pretty_generate(JSON.parse(@ez_permission_desc.to_json))
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /ez_permission_descs
  def create
    @ez_permission_desc = EzPermissionDesc.new(ez_permission_desc_params)
    if @ez_permission_desc.save
      render json: @ez_permission_desc, status: 201
    else
      render error: {error: 'Unable to create EzPermissionDesc.'}, status: 400
    end
  end
  
  # PUT /ez_permission_descs/:id
  def update
    if @ez_permission_desc
      @ez_permission_desc.update(ez_permission_desc_params)
#      render json: {message: 'EzPermissionDesc successfully updated.'}, status: 200
      render json: @ez_permission_desc, status: 200
    else
      render error: {error: 'Unable to update EzPermissionDesc.'}, status: 400
    end
  end
  
  # DELETE /ez_permission_descs/:id
  def destroy
    if @ez_permission_desc
      @ez_permission_desc.destroy
      render json: {message: 'EzPermissionDesc successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete EzPermissionDesc.'}, status: 400
    end
  end
  
  private
  
  def set_ez_permission_desc
#    @ez_permission_desc = EzPermissionDesc.find(params[:id])
    @ez_permission_desc = EzPermissionDesc.find([params[:id], params[:RoleID]])
  end
  
  def ez_permission_descs_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 10
  end
  
  def ez_permission_desc_params
    params.require(:ez_permission_desc).permit()
  end
  
end