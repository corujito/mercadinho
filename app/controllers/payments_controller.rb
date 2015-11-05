class PaymentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.includes(:client).order(created_at: :desc).page params[:page]
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    if params[:client_id]
      @client = Client.find(params[:client_id])
    elsif params[:full_name]
      @client = Client.find_by(full_name: params[:full_name])
    else
      redirect_to payments_url
      return
    end
    @payment = @client.payments.build
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        Order.where(id: params[:pagar]).update_all(status: Order.statuses[:paid]) if params[:pagar]
        format.html { redirect_to @payment, notice: 'Pagamento criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @payment }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        Order.where(id: params[:pagar]).update_all(status: Order.statuses[:paid]) if params[:pagar]
        format.html { redirect_to @payment, notice: 'Pagamento atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:client_id, :amount, :client_name)
    end
end
