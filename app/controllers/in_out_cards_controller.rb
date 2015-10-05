class InOutCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_in_out_card, only: [:show, :edit, :update, :destroy]

  # GET /in_out_cards
  # GET /in_out_cards.json
  def index
    @in_out_cards = InOutCard.order(created_at: :desc).page params[:page]
    @out_cards = InOutCard.all
  end

  # GET /in_out_cards/1
  # GET /in_out_cards/1.json
  def show
  end

  # GET /in_out_cards/new
  def new
    if params[:card_id]
      @card = Card.find(params[:card_id])
    elsif params[:identification]
      @card = Card.find_by(identification: params[:identification])
    elsif params[:full_name]
      @card = Card.find_by(full_name: params[:full_name])
    else
      redirect_to in_out_cards_url
      return
    end
    @in_out_card = @card.in_out_cards.build
  end

  # GET /in_out_cards/1/edit
  def edit
  end

  # POST /in_out_cards
  # POST /in_out_cards.json
  def create
    @in_out_card = InOutCard.new(in_out_card_params)

    respond_to do |format|
      if @in_out_card.save
        format.html { redirect_to in_out_cards_url, notice: 'Registro de cartão criado com sucesso.' }
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
    @in_out_card.destroy
    respond_to do |format|
      format.html { redirect_to in_out_cards_url }
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
      params.require(:in_out_card).permit(:card_id, :inout_type)
    end
end
