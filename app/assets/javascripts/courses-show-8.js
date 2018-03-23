/*jshint esversion: 6 */

function stringToHTML(html) {
	var parser = new DOMParser()
	var doc = parser.parseFromString(html, "text/html");
	var html = doc.body.firstChild
	return html
}

function replyForm(){
		console.log(this);
		var id_comment = this.id.split("-")[1];
		var id_course =  location.pathname.split("/courses/")[1].split("?")[0];

		if(!!document.querySelector(".comment-reply-form-"+id_comment) == false){



		var html = stringToHTML(document.querySelector("#template-form").innerHTML)
		html.querySelector('form').action = "/courses/'+id_course+'/comment_courses?child_of="+id_comment
		html.querySelector('img').src = user_image_url

		 document.getElementById("reply-comments-box-"+id_comment).append(html);

		 try{
			 var comment = $("#reply-comments-box-"+id_comment+" > li:last-child");
			 if( comment.length !== 0){
				 $("html, body").animate({
					 scrollTop: comment.offset().top - 100
				 }, 500);
			 }
		 }catch(err){}
	 } else {
		 document.querySelector(".comment-reply-form-"+id_comment).closest(".comment-main-level").remove()
	 }
}
function destroyComment() {
	console.log(this);
	var li_element = this.closest("li")
	var response = confirm('¿Esta segduro?');
	if (!response) { return; }

		Rails.ajax({
			url:  this.getAttribute("href"),
			type: 'DELETE',
			success: function(data){
				li_element.remove();
			}
		});

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

		function IniatilizeComponentsCourseShow(){

			document.getElementById("comment-form").addEventListener("submit", function (e) {
				e.preventDefault()
				var target = e.currentTarget
				var formdata = new FormData()
				formdata.set("comment_course[body]",target["comment_course[body]"].value)
				Rails.ajax({
				    url: "/courses/2/comment_courses.json",
				    type: "POST",
						data: formdata,
				    success: function(data) {
							target.querySelector("#btn-comment").disabled = false
							document.querySelector("#comment-form textarea").value = "";
							var name = data.name;
							var comment_id = data.id;

							var body = data.body;
							console.log(data);
							var prv_comment = data.prv_comment;
							var created_at = data.created_at;
							var id_course = location.pathname.split("/courses/")[1].split("?")[0];
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
																	'<i class="fa fa-close destroy" href="/courses/'+id_course+'/comment_courses/'+comment_id+'"></i>'+
																'</div>'+
																'<div class="comment-content">'+
																	body+
																'</div>'+
															'</div>'+
														'</div>'+
														'<ul class="comments-list reply-list" id="reply-comments-box-'+comment_id+'">'+
														'</ul>'+
													'</li>';

							html = stringToHTML(html)
							html.querySelector(".fa-close").addEventListener('click', destroyComment);
							html.querySelector(".fa-reply").addEventListener('click',replyForm);
							console.log(html);
							console.log(prv_comment);
							if(prv_comment === null){
								var element = document.getElementById("comments-list")
                // Tomar la lista que se creo en la variable 'html'
								element.prepend(html);
							}
							else{
								var element = document.querySelector(".li-textarea-"+prv_comment)
								// Tomar la lista que se creo en la variable 'html'
								element.prepend(html);
							}
				    },
				    error: function(data) {
				      console.log(data);
				    }
				  });
				return true
			})

			ShowCommentHighligthed();

			document.querySelectorAll('i.destroy').forEach(function (element) {
				element.addEventListener('click', destroyComment);
			})
			document.querySelectorAll('i.fa-reply').forEach(function (element) {
				element.addEventListener('click', replyForm);
			})

		}
		// Se comprueba si esta en alguna de las dos paginas de course sea SHOW
		if( PageFile == 8 )
		{
				IniatilizeComponentsCourseShow();

	 }
});
