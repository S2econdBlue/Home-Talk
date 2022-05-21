<template>
  <div>
    <div id="map"></div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import EventBus from "@/main";
import http from "@/api/http";
import { mapp } from "@/api/map";

export default {
  data() {
    return {
      map: null, // eslint-disable-line no-unused-vars
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
        "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=a2f4a46478459ad445c17d0692b5932b";
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

      http
        .get(`/Building/around`, { params })
        .then(({ data }) => {
          this.markers = mapp(data, this.markers);
        })
        .catch((error) => {
          console.log(error);
        });
      if (this.markers.length > 0) {
        this.markers.forEach((item) => {
          item.setMap(this.map);
        });
      }
      console.log(this.markers);
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
