<template>
  <div id="wrap">
    <div id="map"></div>
    <div id="board">
      <b-row class="mt-1 mb-1 ml-1 mr-1 text-center dark"
        ><b-col cols="3">현위치 </b-col>
        <b-col cols="9">{{ useraddress }}</b-col>
      </b-row>

      <div>
        <b-tabs content-class="mt-3">
          <b-tab title="시세" active
            ><div>
              <b-button block variant="primary" @click="openfilter"
                >필터설정</b-button
              >
              <div id="filter" v-if="filtercheck">
                <b-row class="mt-1 mb-1 ml-1 mr-1 text-center mx-auto">
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
                      size="sm"
                    ></b-form-select>
                  </b-col>
                </b-row>
                <b-row class="text-center mt-5 mb-3">
                  <b-col cols="3"><div>가격</div></b-col>
                  <b-col class="mt-1 mb-1 center" cols="8"
                    ><Slider v-model="worth.value" v-bind="worth"></Slider
                  ></b-col>
                </b-row>
                <b-row class="text-center mt-5 mb-3">
                  <b-col cols="3"><div>건축년도</div></b-col>
                  <b-col class="mt-1 mb-1" cols="8"
                    ><Slider v-model="term.value" v-bind="term"
                      >기간</Slider
                    ></b-col
                  >
                </b-row>
                <b-row class="text-center mt-5 mb-3">
                  <b-col cols="3"><div>거래년도</div></b-col>
                  <b-col class="mt-1 mb-1" cols="8"
                    ><Slider v-model="trade.value" v-bind="trade"
                      >기간</Slider
                    ></b-col
                  >
                </b-row>
                <b-row class="text-center mt-5 mb-3">
                  <b-col
                    ><b-button variant="outline-primary" @click="getDeal"
                      >조회</b-button
                    ></b-col
                  >
                  <b-col
                    ><b-button variant="danger" @click="clear"
                      >초기화</b-button
                    ></b-col
                  >
                </b-row>
              </div>
              <div id="value" v-if="check">
                <b-table
                  hover
                  sticky-header="720px"
                  responsive
                  :items="housedeal"
                  :fields="fields"
                  selectable
                  select-mode="single"
                  @row-selected="checkvalue"
                ></b-table>
              </div>
              <div id="deal" v-if="detail">
                <b-button variant="primary float-right" @click="dealToggle"
                  >X</b-button
                >
                <b-table
                  hover
                  sticky-header="710px"
                  responsive
                  :fields="field2"
                  :items="dealhistory"
                  selectable
                  select-mode="single"
                ></b-table>
              </div></div
          ></b-tab>
          <b-tab title="매물"
            ><div>
              <b-card
                title="Card Title"
                img-src="https://picsum.photos/600/300/?image=25"
                img-alt="Image"
                img-top
                tag="article"
                style="max-width: 100%"
                class="mb-2"
              >
                <b-card-text>
                  Some quick example text to build on the card title and make up
                  the bulk of the card's content.
                </b-card-text>

                <b-button href="#" variant="primary">Go somewhere</b-button>
              </b-card>
            </div></b-tab
          >
        </b-tabs>
      </div>
    </div>

    <div class="category">
      <ul>
        <li id="coffeeMenu" @click="starcheck">
          <span class="list coffee"></span>
          카페
        </li>
        <li id="subwayMenu" @click="subwaycheck">
          <span class="list subway"></span>
          지하철
        </li>
        <li id="allMenu" @click="allcheck">
          <span class="list all"></span>
          전체
        </li>
        <li id="filterMenu" @click="openfilter">
          <span class="list filter"></span>
          필터
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import Slider from "@vueform/slider/dist/slider.vue2.js";
import {
  getMarker,
  starbucksStore,
  subwayStore,
  changeMarker,
  setCoffeeMarkers,
  setStoreMarkers,
  geo,
} from "@/api/map";
import http from "@/api/http";
export default {
  name: "HouseSearchBar",
  components: {
    Slider,
  },
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
      filtercheck: false,
      check: false,
      detail: false,
      value: 5,
      dealhistory: [],
      cafe: [],
      subways: [],
      allcolor: false,
      subcolor: false,
      cofcolor: false,
      useraddress: [],
      settingcolor: false,
      term: {
        value: [1990, 2022],
        step: 1,
        format: {
          suffix: "년",
          decimals: 0,
        },
        tooltipPosition: "",
        min: 1980,
        max: 2022,
        lazy: true,
        merge: 2010,
      },
      worth: {
        value: [0, 500000],
        step: 500,
        format: {
          suffix: "만원",
          decimals: 0,
        },
        tooltipPosition: "",
        max: 500000,
        lazy: true,
      },
      trade: {
        value: [1990, 2022],
        step: 1,
        format: {
          suffix: "년",
          decimals: 0,
        },
        tooltipPosition: "",
        merge: 2010,
        min: 1990,
        max: 2022,
        lazy: true,
      },
    };
  },
  computed: {
    ...mapState(["sidos", "guguns", "dongs"]),
  },
  created() {
    /* global kakao */ // eslint-disable-line no-unused-vars
    this.CLEAR_SIDO_LIST();
    this.getSido();
    http
      .get(`/Building/Subway`)
      .then(({ data }) => {
        subwayStore(data);
      })
      .catch((error) => {
        console.log(error);
      });
    http
      .get(`/Building/around`)
      .then(({ data }) => {
        starbucksStore(data);
      })
      .catch((error) => {
        console.log(error);
      });

    geo((rst) => {
      console.log(rst);
      this.useraddress = rst;
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
      this.detail = false;
      if (this.gugunCode) this.getDong(this.gugunCode);
    },
    getDeal() {
      if (this.dongCode) {
        this.check = true;
        this.housedeal = [];
        const params = {
          dong: this.dongCode,
          minval: this.worth.value[0],
          maxval: this.worth.value[1],
          termlow: this.term.value[0],
          termhigh: this.term.value[1],
        };
        console.log(params);
        http
          .get(`/Building/House`, { params })
          .then(({ data }) => {
            this.housedeal = data;
            this.detail = false;
            this.filtercheck = false;
            if (data.length > 0) {
              getMarker(data);
            } else {
              alert("거래내역이 없습니다");
              this.filtercheck = true;
            }
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
    dealToggle() {
      this.detail = !this.detail;
    },
    starcheck() {
      if (!this.cofcolor) {
        changeMarker("coffee");
        this.cofcolor = true;
      } else {
        this.cofcolor = false;
        setCoffeeMarkers(null);
        var coffeeMenu = document.getElementById("coffeeMenu");
        coffeeMenu.className = "";
      }
    },
    subwaycheck() {
      if (!this.subcolor) {
        changeMarker("subway");
        this.subcolor = true;
      } else {
        this.subcolor = false;
        setStoreMarkers(null);
        var subwayMenu = document.getElementById("subwayMenu");
        subwayMenu.className = "";
      }
    },
    allcheck() {
      if (!this.allcolor) {
        changeMarker("all");
        this.allcolor = true;
      } else {
        this.allcolor = false;
        this.subcolor = false;
        this.cofcolor = false;
        setStoreMarkers(null);
        setCoffeeMarkers(null);
        var coffeeMenu = document.getElementById("coffeeMenu");
        var subwayMenu = document.getElementById("subwayMenu");
        var allMenu = document.getElementById("allMenu");
        coffeeMenu.className = "";
        subwayMenu.className = "";
        allMenu.className = "";
      }
    },
    openfilter() {
      this.filtercheck = !this.filtercheck;
    },
    clear() {
      this.check = false;
      this.detail = false;
      this.worth.value[0] = 0;
      this.worth.value[1] = 500000;
      this.term.value[0] = 1990;
      this.term.value[1] = 2022;
    },
  },
};
</script>

<style scoped>
#map {
  width: 100%;
  height: 100%;
}
#filter {
  width: 90%;
  z-index: 1;
  background: white;
  border-radius: 10px;
  border: 1px solid black;
  margin: 0 auto;
}
#wrap {
  position: relative;
  width: 100%;
  height: 850px;
}
#result {
  position: relative;
  top: 0px;
  right: 0px;
  width: 400px;
  height: 100%;
}
#value {
  position: absolute;
  width: 100%;
  height: 700px;
  background: white;
}
#deal {
  position: relative;
  width: 100%;
  height: 700px;
  z-index: 2;
  background: white;
}
#board {
  position: absolute;
  top: 0px;
  right: 0px;
  width: 500px;
  height: 100%;
  z-index: 1;
  background: white;
  border: 1px solid black;
}
.category {
  position: absolute;
  overflow: hidden;
  top: 10px;
  left: 10px;
  width: 208px;
  height: 60px;
  z-index: 10;
  border: 1px solid black;
  font-family: "Malgun Gothic", "맑은 고딕", sans-serif;
  font-size: 12px;
  text-align: center;
  background-color: #fff;
}
.category li {
  list-style: none;
  float: left;
  width: 50px;
  height: 70px;
  padding-top: 5px;
  cursor: pointer;
}
.category .menu_selected {
  background: rgb(20, 181, 250);
  color: #fff;
  border-left: 1px solid #915b2f;
  border-right: 1px solid #915b2f;
  margin: 0 -1px;
}
.category,
.category * {
  margin: 0;
  padding: 0;
  color: #000;
}
.category .list {
  display: block;
  margin: 0 auto 2px;
  width: 32px;
  height: 32px;
}
.coffee {
  background: url("@/assets/starbucks.png") no-repeat;
}
.subway {
  background: url("@/assets/subway.png") no-repeat;
}
.all {
  background: url("@/assets/all.png") no-repeat;
}
.filter {
  background: url("@/assets/filter.png") no-repeat;
}
</style>
<style src="@vueform/slider/themes/default.css"></style>
