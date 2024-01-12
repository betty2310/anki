class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck
  before_action :set_card, only: %i(show update destroy)

  # GET /cards
  # GET /cards.json
  def index
    # redis_key = "decks/#{params[:deck_id]}/cards/#{current_user.id}"
    # if Rails.cache.exist?(redis_key)
    #   @cards = Rails.cache.read(redis_key)
    # else
    #   @cards = @deck.cards
    #   # TODO
    #   # add info about next review when choose state
    #   Rails.cache.write(redis_key, @cards)
    # end
    @cards = @deck.cards
    render json: @cards
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card_history = @card.review_histories
    render json: {card: @card, card_history: @card_history}
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new card_params
    @card.user = current_user
    @card.deck = @deck
    if @card.save
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    if @card.update card_params
      render json: @card, status: :ok
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = @deck.cards.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:front, :back, :user_id, :deck_id, :status,
                                 :next_review)
  end

  def set_deck
    @deck = Deck.find(params[:deck_id])
    return unless @deck.user != current_user

    render json: {error: "Not Allowed"}, status: :forbidden
  end
end
