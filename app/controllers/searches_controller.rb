class SearchesController < ApplicationController
  def new
  end
  def create


    @search = Search.new(params[:search].permit!)
    @search.user = current_user
    @search.ip = Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address)

    if @search.save
      @new_search = Search.new

      Item.__elasticsearch__.client = Elasticsearch::Client.new host: '104.197.50.109:9400'



      if params[:search][:ncm]
        unique_ncm = params[:search][:ncm].uniq
        unique_ncm -= ["0"]


      @items = Item.search(
    query: {
      bool:  {
        must: [
          { match:  {descricao_detalhada_produto: params[:search][:query] }},
          { match:  {ncm: unique_ncm }}]
      }
    }
).results 
    else
      @items = Item.search(
        query: 
        { match:  {descricao_detalhada_produto: params[:search][:query] }},
        size: 50
      ).results 
      end

      @ncms = @items.flat_map(&:ncm).inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}


      render "items/index"
    else 
      #handle the case where it fails....
    end
  end

  def index
   @searches = Search.last(10)
  end



end