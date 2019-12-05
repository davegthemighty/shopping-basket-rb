class ItemsController < ApplicationController
  def index
      render json: {items: Item.all}
  end

  def show
    render json: {item: Item.find(params[:id])}
  end

end
