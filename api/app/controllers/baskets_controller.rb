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

  def empty_basket
      # For now, this is being used to validate the existence of the basket
      basket = Basket.find(params[:basket_id])
      basket.empty_basket
      basket.total = basket.get_updated_total
      if basket.save
        return redirect_to basket
      end

      return render json: {action: 'empty basket', errors: 'unable to complete action'}

  end

end
