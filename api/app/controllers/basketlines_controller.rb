class BasketlinesController < ApplicationController
  def add_item
      # For now, this is being used to validate the existence of item and basket
      basket = Basket.find(params[:basket_id])
      item = Item.find(params[:item_id])

      if basket_line = BasketLine.where(
           "basket_id = :selected_basket_id AND item_id = :selected_item_id ",
           {selected_basket_id: params[:basket_id], selected_item_id: params[:item_id]}
         ).first
          # Increment quantity by 1
          basket_line.update(:quantity => basket_line.quantity + 1)
      else
          # Quantity 1
          basket_line = BasketLine.new(:basket_id => basket.id, :item_id => item.id, :quantity => 1)
      end

      if basket_line.save
        basket.total = basket.get_updated_total
        if basket.save
          return redirect_to basket
        end
      end

      render json: {action: 'put basket item', errors: 'unable to complete action'}

  end

  def remove_item
      # For now, this is being used to validate the existence of item and basket
      basket = Basket.find(params[:basket_id])
      item = Item.find(params[:item_id])

      if basket_line = BasketLine.where(
           "basket_id = :selected_basket_id AND item_id = :selected_item_id ",
           {selected_basket_id: basket.id, selected_item_id: item.id}
         ).first
          # Decrement quantity by 1, only back to zero
          # TODO: Destroy if set to zero
          if basket_line.quantity != 0
              basket_line.update(:quantity => basket_line.quantity - 1)
          end

          if basket_line.save
            basket.total = basket.get_updated_total
            if basket.save
              return redirect_to basket
            end
          end

          return render json: {action: 'remove basket item', errors: 'unable to complete action'}

      end
  end
end
