/*jshint esversion: 6 */

			$(document).on ("ajax:error", "#comment-form-section", function (ev,data){
				console.log(ev);
			});
			$(document).on ("ajax:success", "#comment-form-section", function (ev,data){

				$("#comment-form-section textarea").val("");

				var name = data.name;
				var comment_id = data.id;

				if($("#comment-"+comment_id).length === 0)
				{
					var body = data.body;
					var id_section = $(location).attr('href').split("/sections/")[1].split("?")[0];
					var prv_comment = data.prv_comment;
					var created_at = data.created_at;
					var class_admin =  "by-author";

					if (user_privilege == "1")
					{
						class_admin = "";
					}

					var style_reply = 'style="left: 97px"';
					var icon_reply = '';
					if(prv_comment === null){
						style_reply = "";
						icon_reply = '<i class="fa fa-reply" id="comment-'+comment_id+'""></i>';
					}

					id_course = $(location).attr('href').split("/courses/")[1].split("/sections")[0];
					var html = '<li>'+
												'<div class="comment-main-level">'+
													'<div class="comment-avatar"'+style_reply+'>'+
														'<img alt="" src="'+user_image_url+'">'+
													'</div>'+
													'<div class="comment-box">'+
														'<div class="comment-head">'+
															'<h6 class="'+class_admin+' comment-name">'+
																'<span class="black-text">'+name+'</span>'+
															'</h6>'+
															'<span datetime="'+created_at+'" class="timeago timeago-'+comment_id+'">hace unos instantes</span>'+
															icon_reply+
															'<i class="fa fa-close destroy" href="/courses/'+id_course+'/sections/'+id_section+'/comment_sections/'+comment_id+'"></i>'+
														'</div>'+
														'<div class="comment-content">'+
															body+
														'</div>'+
													'</div>'+
												'</div>'+
												'<ul class="comments-list reply-list" id="reply-comments-box-'+comment_id+'">'+
												'</ul>'+
											'</li>';


					if(prv_comment === null){

						$("#comments-list").prepend(html);
					}
					else{
						$(".li-textarea-"+prv_comment).remove();
						$("#reply-comments-box-"+prv_comment).append(html);

					}



					InitializeAjaxResponseCommentSection();

					$("i.destroy").prop('onclick',null).off('click');
					$('i.destroy').on('click', function(e) {
						 e.preventDefault();
						 var $el      = $(this);
						 var li_element = $(this).parents("li")[0];
						 var response = confirm($el.data('confirm') || '¿Esta seguro?');
						 if (!response) { return; }

						 $.ajax({
								 url:  $el.attr('href'),
								 type: 'DELETE',
								 data: {_method: 'delete'},
								 success: function(data){
									 li_element.remove();
								 }
							 });

					});
				}
			});


			function InitializeAjaxResponseCommentSection(){

			$("i.fa-reply").prop('onclick',null).off('click');



			$('i.fa-reply').on('click', function(e,data) {
				 //  e.preventDefault();
				 var $el      = $(this);
				 var id_comment = this.id.split("-")[1];
				 var id_section = GetsectionId();
				 var id_course = $(location).attr('href').split("/courses/")[1].split("/sections")[0];


				 if($(".comment-reply-form-"+id_comment).length === 0){

				 var html = '<li class="li-textarea-'+id_comment+' align-text">'+
		 									'<div class="comment-main-level">'+
		 										'<div class="comment-avatar" style="left: 97px">'+
		 											'<img alt="" src="'+user_image_url+'">'+
		 										'</div>'+
												'<div class="comment-box">';
		 		 html += '<form data-type="json" id="comment-form-section" novalidate="novalidate" class="simple_form new_comment_section comment-reply-form-'+id_comment+'" action="/courses/'+id_course+'/sections/'+id_section+'/comment_sections?child_of='+id_comment+'" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" value="✓" type="hidden"><div class="row">'+
		 									'<div class="input-field col s12 ">'+
		 										'<div class="form-group text optional comment_section_body"><textarea class="form-control text optional text-area-comment " placeholder="Añade un comentario..." name="comment_section[body]" id="comment_section_body"></textarea></div>'+
													"<br>"+
		 											'<input name="commit" value="Comentar" class="btn grey lighten-3 black-text" data-disable-with="Comentar" type="submit">'+
		 										'</div>'+
		 									'</div>'+
		 							'</form>'+
		 						'</div>'+
		 					'</div>'+
		 				'</li>';

					$("#reply-comments-box-"+id_comment).append(html);

					try{
						var comment = $("#reply-comments-box-"+id_comment+" > li:last-child");
						if( comment.length !== 0){
							$("html, body").animate({
								scrollTop: comment.offset().top
							}, 1500);
						}
					}catch(err){}
				}
			});

		}

		function  GetsectionId(){
			id_section = $(location).attr('href').split("/sections/")[1].split("?")[0];
			return id_section;
		}


document.addEventListener("turbolinks:load", function(){



		function ShowCommentHighligthed(){

			try{
				var commentHigh_id =   $(location).attr('href').split("comment=")[1].split("&")[0];
				console.log(commentHigh_id);
				var comment = $("#comment-"+commentHigh_id);
				if( comment.length !== 0){
					$("html, body").animate({
						scrollTop: comment.offset().top
					}, 1500);
				}
			}catch(err){}
		}

		function IniatilizeComponentsSectionShow(){

			InitializeAjaxResponseCommentSection();
			ShowCommentHighligthed();
			$('i.destroy').on('click', function(e) {
				var $el      = $(this);
				var li_element = $(this).parents("li")[0];
				$('#dialog-confirm').dialog({
					 resizable: false,
					 height: 'auto',
					 width: 400,
					 modal: true,
					 buttons: {
						 'Aceptar': function() {
							 $.ajax({
						       url:  $el.attr('href'),
						       type: 'DELETE',
						       data: {_method: 'delete'},
									 success: function(data){
										 li_element.remove();
									 }
						     });
							 $(this).dialog('close');
						 },
						 "Cancelar": function() {
							 $(this).dialog('close');
						 }
					 }
					});
				});



		}
		// Se comprueba si esta en alguna de las dos paginas de section sea SHOW
		if( PageFile == 9 )
		{
				IniatilizeComponentsSectionShow();

	 }
});
