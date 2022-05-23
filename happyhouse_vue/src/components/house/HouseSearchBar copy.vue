<template>
  <div id="wrap">
    <div id="map"></div>
    <div id="filter">
      <b-row class="mt-1 mb-1 ml-1 mr-1 text-center">
        <b-col class="sm-3">
          시<b-form-select
            v-model="sidoCode"
            :options="sidos"
            @change="gugunList"
            size="sm"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3">
          구<b-form-select
            v-model="gugunCode"
            :options="guguns"
            @change="dongList"
            size="sm"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3">
          동<b-form-select
            v-model="dongCode"
            :options="dongs"
            @change="getDeal"
            size="sm"
          ></b-form-select>
        </b-col>
      </b-row>
      <b-row class="text-center">
        <label for="range-2">Example</label>
        <b-form-input
          id="range-2"
          v-model="value"
          type="range"
          min="0"
          max="5"
          step="0.5"
        ></b-form-input>
        <div class="mt-2">Value: {{ value }}</div>
      </b-row>
    </div>
    <div id="result">
      <div id="value" v-if="check">
        <b-button variant="primary" @click="resultToggle">X</b-button>
        <b-table
          hover
          sticky-header="700px"
          responsive
          :items="housedeal"
          :fields="fields"
          selectable
          select-mode="single"
          @row-selected="checkvalue"
        ></b-table>
      </div>

      <div id="deal" v-if="detail">
        <b-table
          hover
          sticky-header="700px"
          responsive
          :fields="field2"
          :items="dealhistory"
          selectable
          select-mode="single"
        ></b-table>
      </div>
    </div>
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
      field2: [
        { key: "dealYear", label: "거래년도" },
        { key: "dealAmount", label: "가격" },
        { key: "msize", label: "평수" },
        { key: "dealperSize", label: "평당가격" },
      ],
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
      housedeal: [],
      check: false,
      detail: false,
      value: 5,
      dealhistory: [],
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
      this.check = false;
      if (this.gugunCode) this.getDong(this.gugunCode);
    },
    getDeal() {
      if (this.dongCode) {
        this.check = true;
        this.housedeal = [];
        const params = { dong: this.dongCode };
        console.log(params);
        http
          .get(`/Building/House`, { params })
          .then(({ data }) => {
            this.housedeal = data;
            this.detail = false;
            if (data.length > 0) {
              getMarker(data);
            } else alert("거래내역이 없습니다");
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
    checkvalue(data) {
      if (data[0].aptCode != null) {
        this.dealhistory = [];
        const params = { code: data[0].aptCode };
        http
          .get(`/Building/Deal`, { params })
          .then(({ data }) => {
            this.dealhistory = data;
            console.log(this.dealhistory);
            this.check = false;
            this.detail = true;
          })
          .catch((error) => {
            console.log(error);
          });
      } else {
        alert("오류발생");
      }
    },
    resultToggle() {
      this.check = !this.check;
    },
  },
};
</script>

<style>
#map {
  width: 100%;
  height: 100%;
}
#filter {
  position: absolute;
  top: 0px;
  left: 0px;
  width: 400px;
  z-index: 1;
  background: white;
}
#wrap {
  position: relative;
  width: 100%;
  height: 700px;
}
#result {
  position: absolute;
  top: 0px;
  right: 0px;
  width: 400px;
  height: 100%;
  z-index: 1;
}
#value {
  position: absolute;
  top: 0px;
  right: 0px;
  width: 400px;
  height: 100%;
  z-index: 2;
  background: white;
}
#deal {
  position: absolute;
  top: 0px;
  right: 0px;
  width: 400px;
  height: 100%;
  z-index: 3;
  background: white;
}
</style>
