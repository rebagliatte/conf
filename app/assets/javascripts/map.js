var geocoder;
var map;

function initialize() {
  geocoder = new google.maps.Geocoder();
  var mapOptions = {
    zoom: 13,
    scrollwheel: false
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  codeAddress(window.venue_location);
}

function codeAddress(address) {
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
          title: address
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
