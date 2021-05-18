json.likes comment.feedbacks.select {|f| f.positive}.count
json.dislikes comment.feedbacks.reject {|f| f.positive}.count

if user_signed_in?
  current_user_feedback = comment.feedbacks.find { |feedback| feedback.user_id == current_user.id }
  if current_user_feedback
    json.liked_by_current_user current_user_feedback.positive
    json.disliked_by_current_user !current_user_feedback.positive
  end
end