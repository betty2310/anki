class DecksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck, only: %i(show update destroy)

  # GET /decks
  def index
    # if Rails.cache.exist?("decks/#{current_user.id}")
    #   @decks = Rails.cache.read("decks/#{current_user.id}")
    # else
    #   @decks = current_user.decks.is_parent
    #   Rails.cache.write("decks/#{current_user.id}", @decks)
    # end

    @decks = current_user.decks.is_parent
    render json: @decks.map{|deck| deck_with_children(deck)}
  end

  # GET /decks/1
  def show
    render json: @deck
  end

  # POST /decks
  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      render json: @deck, status: :created, location: @deck
    else
      render json: @deck.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /decks/1
  def update
    if @deck.update(deck_params)
      render json: @deck
    else
      render json: @deck.errors, status: :unprocessable_entity
    end
  end

  # DELETE /decks/1
  def destroy
    @deck.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def deck_params
    params.require(:deck).permit(:name, :parent_id)
  end

  def deck_with_children deck
    {
      id: deck.id,
      name: deck.name,
      parent_id: deck.parent_id,
      number_of_cards_today: deck.cards.learn_today.count,
      children: deck.children.map{|child| deck_with_children(child)}
    }
  end
end
