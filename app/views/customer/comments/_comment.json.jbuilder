json.id comment.id
json.content comment.content
json.edited comment.edited
json.created_at comment.created_at
json.thread_id comment.thread_id
json.parent_id comment.parent_id
json.likes comment.feedbacks.select(&:positive).count
json.dislikes comment.feedbacks.reject(&:positive).count

json.partial! 'comment-feedback', comment: comment
json.partial! 'comment-user', user: comment.user

json.children comment.children do |children|
  json.id children.id
  json.content children.content
  json.edited children.edited
  json.created_at children.created_at
  json.thread_id children.thread_id
  json.parent_id children.parent_id
  json.partial! 'comment-user', user: children.user
  json.partial! 'comment-feedback', comment: children
end
