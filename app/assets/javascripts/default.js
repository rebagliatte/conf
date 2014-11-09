//= require jquery
//= require smooth_scroll

// Teaser Video
var openTeaserVideo = function() {
  source = $('#play-teaser-video').data('videoSource');
  source += '&autoplay=1';
  $('#video-player').attr('src', source);
  $('#teaser-modal').removeClass('hidden');
};

var closeTeaserVideo = function() {
  $('#video-player').attr('src','');
  $('#teaser-modal').addClass('hidden');
};

$('#play-teaser-video').on('click', function(e){
  e.preventDefault();
  e.stopPropagation();
  openTeaserVideo();
});

$('#teaser-modal').on('click', function(e){
  e.stopPropagation();
  closeTeaserVideo();
});

$(document).keydown(function(e) {
  if (e.keyCode == 27) {
    closeTeaserVideo();
  }
});
