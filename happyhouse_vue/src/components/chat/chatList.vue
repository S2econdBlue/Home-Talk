<template>
  <b-jumbotron border-variant="dark">
    <b-row align-v="start">
      <b-col>
        <!-- 각 채팅 기록만큼 반복 -->
        <template v-for="chat in chatHistory">
          <!-- 내 아이디인 경우 -->
          <b-row :key="chat.no">
            <template v-if="chat.id == loginUser.id">
              <b-col>
                <b-row align-h="end">
                  <b-col cols="2">{{ chat.id }}</b-col>
                </b-row>
                <b-row align-h="end">
                  <b-col cols="4">{{ chat.message }}</b-col>
                </b-row>
              </b-col>
            </template>
            <template v-else>
              <b-col>
                <b-row>
                  <b-col cols="2">{{ chat.id }}</b-col>
                </b-row>
                <b-row>
                  <b-col cols="4">{{ chat.message }}</b-col>
                </b-row>
              </b-col>
            </template>
          </b-row>
        </template>
      </b-col>
    </b-row>

    <b-row align-v="end">
      <b-col>
        <b-form-group>
          <b-row>
            <b-col cols="10">
              <b-form-input
                id="input-default"
                @keyup.enter="sendMessage"
                v-model="crntInputMessage"
                placeholder="메세지를 입력해주세요."
              />
            </b-col>
            <b-col>
              <b-button pill block variant="success" @click="sendMessage">
                Button
              </b-button>
            </b-col>
          </b-row>
        </b-form-group>
      </b-col>
    </b-row>
  </b-jumbotron>
</template>

<script>
import { mapGetters } from "vuex";
import http from "@/api/http.js";
export default {
  name: "chatList",
  data() {
    return {
      room_no: this.$route.params.no,
      chatHistory: {},
      crntInputMessage: "",
    };
  },
  computed: {
    ...mapGetters(["loginUser"]),
  },
  methods: {
    loadChatHistory() {
      http
        .get(`/chat/${this.room_no}`)
        .then((res) => {
          this.chatHistory = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //메세지 전송
    sendMessage() {
      if (this.crntInputMessage.trim() != "") {
        let sendMessage = {};
        sendMessage.message = this.crntInputMessage;
        sendMessage.sender = this.loginUser.id;
        sendMessage.receiver = sendMessage.room_no = this.room_no;

        console.log(sendMessage);
        this.webSocket.send(JSON.stringify(sendMessage));
      }

      this.crntInputMessage = "";
    },
    //소켓 통신 종료
    closeWebSocket() {
      this.webSocket.close();
    },
    //소켓 통신 연결
    //0 : onopen, 1 : 데이터 송수신, 2 : onclose
    openWebSocket() {
      this.webSocket = new WebSocket(`ws://localhost/vue/livechat`);
      console.log(this.webSocket);

      this.webSocket.onopen = (event) => {
        console.log("open : ", event);
        this.webSocket.send(
          JSON.stringify({ setSession: 1, id: this.loginUser.id })
        );
      };

      //데이터 수신
      this.webSocket.onmessage = (event) => {
        console.log(event);
        const chatMessageDto = JSON.parse(event.data);
        this.chatMessages.push(chatMessageDto);
        console.log(this.chatMessages);
      };

      this.webSocket.onclose = (event) => {
        console.log("close : ", event);
      };
    },
  },
  created() {
    this.loadChatHistory();
    this.openWebSocket();
  },
  destroyed() {
    this.closeWebSocket();
  },
};
</script>

<style></style>
