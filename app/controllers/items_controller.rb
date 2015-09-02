class ItemsController < ApplicationController

  def show 
    @item = Item.search(
      query: {match: {_id: params[:id]}},
      size: 1
    ).results.first
  end

end