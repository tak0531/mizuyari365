class ProductsController < ApplicationController
  def index
    @products = current_user.products.all
  end

  def new
    @results = []
    if params[:keyword].present?
      results = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword]).to_a
      @results.concat(results)
    else
      flash[:danger] = '検索ワードを入力してください'
      redirect_to product_search_path
    end
  end

  def create
    @product = current_user.products.new(rakuten_params)
    if @product.save
      flash[:success] = '商品を登録しました'
      redirect_to new_product_path, status: :unprocessable_entity
    else
      flash.now[:danger] = '商品の登録に失敗しました'
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @user = current_user.id

    if @product.destroy
      redirect_to mypage_path
      flash[:success] = '登録していた商品を削除しました'
    else
      flash.now[:danger] = "植物の削除に失敗しました"
      render mypage_path, status: :unprocessable_entity
    end
  end

  def search
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    popular_product_names = Product.where(name: Product.group(:name).having("COUNT(*) > 1").pluck(:name))
    @popular_products = popular_product_names.select(:name,:product_image,:rakuten_url,:price).distinct
  end

  private

  def rakuten_params
    params.permit(:name, :price, :rakuten_url, :product_image)
  end

  def check_product_limit
    if current_user.products.count >= 3
      flash[:danger] = '商品を3つまでしか登録できません'
      redirect_to mypage_path
    end
  end
end
