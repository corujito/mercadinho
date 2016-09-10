class InOutCardsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_in_out_card, only: [:show, :edit, :update, :destroy]

  # GET /in_out_cards
  # GET /in_out_cards.json
  def index
    @card_owner = CardOwner.find(params[:card_owner]) if params[:card_owner]
    @in_out_cards = []
    if !params[:start_date].blank? and !params[:end_date].blank?
      @start_date = Time.zone.parse(params[:start_date]).beginning_of_day
      @end_date = Time.zone.parse(params[:end_date]).end_of_day

      @in_out_cards = InOutCard.includes(:card, :card_owner).where(card_owner: @card_owner).where(:created_at => @start_date..@end_date).order(created_at: :desc).page(1).per(1000)
    else
      @in_out_cards = InOutCard.includes(:card, :card_owner).where(card_owner: @card_owner).order(created_at: :desc).page params[:page]
    end
  end

  # GET /in_out_cards/1
  # GET /in_out_cards/1.json
  def show
    redirect_to in_out_cards_url
  end

  # GET /in_out_cards/new
  def new
    @card_owner = CardOwner.find(params[:card_owner]) if params[:card_owner] and !params[:card_owner].blank?
    if params[:card_id]
      @card = Card.find(params[:card_id])
      @in_out_card = @card.in_out_cards.build
      @in_out_card.card_owner = @card_owner
      if @in_out_card.save
        flash[:notice] = 'Registro de cartão criado com sucesso.'
      else
        flash[:error] = 'Não foi possível registrar saída de cartão. Verificar se falta campos obrigatórios no cadastro do cartão.'
      end
      redirect_to in_out_cards_url(card_owner: @card_owner)
      return
    elsif params[:card_query]
      @card = Card.new({full_name: params[:card_query], identification: params[:card_query]})
      @in_out_card = @card.in_out_cards.build
      @in_out_card.card_owner = @card_owner
    else
      redirect_to in_out_cards_url(card_owner: @card_owner)
      return
    end
  end

  # GET /in_out_cards/1/edit
  def edit
    redirect_to in_out_cards_url
  end

  # POST /in_out_cards
  # POST /in_out_cards.json
  def create
    @in_out_card = InOutCard.new(in_out_card_params)

    respond_to do |format|
      if @in_out_card.save
        format.html { redirect_to in_out_cards_url(card_owner: @in_out_card.card_owner), notice: 'Registro de cartão criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @in_out_card }
      else
        format.html { render action: 'new' }
        format.json { render json: @in_out_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /in_out_cards/1
  # PATCH/PUT /in_out_cards/1.json
  def update
    respond_to do |format|
      if @in_out_card.update(in_out_card_params)
        format.html { redirect_to in_out_cards_url, notice: 'Registro de cartão atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @in_out_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_out_cards/1
  # DELETE /in_out_cards/1.json
  def destroy
    @card_owner = @in_out_card.card_owner
    @in_out_card.destroy
    respond_to do |format|
      format.html { redirect_to in_out_cards_url(card_owner: @card_owner) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_in_out_card
      @in_out_card = InOutCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def in_out_card_params
      params.require(:in_out_card).permit(:card_id, :card_owner_id, card_attributes: [:full_name, :identification, :password, :cpf, :email, :phone, :card_type])
    end
end
