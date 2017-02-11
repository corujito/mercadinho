class ClientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_client, only: [:edit, :update, :destroy]
  # before_action :set_client_with_includes, only: [:show]

  # GET /clients
  # GET /clients.json
  def index
    if params[:full_name]
      @client = Client.find_by(full_name: params[:full_name])
      if @client
        redirect_to client_url(@client)
        return
      end
    end
    @clients = Client.order(:balance).page params[:page]
  end

  def find_clients
    @clients = Client.order(:full_name).where("lower(full_name) like ?", "%#{params[:term].downcase}%")
    render json: @clients.map(&:full_name)
  end

  def find_client_by_full_name
    @client = Client.find_by(full_name: params[:full_name])
    respond_to do |format|
      format.js   {}
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    per_page = 10
    respond_to do |format|
      format.html {
        set_client_with_includes
        @orders = @client.orders.order(created_at: :desc).page(params[:orders_page]).per(per_page)
        @payments = @client.payments.order(created_at: :desc).page(params[:payments_page]).per(per_page)
      }
      format.js {
        # set_client
        @orders = Order.order(created_at: :desc).where(client_id: params[:id]).page(params[:orders_page]).per(per_page)
        @payments = Payment.order(created_at: :desc).where(client_id: params[:id]).page(params[:payments_page]).per(per_page)
      }
    end
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Cliente criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @client }
      else
        format.html { render action: 'new' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Cliente atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Client.destroy(params[:client_ids]) if params[:client_ids]
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    def set_client_with_includes
      @client = Client.includes({orders: [ order_items: [:product] ]}).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:full_name, :email, :phone, :address, :active, :balance)
    end
end
