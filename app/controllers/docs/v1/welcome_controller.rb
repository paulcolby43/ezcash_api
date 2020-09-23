class Docs::V1::WelcomeController < ApplicationController
  
  def index
    @version = params[:version] ||= '1'
  end
  
end