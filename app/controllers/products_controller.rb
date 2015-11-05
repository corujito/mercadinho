class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.order(:full_name).page params[:page]
  end

  def find_products
    @products = Product.order(:full_name).where("lower(full_name) like ?", "%#{params[:term].downcase}%")
    render json: @products.map(&:full_name)
  end

  def find_product_by_full_name
    @product = Product.find_by(full_name: params[:full_name])
    @order_items = []
    if params[:client_id].present?
      @client = Client.find(params[:client_id])
      @order_items = @client.order_items.where(product_id: @product.id) if @client
    end
    respond_to do |format|
      format.js   {}
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Produto foi criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Produto foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:full_name, :unity, :in_stock, :in_stock_formatted)
  end
end
