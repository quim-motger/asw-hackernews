json.array!(@contributions) do |contribution|
  json.extract! contribution, :id, :contr_type, :contr_subtype, :content, :user_id, :url, :upvote, :parent_id
  json.url contribution_url(contribution, format: :json)
end
