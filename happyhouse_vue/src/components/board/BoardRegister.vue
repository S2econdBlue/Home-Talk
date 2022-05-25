<template>
  <b-container class="bv-example-row mt-3">
    <b-col>
      <b-row>
        <b-col cols="1" />
        <b-col cols="10">
          <b-row>
            <b-col>
              <b-alert show>
                <h4>
                  아래 작성한 형태로 사용자에게 보이게 됩니다.
                  <a href="#"><strong>작성방법 참고</strong></a>
                </h4>
              </b-alert>
            </b-col>
          </b-row>
          <b-row>
            <b-form-file
              browse-text="찾기.."
              multiple
              accept=".jpg, .png, .gif"
              v-model="uploadImg"
              :state="Boolean(uploadImg)"
              placeholder="드래그 혹은 클릭으로 실제 매물 사진을 업로드해주세요."
              drop-placeholder="여기에 드래그해주세요."
            >
            </b-form-file>
          </b-row>
          <b-row>
            <b-form-textarea
              id="textarea"
              v-model="title"
              placeholder="제목을 작성해주세요."
              rows="1"
              max-rows="1"
              size="sm"
              no-resize
            ></b-form-textarea>
          </b-row>
          <b-row class="mb-5">
            <b-card
              text-variant="secondary"
              style="width: 100%; font-size: 12px"
            >
              <b-row align-h="between">
                <b-col cols="3">최초 등록일</b-col>
                <b-col cols="3">{{ crntDate() }}</b-col>
              </b-row>
            </b-card>
          </b-row>
          <b-row>
            <b-col class="text-left">
              <!-- 왼쪽으로 붙이기 -->
              <h5>
                <strong>거래정보</strong>
                <hr style="border: 1.5px solid black" />
              </h5>
            </b-col>
          </b-row>
          <b-row style="font-size: 15px">
            <b-col>
              <b-row align-h="between">
                <b-col cols="4"><strong>계약형태</strong></b-col>
                <b-col>
                  <b-form-radio-group
                    id="btn-radios-1"
                    v-model="selectedContract"
                    :options="options1"
                    name="radios-btn-default"
                    buttons
                  ></b-form-radio-group>
                </b-col>
              </b-row>
            </b-col>
            <b-col>
              <b-row>
                <b-col><strong>가격정보</strong></b-col>
                <b-col cols="9">
                  <b-row class="pb-5">
                    <b-col cols="4">보증금</b-col>
                    <b-col cols="5">
                      <b-form-input
                        :id="`type-number`"
                        type="number"
                      ></b-form-input>
                    </b-col>
                    <b-col>만원</b-col>
                  </b-row>
                  <b-row>
                    <b-col cols="4">월세</b-col>
                    <b-col cols="5">
                      <b-form-input
                        :id="`type-number`"
                        type="number"
                      ></b-form-input>
                    </b-col>
                    <b-col>만원</b-col>
                  </b-row>
                </b-col>
              </b-row>
            </b-col>
          </b-row>

          <hr class="m-4" />

          <b-row>
            <b-col>
              <b-row>
                <b-col cols="4">공용 관리비</b-col>
                <b-col cols="5">
                  <b-form-input
                    :id="`type-number`"
                    type="number"
                  ></b-form-input>
                </b-col>
                <b-col>만원</b-col>
              </b-row>
            </b-col>
            <b-col>
              <b-row>
                <b-col cols="4">공용 관리비 항목</b-col>
                <b-col>
                  <b-form-tags
                    input-id="tags-remove-on-delete"
                    :input-attrs="{
                      'aria-describedby': 'tags-remove-on-delete-help',
                    }"
                    v-model="maintainTag"
                    separator=" "
                    placeholder="각각 입력 후 엔터"
                    remove-on-delete
                  ></b-form-tags>
                </b-col>
              </b-row>
            </b-col>
          </b-row>
          <hr class="m-4" />
          <b-row>
            <b-col>
              <b-row>
                <b-col cols="4">융자여부</b-col>
                <b-col>
                  <b-form-radio-group
                    id="btn-radios-1"
                    v-model="selectedLoan"
                    :options="options2"
                    name="radios-btn-default"
                    buttons
                  ></b-form-radio-group>
                </b-col>
              </b-row>
            </b-col>
            <b-col>
              <b-row>
                <b-col cols="4">개별 사용료 항목</b-col>
                <b-col>
                  <b-form-tags
                    input-id="tags-remove-on-delete"
                    :input-attrs="{
                      'aria-describedby': 'tags-remove-on-delete-help',
                    }"
                    v-model="eachUsageTag"
                    separator=" "
                    placeholder="각각 입력 후 엔터"
                    remove-on-delete
                  ></b-form-tags>
                </b-col>
              </b-row>
            </b-col>
          </b-row>
          <hr class="m-4" />
          <b-row>
            <b-col>
              <b-row>
                <b-col cols="4">입주가능일</b-col>
                <b-col>
                  <b-button>즉시입주</b-button>
                </b-col>
                <b-col>
                  <b-button v-b-toggle.collapse-1 variant="primary">
                    달력선택
                  </b-button>
                </b-col>
              </b-row>
            </b-col>
            <b-col></b-col>
          </b-row>
          <b-row>
            <b-col cols="7">
              <b-collapse id="collapse-1" class="mt-2">
                <div
                  :style="{
                    position: choose,
                    left: leftPx,
                    top: topPx,
                  }"
                >
                  <b-calendar
                    v-model="calendarValue"
                    @context="onContext"
                    locale="ko-KR"
                    label-help="예정입주 가능일을 선택해주세요."
                    label-no-date-selected=""
                  ></b-calendar>
                </div>
              </b-collapse>
            </b-col>
            <b-col> </b-col>
          </b-row>
          <hr class="m-4" />
          <b-row class="pt-4">
            <b-col class="text-left">
              <!-- 왼쪽으로 붙이기 -->
              <h5>
                <strong>상세설명</strong>
                <hr style="border: 1.5px solid black" />
              </h5>
            </b-col>
          </b-row>
          <b-row>
            <b-form-textarea
              id="textarea"
              v-model="detailText"
              placeholder="매물에 대해 상세한 설명을 작성할 수 있습니다."
              rows="3"
              max-rows="6"
            ></b-form-textarea>
          </b-row>
          <b-row class="pt-5">
            <b-col class="text-left">
              <!-- 왼쪽으로 붙이기 -->
              <h5>
                <strong>위치</strong>
                <hr style="border: 1.5px solid black" />
              </h5>
            </b-col>
          </b-row>
          <b-row>
            <b-button
              @click="sample5_execDaumPostcode()"
              value="주소로 검색"
              variant="primary"
            >
              매물주소 검색
            </b-button>
          </b-row>
          <b-row>
            <div id="map" style="width: 100%; height: 300px" class="my-4"></div>
          </b-row>
          <b-row>
            <b-form-input
              type="text"
              id="sample5_address"
              disabled
              placeholder="도로명주소 입력"
            />
          </b-row>
          <b-row>
            <b-form-input
              type="text"
              id="sample5_address"
              placeholder="상세주소 입력"
            />
          </b-row>
          <b-row>
            <b-button class="w-100 my-3" variant="primary">매물등록</b-button>
          </b-row>
        </b-col>
      </b-row>
    </b-col>
  </b-container>
