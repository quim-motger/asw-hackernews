json.array!(@contributions) do |contribution|
  json.extract! contribution, :id, :contr_type, :contr_subtype, :content, :url, :upvote, :user_id
  json.url contribution_url(contribution, format: :json)
end
