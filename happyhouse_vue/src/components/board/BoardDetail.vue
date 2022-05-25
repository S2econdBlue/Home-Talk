<template>
  <b-container class="bv-example-row mt-3">
    <b-row>
      <b-col>
        <!-- <b-alert show><h3>글보기</h3></b-alert> -->
      </b-col>
    </b-row>
    <b-row class="mb-1">
      <b-col class="text-left">
        <b-button variant="outline-primary" @click="listArticle">목록</b-button>
      </b-col>
      <b-col class="text-right">
        <b-button
          variant="outline-info"
          size="sm"
          @click="moveModifyArticle"
          class="mr-2"
          >글수정</b-button
        >
        <b-button variant="outline-danger" size="sm" @click="deleteArticle"
          >글삭제</b-button
        >
      </b-col>
    </b-row>
    <b-row class="mb-1">
      <b-col>
        <b-card
          :header-html="`<h3>
          ${article.title} [${article.hit}]</h3><div><h6>${article.id}</div><div>${article.time}</h6></div>`"
          class="mb-2"
          border-variant="dark"
          no-body
        >
          <b-card-body class="text-left">
            <b-carousel
              id="carousel-1"
              v-model="slide"
              :interval="4000"
              controls
              indicators
              background="#ababab"
              img-width="1024"
              img-height="480"
              style="text-shadow: 1px 1px 2px #333"
              @sliding-start="onSlideStart"
              @sliding-end="onSlideEnd"
            >
              <!-- Text slides with image -->
              <b-carousel-slide
                caption="First slide"
                text="Nulla vitae elit libero, a pharetra augue mollis interdum."
                img-src="https://picsum.photos/1024/480/?image=52"
              ></b-carousel-slide>

              <!-- Slides with custom text -->
              <b-carousel-slide
                img-src="https://picsum.photos/1024/480/?image=54"
              >
                <h1>Hello world!</h1>
              </b-carousel-slide>

              <!-- Slides with image only -->
              <b-carousel-slide
                img-src="https://picsum.photos/1024/480/?image=58"
              ></b-carousel-slide>

              <!-- Slides with img slot -->
              <!-- Note the classes .d-block and .img-fluid to prevent browser default image alignment -->
              <b-carousel-slide>
                <template #img>
                  <img
                    class="d-block img-fluid w-100"
                    width="1024"
                    height="480"
                    src="https://picsum.photos/1024/480/?image=55"
                    alt="image slot"
                  />
                </template>
              </b-carousel-slide>

              <!-- Slide with blank fluid image to maintain slide aspect ratio -->
              <b-carousel-slide
                caption="Blank Image"
                img-blank
                img-alt="Blank image"
              >
                <p>
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                  Suspendisse eros felis, tincidunt a tincidunt eget, convallis
                  vel est. Ut pellentesque ut lacus vel interdum.
                </p>
              </b-carousel-slide>
            </b-carousel>
            <p class="mt-4">
              Slide #: {{ slide }}<br />
              Sliding: {{ sliding }}
            </p>
            <div v-html="message"></div>
          </b-card-body>
        </b-card>
      </b-col>
    </b-row>
    <b-row v-for="(file, index) in article.fileList" :key="index">
      <a :href="`${download_url}board/download/${file.no}`">
        {{ file.original_name }} ( {{ file.size }} kb)
        <img
          :src="`${download_url}/board/image/${file.original_name}`"
          alt=""
        />
      </a>
    </b-row>
  </b-container>
</template>

<script>
// import moment from "moment";
import http from "@/api/http.js";
import { BASE_URL } from "@/api/index.js";
export default {
  name: "BoardDetail",
  data() {
    return {
      download_url: "",
      article: {},
      slide: 0,
      sliding: null,
    };
  },
  computed: {
    message() {
      if (this.article.content)
        return this.article.content.split("\n").join("<br>");
      return "";
    },
  },
  created() {
    this.download_url = BASE_URL();
    http.get(`/board/${this.$route.params.articleno}`).then(({ data }) => {
      this.article = data;
    });
  },
  methods: {
    onSlideStart() {
      this.sliding = true;
    },
    onSlideEnd() {
      this.sliding = false;
    },
    listArticle() {
      this.$router.push({ name: "boardList" });
    },
    moveModifyArticle() {
      this.$router.replace({
        name: "boardModify",
        params: { articleno: this.article.no },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    deleteArticle() {
      if (confirm("정말로 삭제?")) {
        this.$router.replace({
          name: "boardDelete",
          params: { articleno: this.article.no },
        });
      }
    },
  },
  // filters: {
  //   dateFormat(regtime) {
  //     return moment(new Date(regtime)).format("YY.MM.DD hh:mm:ss");
  //   },
  // },
};
</script>

<style></style>
