var geocoder;
var map;
var venue_address = window.venue_address;
var venue_lat = window.venue_latitude;
var venue_long = window.venue_longitude;

function initialize() {
  // Check if coordinates are available
  coordinates_available = venue_lat != null && venue_long != null

  // Set map options
  var mapOptions = {
    zoom: 13,
    scrollwheel: false
  };

  // Instantiate the map
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  // Center the map
  if (coordinates_available) {
    map.setCenter(new google.maps.LatLng(venue_lat,venue_long));
    placeMarker(map);
  } else {
    geocoder = new google.maps.Geocoder();
    codeAddress(venue_address);
  }
}

// Get latitude and longitude from the venue_location
function codeAddress(address) {
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      placeMarker(map);
    } else {
      console.log('Geocode was not successful for the following reason: ' + status);
    }
  });
}

// Place a marker
function placeMarker(map) {
  new google.maps.Marker({
    map: map,
    position: map.center,
    title: venue_address
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
