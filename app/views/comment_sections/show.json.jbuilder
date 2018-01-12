

#Para agregar un comentario por AJAX estoy tomando estos valores pero tambien se peuden los anteriores
json.extract! @comment, :id, :body, :prv_comment, :created_at
json.extract! @comment.user, :name
