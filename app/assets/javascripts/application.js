// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.turbolinks
//= require cocoon
//= require popper
//= require bootstrap-sprockets
//= require_tree .
//= require turbolinks



// bootstrap tooltip
$(function () {
  $('[data-toggle="tooltip"]').tooltip();
});


// 投稿する画像をプレビュー
function inputImagePreview (input) {
  var file = $(input).prop('files')[0]
  console.log(file);
  if(!file.type.match(/^image\/(jpeg|png|gif)$/)) {
    $(this).val('');
    return;
  }
  var reader = new FileReader();
  reader.onload = function() {
    var img_uri = reader.result;
    $.when($(input).parents('.post-image-frame').fadeTo(200, 0)
    ).done(function(){
      $(input).parents('.post-image-frame').css('background-image', 'url(' + img_uri + ')').fadeTo(700, 1);
    });
  }
  reader.readAsDataURL(file);
}
