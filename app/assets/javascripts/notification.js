document.addEventListener("turbolinks:load", function(){



	function AppendNotification(data){
	  $(".progress-notifications").remove();
	  $(".no-notification").remove();

	  if(data.notifications.length === 0)
	  {

	     var html = '<li style="color: #7f8c8d;" class=" js-item no-notification">'+
	                '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspNo posee ninguna notificación'+
	                '</li>';
	    $(".notifications-list").append(html);

	    return null;
	  }

	  json_notifications = data;
	  $.each(data.notifications, function(index,val){

	    var date = jQuery.timeago(val.date);
	    var expired = "";
	    var strong = "strong";
	    if (val.read == "1"){
	      expired = "expired";
	      strong = "";
	    }
	    var url = "";
	  if (val.url.indexOf('?') > -1)
	  {
	    url = val.url+"&notification="+val.id;
	  }
	  else{
	    url = val.url+"?notification="+val.id;

	  }

	   var html = '<li class="item js-item '+expired+'">'+
	              '  <div class="details">'+
	              '    <a href="'+url+'">'+
	              '      <strong class="'+strong+'" id="notification-id-'+val.id+'">'+val.message+'</strong>'+
	              "     </a>"+
	              '      <span title="'+date+'" class="timeago">&nbsp&nbsp&nbsp&nbsp'+date+'</span>'+
	              "    </div>"+
	              '  <button class="button-default button-dismiss readed-notification js-dismiss" type="button" id="notification-id-delete-'+val.id+'">×</button>'+
	              "</li>";

	    $(".notifications-list").append(html);





			$(".notifications-list").on("click", "#notification-id-delete-"+val.id, function(event){
				var val_id = event.target.id.split("notification-id-delete-")[1];

				$.ajax({

						url : '/talent/notification/'+val_id,
						type : 'get',
						dataType:'json',
						success : function(data) {
							console.log("sucess");
							console.log(val_id);
							$.each(window.json_notifications.notifications, function (index,val){
								if (window.json_notifications.notifications[index].id == val_id)
								{
									window.json_notifications.notifications[index].read = 1;
								}
							});

							SubtractNotificationCounter();
							notification_id = event.target.id.split("notification-id-delete-")[1];
							if (!$("#notification-id-"+notification_id).parent("li").hasClass("expired"))
							{
								$("#notification-id-delete-"+notification_id).parent("li").addClass("expired");
								var html = $("#notification-id-"+notification_id).html();
								$("#notification-id-"+notification_id).parent("a").html(html);
							}
								 },
						error : function(request,error)
						{
							console.log("error");
						}
				});
			});



	  });

	  $(".notifications").on("click",".js-item > .details > a ", function(event){
	      notification_id = event.target.id.split("notification-id-")[1];
	      $.each(data.notifications, function(index,val){
	        if(String(val.id) === notification_id){
	          data.notifications[index].read = 1;
	        }
	      });

		});




	}

	function ClickNotification(){
			// Al hacer click mostrar las notificaciones


		var el = $(".notification");
		el.click( function(event)
		{

			el.addClass("red-materialize");
			$(".notifications").fadeIn(100,function(){
				$(this).focus();
			});
			if(json_notifications === undefined)
			{

					$(".notification").addClass("active");
				$.ajax({

						url : '/talent/'+user_id+'/notifications',
						type : 'get',
						dataType:'json',
						success : function(data) {
								 AppendNotification(data);
								 },
						error : function(request,error)
						{
							console.log("error");
						}
				});
			}
			else{
				if(!$(".notification").hasClass("active")){
					$(".notifications-list > li ").remove();
						$(".notification").addClass("active");
					AppendNotification(json_notifications);
				}
			}
		});

		// Al hacer click en cualquier otra parte cerrara las notificaciones
		$(".notifications").on('blur',function(event){
			$(this).fadeOut(100);
			el.removeClass("red-materialize");

		});

	}
	ClickNotification();

});
