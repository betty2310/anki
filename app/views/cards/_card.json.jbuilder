json.extract! card, :id, :front, :back, :user_id, :deck_id, :status, :next_review, :created_at, :updated_at
json.url card_url(card, format: :json)
