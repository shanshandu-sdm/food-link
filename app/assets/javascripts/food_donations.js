// Code goes here

$(document).on('turbolinks:load', function() {

  var map = null;
  var myMarker;
  var myLatlng;

  function initializeGMap(lat, lng, id) {
    myLatlng = new google.maps.LatLng(lat, lng);

    var myOptions = {
      zoom: 14,
      zoomControl: true,
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    id = "map_canvas" + id;
    map = new google.maps.Map(document.getElementById(id), myOptions);

    myMarker = new google.maps.Marker({
      position: myLatlng
    });
    myMarker.setMap(map);
  }

  // Re-init map before show modal
  $('.modal').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    initializeGMap(button.data('lat'), button.data('lng'), button.data('id'));
    $("#location-map").css("width", "100%");
    $("#map_canvas").css("width", "100%");
  });

  // Trigger map resize event after modal shown
  $('.modal').on('show.bs.modal', function() {
    google.maps.event.trigger(map, "resize");
    map.setCenter(myLatlng);
  });
});