</template>

<script>
export default {
  name: "BoardWrite",
  components: {},
  data() {
    return {
      title: "",
      uploadImg: [],

      selectedContract: [],
      options1: [
        { text: "매매", value: "sell" },
        { text: "전세", value: "longTerm" },
        { text: "월세", value: "monthly " },
      ],
      maintainTag: [],
      selectedLoan: [],
      options2: [
        { text: "융자있음", value: 1 },
        { text: "융자없음", value: 0 },
      ],
      eachUsageTag: [],
      calendar: false,
      choose: "relative",
      leftPx: "25px",
      topPx: "0px",

      calendarValue: "",
      context: null,

      detailText: "",

      postcode: "",
      address: "",
      extraAddress: "",

      map: "",
      marker: "",
      mapContainer: "",
      mapOption: "",
      geocoder: "",
      selectedTrade: [],
      options3: [
        { text: "중개", value: 1 },
        { text: "직거래", value: 0 },
      ],
    };
  },
  methods: {
    toggleCalendar() {
      this.displayToggle == "none"
        ? (this.displayToggle = "inline")
        : (this.displayToggle = "none");
    },
    onContext(ctx) {
      this.context = ctx;
    },
    sample5_execDaumPostcode() {
      let geocoder = this.geocoder;
      // let mapContainer = this.mapContainer;
      let map = this.map;
      let marker = this.marker;

      new window.daum.Postcode({
        oncomplete(data) {
          var addr = data.address; // 최종 주소 변수

          // 주소 정보를 해당 필드에 넣는다.
          document.getElementById("sample5_address").value = addr;
          // 주소로 상세 정보를 검색
          geocoder.addressSearch(data.address, function (results, status) {
            // 정상적으로 검색이 완료됐으면
            if (status === window.daum.maps.services.Status.OK) {
              var result = results[0]; //첫번째 결과의 값을 활용

              // 해당 주소에 대한 좌표를 받아서
              var coords = new window.daum.maps.LatLng(result.y, result.x);
              // 지도를 보여준다.
              // mapContainer.style.display = "block";
              map.relayout();
              // 지도 중심을 변경한다.
              map.setCenter(coords);
              // 마커를 결과값으로 받은 위치로 옮긴다.
              marker.setPosition(coords);
            }
          });
        },
      }).open();
    },
    crntDate() {
      let crntYYYYMMDD = new Date(Date.now());

      console.log(crntYYYYMMDD);
      return (
        crntYYYYMMDD.getFullYear() +
        "년 " +
        (crntYYYYMMDD.getMonth() + 1) +
        "월 " +
        crntYYYYMMDD.getDate() +
        "일"
      );
    },
    postThread() {},
  },
  mounted() {
    // --------------------------------지도 설정 ------------------------------------------
    this.mapContainer = document.getElementById("map");
    this.mapContainer.style.display = "block";
    var mapOption = {
      center: new window.daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
      level: 5, // 지도의 확대 레벨
    };
    this.map = new window.daum.maps.Map(this.mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    this.geocoder = new window.daum.maps.services.Geocoder();
    //마커를 미리 생성
    this.marker = new window.daum.maps.Marker({
      position: "",
      map: this.map,
    });

    // --------------------------------지도 설정 끝 ------------------------------------------
  },
};
</script>

<style></style>
