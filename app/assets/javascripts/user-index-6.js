

document.addEventListener("turbolinks:load", function(){


	if(PageFile == 6){


		$("#form-user-search > input[name='utf8']").remove();
		$("#form-user-search > input[name='commit']").attr("name", "");
		//Deshabilitar y habilitar a un talento
		$(".lever").click(function(e){

			var email_state = e.target.id;
			var input = $("input[name='"+email_state+"']");

			var email = email_state.split("/")[0];
			var old_state = email_state.split("/")[1];

			var new_state = null;

			if (old_state == "0"){
				new_state = "1";
			}
			else{
				new_state = "0";
			}

				$.ajax({

					url : '/admin/talents/change_state?email='+email+"&state="+new_state,
					type : 'get',
					dataType:'json',
					success : function(data) {
						console.log("Cambiado exitosamente");
						input.attr("name",email+"/"+new_state);
						$("span[id='"+email+"/"+old_state+"']").attr("id",email+"/"+new_state);
					},
					error : function(request,error)
					{

							console.log(request);
							console.log(error);
					}
				});

		});


	}


});
