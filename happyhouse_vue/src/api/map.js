/* global kakao */
var map;
var markers = [];
var mapContainer;
var mapOption;
function getMarker(items) {
  if (markers.length > 0) {
    console.log(markers.length);
    markers.forEach((item) => {
      item.setMap(null);
    });
    markers = [];
  }

  var imageSrc =
    "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
  for (var i = 0; i < items.length; i++) {
    var imageSize = new kakao.maps.Size(24, 35);
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: new kakao.maps.LatLng(items[i].lat, items[i].lng), // 마커를 표시할 위치
      title: items[i].aptName, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image: markerImage, // 마커 이미지
    });
    markers[i] = marker;
  }
  if (markers.length > 0) {
    markers.forEach((item) => {
      item.setMap(map);
    });
  }
  // return markers;
}
function first() {
  mapContainer = document.getElementById("map");
  // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(37.554648, 126.972559), // 지도의 중심좌표
    level: 10, // 지도의 확대 레벨
  };

  // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
  map = new kakao.maps.Map(mapContainer, mapOption);
}
export { getMarker, first };
