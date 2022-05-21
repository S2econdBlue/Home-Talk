function getMarker(items, map) {
  /* global kakao */
  var markers = [];
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
    console.log(items.aptName);
    markers[i] = marker;
  }
  return markers;
}

export { getMarker };
// function makeprice(items) {
//   $(".sell").empty();
//   if (items.length == 0) {
//     $(".sell").append("<h2>거래내역이 없는 지역입니다.");
//   } else {
//     $.each(items, function (index, item) {
//       var chk = `
// 				<li>
// 				<fieldset>
// 				${item.aptName} 아파트<br>
// 				${item.dealAmount} 만원<br>
// 				${item.dongName}<br><br>
// 				<hr>
// 				<br>
// 				<button value="관심지역등록" onclick="registArea(${item.dongCode})">관심지역등록</button>
// 				<button value="이전거래기록보기" onclick="selectPrice(${item.aptCode})" >이전거래기록보기</button>
// 				<br>
// 				</fieldset>
// 				</li>
// 				`;
//       $(".sell").append(chk);
//       getMarker(items, "price");
//     });
//   }
// }
// function selectPrice(aptCode) {
//   $.ajax({
//     url: "/spring_happyhouse_stepbystep/Building/dealsearch",
//     data: { aptcode: aptCode },
//     type: "get",
//     dataType: "json",
//     success: function (response) {
//       makepricelists(response);
//     },
//     error: function (request, status, error) {
//       console.log("status : " + request.status + "\tmsg : " + error);
//     },
//   });
// }
// function makepricelists(items) {
//   $("#pricelist").empty();
//   var chk = `총거래횟수는 ` + items.length + `회 입니다 <br><br>`;
//   if (items.length == 0) {
//     $("#pricelist").append("<h2>거래내역이 없는 지역입니다.");
//   } else {
//     $.each(items, function (index, item) {
//       chk = `
// 				<li>
// 				<fieldset>
// 				크기 ${item.area} m3 /  ${item.floor} 층 /
// 				${item.dealYear}년.${item.dealMonth}월.${item.dealMonth}일 거래 /
// 				${item.dealAmount} 가격/
// 				${item.dealAmount} 만원
// 				</fieldset>
// 				</li>
// 				`;
//       $("#pricelist").append(chk);
//     });
//   }
// }

// function registArea(dongCode) {
//   $.ajax({
//     url: "/spring_happyhouse_stepbystep/Building/regist",
//     data: { regist: dongCode },
//     type: "POST",
//     dataType: "text",
//     success: function (response) {
//       console.log("regist 결과" + response);
//       alert("등록이 완료 되었습니다.");
//     },
//     error: function (request, status, error) {
//       console.log("status : " + request.status + "\tmsg : " + error);
//       alert("이미 등록된 지역입니다.");
//     },
//   });
// }
