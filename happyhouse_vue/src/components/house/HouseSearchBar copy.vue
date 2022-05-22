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
        ><b-table
          hover
          sticky-header="600px"
          responsive
          :items="housedeal"
          :fields="fields"
          selectable
          @row-selected="checkvalue"
        ></b-table
      ></b-col>

      <b-col><div id="map"></div></b-col>
    </b-row>
  </div>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import { getMarker, first } from "@/api/map";
import http from "@/api/http";
export default {
  name: "HouseSearchBar",
  data() {
    return {
      fields: [
        { key: "aptName", label: "아파트이름" },
        { key: "dealAmount", label: "가격" },
      ],
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
      housedeal: [],
    };
  },
  computed: {
    ...mapState(["sidos", "guguns", "dongs"]),
  },
  created() {
    this.CLEAR_SIDO_LIST();
    this.getSido();
  },
  mounted() {
    /* global kakao */ // eslint-disable-line no-unused-vars
    http
      .get(`/Building/Subway`)
      .then(({ data }) => {
        console.log(data);
        first(data);
      })
      .catch((error) => {
        console.log(error);
      });
  },
  methods: {
    ...mapActions(["getSido", "getGugun", "getDong"]),
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
        const params = { dong: this.dongCode };
        http
          .get(`/Building/House`, { params })
          .then(({ data }) => {
            this.housedeal = data;
            getMarker(data);
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
    checkvalue(data) {
      console.log(data);
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
