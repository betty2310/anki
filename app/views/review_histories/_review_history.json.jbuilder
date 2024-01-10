json.extract! review_history, :id, :card_id, :status, :created_at, :updated_at
json.url review_history_url(review_history, format: :json)
