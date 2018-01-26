/*jshint esversion: 6 */


document.addEventListener("turbolinks:load", function(){

    var id_course;

    function  GetCourseId(){
      try{
        id_course = $(location).attr('href').split("/courses/")[1].split("/edit")[0];
      }
      catch(exe){}
    }
    function InitializeButtonInModal(){
        //Agregar Videos o subirlos

        $("#video-btn").click(function(){
            // Se toman el archivo
            var file = $("#input-file-video")[0].files[0];
            var data = new FormData();
            data.append("multimedia[video]",file);
            jQuery.ajax({
                url: '/admin/courses/'+id_course+'/multimedia_courses',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST'


            });

            $('#modal-video').modal('close');
            alert("Se le notificará cuando el video este listo para su uso.");
        });

        $("#image-form").fileupload({
            dataType: 'json',
            done: function (e, data) {
                var id_image = data.result[0].id;
                var name = data.result[0].name;
                var html = '<li class="collection-item avatar">' +
                    '<a>' +
                    '<img class="circle" src=" /system/multimedia_courses/images/course_'+id_course+'/' + id_image + '/medium/' + name + '">' +
                    '</a>' +
                    '<span class="title">' +
                    name +
                    '</span>' +
                    '<div class="secondary-content">' +
                    '<button class="btn" name="' + name + '" value="' + id_image + '">' +
                    'Agregar' +
                    '</button>' +
                    '<p  class="btn red" data-method="delete" data_id="'+id_image+'">' +
                    'Eliminar' +
                    '</div>' +
                    '</a>' +
                    '</div>' +
                    '</li>';
                $("#images").append(html);


                $("#images").on("click", "p[data-method='delete']", function (event){

                    id = $(this).attr("data_id");
                    jQuery.ajax({
                        url: "/admin/courses/"+id_course+"/multimedia_courses/"+id,
                        cache: false,
                        contentType: false,
                        processData: false,
                        type: 'DELETE',
                        success: function () {
                            event.target.parentElement.parentElement.remove();
                        },
                        error: function () {
                            console.log("files error");
                        }
                    });
                });
            },
            fail: function(data,er){
              console.log(data);
              console.log(er);
              alert("La imagen debe de ser con extensión  .jpg, .jpeg , .png y .gif");
            },
            // Indica la cantidad que se ha subido
            progressall: function(e, data){
              console.log(data.loaded);
              console.log(data.total);
            }
        });

        $("#images").on("click", "p[data-method='delete']", function (event){

            id = $(this).attr("data_id");
            jQuery.ajax({
                url: "/admin/courses/"+id_course+"/multimedia_courses/"+id,
                cache: false,
                contentType: false,
                processData: false,
                type: 'DELETE',
                success: function () {

                    event.target.parentElement.parentElement.remove();
                },
                error: function () {
                    console.log("files error");
                }
            });
        });

        // Agregar el tag al editor de Froala
        $("#videos").on("click", "button", function(){

            var name = ($(this).attr("name"));
            let html = "<p style='font-size: 25px'> #video{"+$(this).attr("value")+"/"+name+"} </p>";
            $(".fr-view").append(html);
            $('#modal-video').modal('close');

        });



        $(".indeterminate").click(function (e) {
                var id = e.target.id.split("_")[1]+"_"+e.target.id.split("_")[2];
                $("#"+id+"_input").prop("value", "Indeterminada");

            });
        }
    function InitializeModals(){

        $('.modal').modal();

        $("#deadline_course").click(function(){
            $('#deadline_course_modal').modal('open');
        });

        $("#deadline_inscription").click(function(){
            $('#deadline_inscription_modal').modal('open');
        });
        $("#start_date").click(function(){
            $('#start_date_modal').modal('open');
        });

        InitializeButtonInModal();

    }

    function InitializeCourseButtons(){

        //  Boton de buscar usuarios
        $("#users").on("click" ,"#btn-search-users",function(){

            let option = $('input[name=search_user]:checked').val();
            searching_for =  $("#search_user").val();
            $.ajax({

                url : '/admin/search/talents?option='+option+"&search="+searching_for,
                type : 'get',
                dataType:'json',

                success : function(data) {
                    var length = data.users.length;
                    $("#list-search-users").empty();
                    if ( length > 0){

                        for (var i = 0; i < length; i++) {
                            // se toma el id y el nombre del curso
                            var id = data.users[i].id;
                            var name= data.users[i].name;
                            var email = data.users[i].email;
                            var privilege = data.users[i].privilege;
                            var icon_user = data.users[i].url;
                            background_color = "blue-grey lighten-1";


                            var search_list =  ' <li class="collection-item avatar" id="li_user_search'+id+'" >'+
                                '  <img src='+icon_user+' class="circle"/>'+
                                '  <span class="title">'+
                                email+
                                '  </span>'+
                                '  <p>'+
                                name+
                                '  </p>'+
                                '  <div class="secondary-content">'+
                                '    <a class="btn " id="search_user'+id+'">Agregar</a>'+
                                '  </div>'+
                                ' </li>';

                            // se agrega un usuario en la lista
                            $("#list-search-users").append(search_list);
                            //Se crean las funcionalidades los clicks de cada elemento de la lista
                            var function_anonym = function(){
                                let id_u = id;

                                var search_list =  ' <li class="collection-item avatar" id="li_user'+id_u+'" >'+
                                '  <img src='+icon_user+' class="circle"/>'+

                                    email+
                                    '  </span>'+
                                    '  <p>'+
                                    name+
                                    '  </p>'+
                                    '  <div class="secondary-content">'+
                                    '    <a class="btn red lighten-2" id="user'+id_u+'">Eliminar</a>'+
                                    '  </div>'+
                                    ' </li>';
                                // la funcion one es para que cuando se haga click se elimine el evento automaticamente
                                // Se agrega a la lista de buscado
                                $("#list-search-users").one("click" ,"#search_user"+id,function(){
                                    $(".no-one").remove();

                                    //  Si hace click se elimina de la lista
                                    $("#li_user_search"+id_u).remove();
                                    let length_text = $("#user-list #user"+id_u).text().length ;
                                    //  se toma en cuenta si ya existe el elemento en la lista de usuarios para no volver a agregarlo
                                    if (length_text ==  0){
                                        // se agrega a la lista de prelaciones  y ademas se agrega un input al form principal
                                        $("#users_inputs").append("<input name='users[]' value='"+id_u+"'  type='hidden' id='i_user"+id_u+"'>");
                                        $("#user-list").append(search_list);
                                        // Para borrar si hace click en el elemento en la prelacion se borrar el input que se agrego en el form y se elimina el elemento de la lista
                                        $("#user-list").one("click" ,"#user"+id_u,function(){
                                            $("#i_user"+id_u).remove();
                                            $("#li_user"+id_u).remove();

                                        });
                                    }


                                });
                            }();

                        }
                    }
                    // Si no se encontraron usuarios se muestra un mensaje indicandolo
                    else{

                        $("#list-search-users").append(" <li class='list-group-item list-group-item-danger'>No se encontró ningún talento</li>");
                    }

                },
                error : function(request,error)
                {
                    console.log(request);
                }
            });
        });

        // Agregar tags
        $("#btn-add-tag").click(function(){

            var tag = $("#add_tag").val().trim();
            if(tag.length > 0){
              // debido a que los ID no aceptan espacios se deben cambiar dichos espacios por "-"
                tag = tag.replace(/\s+/g, "-");


                // se comprueba si existe el tag
                if($("#"+tag).text().length === 0){

                    var html =   '<span class="new badge grey lighten-1" data-badge-caption="'+tag+'" id="'+tag+'" name="tag[]" type="hidden" value="'+tag+'">'+
                        '   <i class="fa fa-times"></i>'+
                        '</span>';

                    $("#tag_inputs").append("<input name='tag[]' value='"+tag+"'  type='hidden' id='i_tag_course"+tag+"'>");

                    $("#tags-list").append(html);

                    $("#tags-list").one("click" ,"#"+tag,function(){
                        $("#"+tag).remove();
                        $("#i_tag_course"+tag).remove();
                    });

                }
            }
            $("#add_tag").val(" ");

        });



        // Cargar los departamentos desde un parcial
        $('#scoping-list').change(function() {
            var index = $(this)[0].selectedIndex;
            if(index >= 0 && index <= 2){
                $("#departments > .jumbotron").remove();
                $("#users > .row").remove();
                $("#users_inputs > input").remove();

                if(index == 1){

                    $.ajax({

                        url : '/admin/courses/departments',
                        type : 'get',
                        dataType:'html',
                        success : function(data) {
                            //  Se debe hacer un split debido a que lo devuelve con un tag <form> y solo se debera usar lo que esta dentro de dicho tag
                            let departments = "<div class='jumbotron'>"+data.split("<div class='jumbotron'>")[1];
                            departments = departments.split("</form>")[0];
                            $("#departments").append(departments);
                        },
                        error : function(request,error)
                        {
                            console.log(request);
                        }
                    });
                }
                else{
                    if(index == 2){
                        $.ajax({

                            url : '/admin/courses/users',
                            type : 'get',
                            dataType:'html',
                            success : function(data) {
                                let users = data;
                                $("#users").append(users);
                            },
                            error : function(request,error)
                            {
                                console.log(request);
                            }
                        });
                    }
                }


            }
        });

    }
    function InitializeScopingCourse(){


        //Para cargar por defecto los departamentos o usuarios segun el scoping del curso


        var index = $("#scoping-list")[0].selectedIndex;
        if(index >= 0 && index <= 2){
            $("#departments > .jumbotron").remove();
            $("#users > .jumbotron").remove();
            $("#users_inputs > div").remove();

            if(index == 1){

                $.ajax({

                    url : '/admin/courses/departments?id='+id_course,
                    type : 'get',
                    dataType:'html',
                    success : function(data) {
                        //  Se debe hacer un split debido a que lo devuelve con un tag <form> y solo se debera usar lo que esta dentro de dicho tag
                        let departments = "<div class='jumbotron'>"+data.split("<div class='jumbotron'>")[1];
                        departments = departments.split("</form>")[0];


                        $("#departments").append(departments);
                    },
                    error : function(request,error)
                    {
                        console.log(request);
                    }
                });
            }
            else{
                if(index == 2){
                    $.ajax({

                        url : '/admin/courses/users?id='+id_course,
                        type : 'get',
                        dataType:'html',
                        success : function(data) {
                            let users = data;
                            $("#users").append(users);

                            $("#user-list > .collection-item > .secondary-content ").on("click",".delete-user",function(e){

                                var id = e.target.id;
                                $("#i_"+id).remove();
                                $("#li_"+id).remove();
                            });

                        },
                        error : function(request,error)
                        {

                            console.log(request);
                            console.log(error);
                        }
                    });
                }
            }


        }

    }
    function InitializePrelationsAndTagsItem(){
        $("#prelation").on("click" ,"li",function(){
            let id = $(this).attr("id").split("prel_course")[1];
            $("#i_prela_course"+id).remove();
            $("#prel_course"+id).remove();
        });
        //Agregar la opcion de eliminar en los tags cargados directos desde el curso
        $("#tags-list").on("click" ,"span",function(){
            $("#"+$(this).attr("value")).remove();
            $("#i_tag_course"+$(this).attr("value")).remove();
        });
    }
    function InitializeSearchPrelation() {
        // Si no hubo ningun error en el servidor al momento de enviar las busqueda de los nombres de los cursos se activara esta funcion
        $(document).on ("ajax:success", "#prelation-form", function (ev,data){
            // Se toma el tamano del arreglo para saber cuando cursos se encontraron
            var length = data.courses.length;
            // Se vacia la lista primero
            $("#list-search-courses").empty();

            // Si se encuentran se muestran
            if ( length > 0){

                for (var i = 0; i < length; i++) {
                    // se toma el id y el nombre del curso
                    let name = data.courses[i].name;
                    let id = data.courses[i].id;
                    var cover = data.courses[i].cover_file_name;

                    if (cover === null){
                        cover = '<i class="material-icons circle red">'+
                            ' <i class="fa fa-book"></i>'+
                            '</i>';
                    }
                    else{

                        cover = '<img class="circle" id="img_c_'+id+'" src=" /system/cover/course_'+id+'/small/'+cover+'">';
                    }

                    var html =  '  <li class="collection-item avatar" id="search_course'+id+'">'+
                        cover+
                        '       <br>'+
                        '        <span class="title">'+name+'</span>'+
                        '      </li>';
                    // se agrega un curso en la lista
                    $("#list-search-courses").append(html);

                        // la funcion one es para que cuando se haga click se elimine el evento automaticamente
                        // Se agrega a la lista de buscado
                        $("#list-search-courses").one("click" ,"#search_course"+id,function(){
                            //  Si hace click se elimina de la lista
                            $(".no-prelation").remove();
                            var img_src = $("#img_c_"+id).prop("src");
                            $("#search_course"+id).remove();
                            let length_text = $("#prel_course"+id).text().length ;
                            //  se toma en cuenta si ya existe el elemento en la lista de prelaciones para no volver a agregarlo
                            if (length_text ===  0){

                                // se agrega a la lista de prelaciones  y ademas se agrega un input al form principal
                                $("#prelation_inputs").append("<input name='prelation[]' value='"+id+"'  type='hidden' id='i_prela_course"+id+"'>");

                                var cover = "<img class='circle' src='"+img_src+"'>";

                                if (undefined === img_src) {
                                    cover = '  <i class="material-icons circle red">' +
                                        '    <i class="fa fa-book"></i>' +
                                        '  </i>';
                                }

                                var html_course_prelation =   '<li class="collection-item avatar" id="prel_course'+id+'">'+
                                    cover+
                                    '  <span class="title">'+
                                    name+
                                    '  </span>'+
                                    '  <div class="secondary-content">'+
                                    '    <i class="material-icons">'+
                                    '      <i class="fa fa-close"></i>'+
                                    '    </i>'+
                                    '    </div>'+
                                    '</li>';

                                $("#prelation").append(html_course_prelation);
                                // Para borrar si hace click en el elemento en la prelacion se borrar el input que se agrego en el form y se elimina el elemento de la lista
                                $("#prelation").one("click" ,"#prel_course"+id,function(){
                                    $("#i_prela_course"+id).remove();
                                    $("#prel_course"+id).remove();
                                });
                            }
                        });
                }
            }
            else{

                // Si no se encontraron cursos se muestra un mensaje indicandolo
                $("#list-search-courses").append(" <li class='list-group-item list-group-item-danger'>No se encontró ningún curso</li>");
            }

        });
        // Cuando la peticion por AJAX al servidor fue erronea , Generalmente seran por problemas internos del servidor si se da el caso
        $(document).on ("ajax:error", "#prelation-form", function (ev,data){
            console.log("error");
            console.log( data );
        });




    }
    function IntializeDatePicker(){
        $('.datepicker').pickadate({
            selectMonths: false, // Creates a dropdown to control month
            selectYears: 15, // Creates a dropdown of 15 years to control year
            formatSubmit: 'yyyy-mm-dd',
            format: 'mmmm d, yyyy',
            hiddenSuffix: "",
            today: 'Hoy',
            min: new Date(),
            clear: 'Indeterminado',
            close: 'Cerrar',
            monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            monthsShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            weekdaysFull: ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'],
            weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
        });


    }
    function IniatilizeComponentsCourse(){

        // Enviar el Form principal
        $("#submit-form").click(function(){
            if ( $( "#course-name" ).val().length  > 10 ) {
              $("#start_date_input_hidden").val($("#start_date > input:first-child").attr('value'))
              $("#deadline_course_input_hidden").val($("#deadline_course > input:first-child").attr('value'))
              $("#deadline_inscription_input_hidden").val($("#deadline_inscription > input:first-child").attr('value'))
              $("#form-course").submit();
            }
            else{

                $("#course-name").addClass('invalid');

                $("#page-content-wrapper").scrollTo(0,0);

            }
        });


        GetCourseId();
        InitializeModals();
        IntializeDatePicker();
        InitializeTinymiceEditor();
        InitializeCourseButtons();
        InitializeScopingCourse();
        InitializePrelationsAndTagsItem();
        InitializeSearchPrelation();
    }



    // Se comprueba si esta en alguna de las dos paginas de course sea NEW o EDIT
    if( PageFile == 2 )
    {
        IniatilizeComponentsCourse();

   }

});
