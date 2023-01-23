module Admin
  class ProductsController < BaseController
    before_action :set_product, only: %i[show edit update destroy]

    def index
      @products = Product.all
    end

    def edit; end

    def new
      @product = authorize Product.new
    rescue Pundit::NotAuthorizedError
      flash[:notice] = 'Você só pode cadastrar um produto se tiver uma categoria criada'
      redirect_to action: :index
    end

    def show; end

    def create
      @product = Product.new(product_params)
      respond_to do |format|
        if @product.save
          format.html { redirect_to admin_products_path(@product), notice: 'Produto cadastrado com sucesso' }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      @product = Product.new(product_params)
      respond_to do |format|
        if @product.update
          format.html { redirect_to admin_products_path(@product), notice: 'Produto cadastrado com sucesso' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @product.destroy
      respond_to do |format|
        format.html { redirect_to admin_products_path, notice: 'Produto excluido com sucesso' }
      end
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :price, :publish, :category_id)
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
