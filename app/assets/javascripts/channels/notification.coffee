App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    AddNotificationCounter()
    Materialize.toast('Tiene una notificación nueva', 3000)
    if !json_notification?
      temp_json = {"notifications": Array()}
      temp_json["notifications"][0] =  {

                      "id": data.notification.id
                      "message": data.notification.message
                      "url": data.notification.url
                      "date": data.notification.date
                      "read": 0
                  }

      $.each json_notifications.notifications, (index,val) ->
        # eliminar y agregar las ultimas notificaciones
        if(index+1 < 5)
          temp_json.notifications[index+1] = val
      window.json_notifications = temp_json
      $(".notification").removeClass("active")
