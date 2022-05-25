/* global kakao */
import subway from "@/assets/subway.png";
import house from "@/assets/house.png";
import coffee from "@/assets/starbucks.png";
var map;
var markers = [];
var subways = [];
var starbucks = []; // eslint-disable-line no-unused-vars
var mapContainer;
var mapOption;
var starbuckmarker = [];
var subwaysmarker = [];
function getMarker(items) {
  if (markers.length > 0) {
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
function first() {
  mapContainer = document.getElementById("map");
  // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(37.554648, 126.972559), // 지도의 중심좌표
    level: 4, // 지도의 확대 레벨
  };
  // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
  map = new kakao.maps.Map(mapContainer, mapOption);
  createCoffeeMarkers(); // 커피숍 마커를 생성하고 커피숍 마커 배열에 추가합니다
  createSubwayMarkers(); // 편의점 마커를 생성하고 편의점 마커 배열에 추가합니다
  setStoreMarkers(null);
  setCoffeeMarkers(null);
}
function subwayStore(item) {
  subways = item;
}

function starbucksStore(item) {
  starbucks = item;
  first();
}
function createCoffeeMarkers() {
  var imageSrc = coffee;
  for (var i = 0; i < starbucks.length; i++) {
    var imageSize = new kakao.maps.Size(35, 35);
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: new kakao.maps.LatLng(starbucks[i].lng, starbucks[i].let), // 마커를 표시할 위치
      image: markerImage, // 마커 이미지
    });

    // 생성된 마커를 커피숍 마커 배열에 추가합니다
    starbuckmarker.push(marker);
  }
}
function createSubwayMarkers() {
  var imageSrc = subway;
  for (var i = 0; i < subways.length; i++) {
    var imageSize = new kakao.maps.Size(35, 35);
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: new kakao.maps.LatLng(subways[i].lat, subways[i].lng), // 마커를 표시할 위치
      image: markerImage, // 마커 이미지
    });

    // 생성된 마커를 커피숍 마커 배열에 추가합니다
    subwaysmarker.push(marker);
  }
}
function setCoffeeMarkers(data) {
  for (var i = 0; i < starbuckmarker.length; i++) {
    starbuckmarker[i].setMap(data);
  }
}
function setStoreMarkers(data) {
  for (var i = 0; i < subwaysmarker.length; i++) {
    subwaysmarker[i].setMap(data);
  }
}

function changeMarker(type) {
  var coffeeMenu = document.getElementById("coffeeMenu");
  var subwayMenu = document.getElementById("subwayMenu");
  var allMenu = document.getElementById("allMenu");
  // 커피숍 카테고리가 클릭됐을 때
  if (type === "coffee") {
    // 커피숍 카테고리를 선택된 스타일로 변경하고
    coffeeMenu.className = "menu_selected";

    // 편의점과 주차장 카테고리는 선택되지 않은 스타일로 바꿉니다

    // 커피숍 마커들만 지도에 표시하도록 설정합니다
    setCoffeeMarkers(map);
  } else if (type === "subway") {
    // 편의점 카테고리가 클릭됐을 때

    // 편의점 카테고리를 선택된 스타일로 변경하고
    subwayMenu.className = "menu_selected";
    allMenu.className = "";

    // 편의점 마커들만 지도에 표시하도록 설정합니다

    setStoreMarkers(map);
  } else if (type === "all") {
    allMenu.className = "menu_selected";
    subwayMenu.className = "menu_selected";
    coffeeMenu.className = "menu_selected";
    setCoffeeMarkers(map);
    setStoreMarkers(map);
  }
}
export {
  getMarker,
  starbucksStore,
  subwayStore,
  changeMarker,
  setCoffeeMarkers,
  setStoreMarkers,
};
