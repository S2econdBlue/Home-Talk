<template>
  <b-container class="bv-example-row mt-3 text-center">
    <b-row class="pt-3">
      <!-- 채팅 리스트 -->
      <b-col cols="3">
        <b-row>
          <b-card class="w-100">
            <b-row><br /></b-row>
            <b-row>
              <b-col>
                <b-row>
                  <b-col>
                    <b-icon icon="people-fill" />
                  </b-col>
                </b-row>
                <b-row>
                  <b-col>전체</b-col>
                </b-row>
              </b-col>
              <b-col>
                <b-row>
                  <b-col> {{}} </b-col>
                </b-row>
                <b-row>
                  <b-col>안읽음</b-col>
                </b-row>
              </b-col>
            </b-row>
            <b-row><br /></b-row>
          </b-card>
        </b-row>
        <b-row>
          <b-list-group class="w-100">
            <!-- 사용자 측면에서 불러오기 -->
            <template v-for="room in chatroomlist">
              <router-link
                :key="room.no"
                :to="{
                  name: 'chatList',
                  params: {
                    no: room.no,
                    receiver:
                      room.user_id == loginUser.id
                        ? room.seller_id
                        : room.user_id,
                  },
                }"
              >
                <b-list-group-item
                  button
                  @click="changeIconState(room), forceRerender()"
                >
                  <template v-if="room.seller_id != loginUser.id">
                    {{ room.seller_id }}
                  </template>
                  <template v-else>
                    {{ room.user_id }}
                  </template>
                  <template
                    v-if="
                      room.user_id == loginUser.id && room.userside_alert == 1
                    "
                  >
                    <b-icon icon="messenger" variant="success"></b-icon>
                  </template>
                  <template
                    v-else-if="
                      room.seller_id == loginUser.id &&
                      room.sellerside_alert == 1
                    "
                  >
                    <b-icon icon="messenger" variant="success"></b-icon>
                  </template>
                </b-list-group-item>
              </router-link>
            </template>
            <b-button @click="createRoom">
              debugging [부동산 업자에게 상담 요청]
            </b-button>
          </b-list-group>
        </b-row>
      </b-col>
      <!-- 채팅창 -->
      <b-col cols="8">
        <b-jumbotron style="height: 800px">
          <b-row>
            <b-col>
              <router-view :key="ComputedComponentKey" />
            </b-col>
          </b-row>
        </b-jumbotron>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import { mapGetters } from "vuex";
import http from "@/api/http.js";
export default {
  name: "BoardView",
  data() {
    return { chatroomlist: "", componentKey: 0 };
  },
  computed: {
    ...mapGetters(["loginUser"]),
    ComputedComponentKey() {
      return this.componentKey;
    },
  },
  methods: {
    forceRerender() {
      this.componentKey++;
    },
    changeIconState(room) {
      if (room.seller_id == this.loginUser.id) room.sellerside_alert = 0;
      else room.userside_alert = 0;
    },
    createRoom() {
      let request = { user_id: this.loginUser.id, seller_id: "seller" };
      console.log(request);
      http
        .post("/chat", JSON.stringify(request))
        .then((res) => {
          this.chatroomlist = res.data;
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
