class BasketsController < ApplicationController
  def index
      render json: {baskets: Basket.all}
  end

  def show
    render json: {basket: Basket.find(params[:id])}
  end

  def create
    basket = Basket.new
    if basket.save
      redirect_to basket
    end
  end

end
