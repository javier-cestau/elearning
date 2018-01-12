

#Para agregar un comentario por AJAX estoy tomando estos valores pero tambien se peuden los anteriores
if !@notifications.nil?
	json.notifications @notifications, :id, :message, :url, :date, :read
else
	json.status 200
end
