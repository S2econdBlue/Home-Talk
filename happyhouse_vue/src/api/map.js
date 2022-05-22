/* global kakao */
import subway from "@/assets/subway.png";
import house from "@/assets/house.png";
var map;
var markers = [];
var subways = [];
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
  var bounds = new kakao.maps.LatLngBounds();
  var imageSrc = house;
  for (var i = 0; i < items.length; i++) {
    var imageSize = new kakao.maps.Size(35, 35);
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: new kakao.maps.LatLng(items[i].lat, items[i].lng), // 마커를 표시할 위치
      title: items[i].aptName, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image: markerImage, // 마커 이미지
    });
    markers[i] = marker;
    bounds.extend(new kakao.maps.LatLng(items[i].lat, items[i].lng));
  }
  if (markers.length > 0) {
    markers.forEach((item) => {
      item.setMap(map);
    });
  }
  map.setBounds(bounds);
  // return markers;
}
function first(data) {
  mapContainer = document.getElementById("map");
  // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(37.554648, 126.972559), // 지도의 중심좌표
    level: 4, // 지도의 확대 레벨
  };
  // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
  map = new kakao.maps.Map(mapContainer, mapOption);

  var imageSrc = subway;
  for (var i = 0; i < data.length; i++) {
    var imageSize = new kakao.maps.Size(50, 50);
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: new kakao.maps.LatLng(data[i].lat, data[i].lng), // 마커를 표시할 위치
      title: data[i].name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image: markerImage, // 마커 이미지
    });
    subways[i] = marker;
  }
  if (subways.length > 0) {
    subways.forEach((item) => {
      item.setMap(map);
    });
  }
}
export { getMarker, first };
