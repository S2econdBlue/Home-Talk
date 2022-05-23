<template>
  <b-container fluid class="bv-example-row mt-3 text-center">
    <b-button @click="createRoom">부동산 업자에게 상담 요청</b-button>
    <h3 class="underline-hotpink">
      <b-icon icon="inbox-fill"></b-icon> Chatting Service
    </h3>
    <b-row>
      <!-- 채팅 리스트 -->
      <b-col cols="3">
        <b-list-group>
          <!-- 사용자 측면에서 불러오기 -->

          <b-list-group-item button v-for="room in chatroomlist" :key="room.no">
            <router-link :to="{ name: 'chatList', params: { no: room.no } }">
              <template v-if="room.seller_id">
                {{ room.seller_id }}
              </template>
              <template v-else>
                {{ room.user_id }}
              </template>
              <template v-if="room.user_id">
                <b-icon icon="messenger" variant="success"></b-icon>
              </template>
              <template v-if="room.seller_id">
                <b-icon icon="messenger" variant="success"></b-icon>
              </template>
            </router-link>
          </b-list-group-item>
        </b-list-group>
      </b-col>
      <!-- 채팅창 -->
      <b-col cols="8"><router-view /> </b-col>
      <b-col cols="1"></b-col>
    </b-row>
  </b-container>
</template>
<script>
import { mapGetters } from "vuex";
import http from "@/api/http.js";
export default {
  name: "BoardView",
  data() {
    return { chatroomlist: "" };
  },
  computed: {
    ...mapGetters(["loginUser"]),
  },
  methods: {
    createRoom() {
      let request = { user_id: this.loginUser.id, seller_id: "seller" };
      console.log(request);
      http
        .post("/chat", JSON.stringify(request))
        .then((res) => {
          this.chatroomlist = res.data;
          console.log(res);
          console.log(this.chatroomlist);
        })
        .catch((err) => {
          console.log(err);
        });
    },

    async LoadChatRoomList() {
      await http
        .get(`/chat/${this.loginUser.id}/${this.loginUser.grade}`)
        .then((res) => {
          console.log(res.data);
          this.chatroomlist = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },

  created() {
    this.LoadChatRoomList();
  },
};
</script>
<style scoped>
.underline-hotpink {
  display: inline-block;
  background: linear-gradient(
    180deg,
    rgba(255, 255, 255, 0) 70%,
    rgba(231, 27, 139, 0.3) 30%
  );
}
</style>
