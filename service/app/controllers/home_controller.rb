class HomeController < ApplicationController
  def index

      @baskets = Basket.all
      @items = Item.all

      @today = DateTime.now
  end
end
