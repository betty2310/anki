class ReviewHistoriesController < ApplicationController
  before_action :set_review_history, only: %i(show update destroy)

  # GET /review_histories
  # GET /review_histories.json
  def index
    @review_histories = ReviewHistory.all
  end

  # GET /review_histories/1
  # GET /review_histories/1.json
  def show; end

  # POST /review_histories
  # POST /review_histories.json
  def create
    @review_history = ReviewHistory.new(review_history_params)

    if @review_history.save
      render :show, status: :created, location: @review_history
    else
      render json: @review_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /review_histories/1
  # PATCH/PUT /review_histories/1.json
  def update
    if @review_history.update(review_history_params)
      render :show, status: :ok, location: @review_history
    else
      render json: @review_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /review_histories/1
  # DELETE /review_histories/1.json
  def destroy
    @review_history.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review_history
    @review_history = ReviewHistory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_history_params
    params.require(:review_history).permit(:card_id, :status)
  end
end
