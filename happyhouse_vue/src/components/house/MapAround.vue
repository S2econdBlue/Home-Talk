<template>
  <div>
    <div>
      <b-row class="mt-4 mb-4 text-center">
        <b-col>
          <b-button block variant="primary" @click="makeMarker"
            >시세 조회 하기</b-button
          >
        </b-col>
      </b-row>
    </div>
    <div id="map"></div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import { getMarker } from "@/api/map";

export default {
  data() {
    return {
      map: null, // eslint-disable-line no-unused-vars
      markers: [],
    };
  },
  computed: {
    ...mapGetters(["checkhouse"]),
  },
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=c134421d6fa6f7922b8bfc742db52dbc";
      document.head.appendChild(script);
    }
  },
  methods: {
    initMap() {
      var mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(37.564343, 126.947613), // 지도의 중심좌표
          level: 10, // 지도의 확대 레벨
        };

      this.map = new kakao.maps.Map(mapContainer, mapOption); // eslint-disable-line no-unused-vars
    },
    makeMarker() {
      console.log(this.checkhouse);
      if (this.checkhouse.length > 0) {
        this.markers = getMarker(this.checkhouse, this.map);

        if (this.markers.length > 0) {
          this.markers.forEach((item) => {
            item.setMap(this.map);
          });
        }
      } else {
        alert("시 구 동 모두 선택해주세요");
      }
    },
  },
};
</script>

<style scoped>
#map {
  width: 1110px;
  height: 700px;
}
</style>
