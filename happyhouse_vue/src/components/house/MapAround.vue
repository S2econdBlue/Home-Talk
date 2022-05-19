<template>
  <div>
    <div id="map"></div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import EventBus from "@/main";
import http from "@/api/http";
export default {
  data() {
    return {
      map: null,
      markers: [],
    };
  },
  computed: {
    ...mapState(["guguns"]),
  },
  created() {
    EventBus.$off("change-guguns");
    EventBus.$on("change-guguns", this.makers);
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
    makers(guguns) {
      const params = { dong: guguns };

      if (this.markers.length > 0) {
        this.markers.forEach((item) => {
          item.setMap(null);
        });
      }
      this.markers = [];
      http
        .get(`/Building/around`, { params })
        .then(({ data }) => {
          for (var i = 0; i < data.length; i++) {
            const marker = new kakao.maps.Marker({
              title: data[i].businessName,
              position: new kakao.maps.LatLng(data[i].lng, data[i].let), // 마커의 좌표
              map: this.map, // 마커를 표시할 지도 객체
            });
            this.markers.push(marker);
          }
          console.log(this.markers.length);
        })
        .catch((error) => {
          console.log(error);
        });

      // console.log(this.map);
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
