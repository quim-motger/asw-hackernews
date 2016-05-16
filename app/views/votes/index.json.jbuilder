json.array!(@votes) do |vote|
  json.extract! vote, :id, :user_id, :contribution_id
  json.url url_for
end
