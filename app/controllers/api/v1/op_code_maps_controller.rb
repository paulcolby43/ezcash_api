class Api::V1::OpCodeMapsController < ApplicationController
  before_action :set_op_code_map, only: [:show, :update, :destroy]
  
  # GET /op_code_maps
  def index
#    @op_code_maps = OpCodeMap.all
    @op_code_maps = OpCodeMap.key_seq(params[:KeySeq])
    .tran_code(params[:TranCode])
    .cassette_id(params[:CassetteID])
    .swx_pri_tran(params[:SwxPriTran])
    .swx_sec_tran(params[:SwxSecTran])
    .swx_sec_rev(params[:SwxSecRev])
    .limit(op_code_maps_limit)
    render json: JSON.pretty_generate(@op_code_maps.as_json)
  end
  
  # GET /op_code_maps/:id
  def show
    render json: JSON.pretty_generate(@op_code_map.as_json)
    rescue ActiveRecord::RecordNotFound
      head :not_found
  end
  
  # POST /op_code_maps
  def create
    @op_code_map = OpCodeMap.new(op_code_map_params)
    if @op_code_map.save
      render json: @op_code_map, status: 201
    else
      render error: {error: 'Unable to create OpCodeMap.'}, status: 400
    end
  end
  
  # PUT /op_code_maps/:id
  def update
    if @op_code_map
      @op_code_map.update(op_code_map_params)
      render json: @op_code_map, status: 200
    else
      render error: {error: 'Unable to update OpCodeMap.'}, status: 400
    end
  end
  
  # DELETE /op_code_maps/:id
  def destroy
    if @op_code_map
      @op_code_map.destroy
      render json: {message: 'OpCodeMap successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete OpCodeMap.'}, status: 400
    end
  end
  
  private
  
  def op_code_maps_limit
    (1..100).include?(params[:limit].to_i) ?  params[:limit] : 10
  end
  
  def set_op_code_map
    @op_code_map = OpCodeMap.find(params[:id])
  end
  
  def op_code_map_params
    params.require(:op_code_map).permit()
  end
  
end