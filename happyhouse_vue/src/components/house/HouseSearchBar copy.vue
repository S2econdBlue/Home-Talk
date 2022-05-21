<template>
  <div>
    <b-row class="mt-4 mb-4 text-center">
      <b-col class="sm-3">
        <b-form-select
          v-model="sidoCode"
          :options="sidos"
          @change="gugunList"
        ></b-form-select>
      </b-col>
      <b-col class="sm-3">
        <b-form-select
          v-model="gugunCode"
          :options="guguns"
          @change="dongList"
        ></b-form-select>
      </b-col>
      <b-col class="sm-3">
        <b-form-select
          v-model="dongCode"
          :options="dongs"
          @change="getDeal"
        ></b-form-select>
      </b-col>
    </b-row>

    <b-row>
      <b-col
        ><b-table striped hover :items="housedeal" :fields="fields"></b-table
      ></b-col>

      <b-col><div id="map"></div></b-col>
    </b-row>
  </div>
</template>

<script>
import { mapState, mapActions, mapMutations, mapGetters } from "vuex";
import { getMarker, first } from "@/api/map";
export default {
  name: "HouseSearchBar",
  data() {
    return {
      fields: ["aptName", "dealAmount"],
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
      housedeal: [],
    };
  },
  computed: {
    ...mapState(["sidos", "guguns", "dongs", "houses"]),
    ...mapGetters(["checkhouse"]),
  },
  created() {
    this.CLEAR_SIDO_LIST();
    this.getSido();
  },
  mounted() {
    /* global kakao */
    first();
    console.log(kakao);
  },
  methods: {
    ...mapActions(["getSido", "getGugun", "getDong", "getHouseList"]),
    ...mapMutations(["CLEAR_SIDO_LIST", "CLEAR_GUGUN_LIST", "CLEAR_DONG_LIST"]),
    gugunList() {
      this.CLEAR_GUGUN_LIST();
      this.gugunCode = null;
      this.housedeal = [];
      if (this.sidoCode) this.getGugun(this.sidoCode);
    },
    dongList() {
      this.CLEAR_DONG_LIST();
      this.dongCode = null;
      this.housedeal = [];
      if (this.gugunCode) this.getDong(this.gugunCode);
    },
    getDeal() {
      if (this.dongCode) {
        this.housedeal = [];
        this.getHouseList(this.dongCode);
        this.makeMarker();
      }
      // makeMarker();
    },
    makeMarker() {
      this.housedeal = [];
      this.housedeal = this.houses;
      if (this.housedeal) {
        console.log(this.housedeal);
        getMarker(this.housedeal);

        // if (this.markers.length > 0) {
        //   this.markers.forEach((item) => {
        //     item.setMap(this.map);
        //   });
        // }
      } else {
        alert("거래 내역이 없는 지역입니다.");
      }
    },
  },
};
</script>

<style>
#map {
  width: 700px;
  height: 600px;
}
</style>
