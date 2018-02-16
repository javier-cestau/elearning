function InitializeTinymiceEditor(){
  tinymce.init({
    selector: 'textarea',
    height: 500,
    plugins: "link image imagetools",
    imagetools_cors_hosts: ['localhost:3000'],
    toolbar:  ['bold italic underline strikethrough link | alignleft aligncenter alignright alignfull | custom-image',
    ' bullist numlist outdent indent cut copy paste undo redo'],
    menubar: false,

    setup: function (editor) {
      editor.addButton('custom-image', {
        tooltip: 'Subir imagenes',
        icon: 'image',
        onclick: function () {
          $('#modal-image').modal('open');
        }
      });
    }
  });

  $("#images").on("click", "button", function(){

      var name = ($(this).attr("name"));
      varhtml = "<p style='font-size: 25px'> #image{"+$(this).attr("value")+"/"+name+"} </p>";
      tinyMCE.activeEditor.dom.add(tinyMCE.activeEditor.getBody(), 'p',{}, html);
      $('#modal-image').modal('close');

  });

}
