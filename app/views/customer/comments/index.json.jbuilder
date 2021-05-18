json.total @result[:total]
json.last_page @result[:last_page]
json.page @result[:page]
json.data @result[:data] do |comment|
  json.partial! "comment", comment: comment
end
