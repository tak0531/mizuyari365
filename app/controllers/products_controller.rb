class ProductsController < ApplicationController
  def index
  end

  def new
    @results = []

    results = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword]).to_a
    @results.concat(results)
    p @results
  end

  def create
  end

  def destroy
  end

  def search
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end



end
