<template>
  <div>
    <b-jumbotron
      border-variant="dark"
      class="overflow-auto"
      style="height: 500px"
    >
      <b-row>
        <b-col>
          <!-- 각 채팅 기록만큼 반복 -->
          <template v-for="(chat, index) in computedChatHistory">
            {{ DayDevider(index) }}
            <!-- 내 아이디인 경우 -->
            <b-row :key="chat.no">
              <template v-if="chat.id == loginUser.id">
                <b-col>
                  <b-row align-h="end">
                    <b-col cols="4">
                      <b-card
                        :header="DateFormatter(chat.date) + ' ' + loginUser.id"
                        class="text-center"
                      >
                        <b-card-text>
                          {{ chat.message }}
                        </b-card-text>
                      </b-card>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
              <template v-else>
                <b-col>
                  <b-row>
                    <b-col cols="4">
                      <b-card
                        :header="DateFormatter(chat.date) + ' ' + chat.id"
                        class="text-center"
                      >
                        <b-card-text>
                          {{ chat.message }}
                        </b-card-text>
                      </b-card>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
            </b-row>
          </template>
          <!-- 실시간으로 추가되는 메세지들 -->
          <template v-for="chat in computedChatList">
            <b-row :key="chat.crypto">
              <!-- 송신자가 본인일 경우 -->
              <template v-if="chat.sender == loginUser.id">
                <b-col>
                  <b-row align-h="end">
                    <b-col cols="4">
                      <b-card
                        :header="DateFormatter() + ' ' + chat.sender"
                        class="text-center"
                      >
                        <b-card-text>
                          {{ chat.message }}
                        </b-card-text>
                      </b-card>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
              <!-- 송신자가 본인이 아닐 경우 -->
              <template v-else-if="chat.receiver == loginUser.id">
                <b-col>
                  <b-row>
                    <b-col cols="4">
                      <b-card
                        :header="DateFormatter() + ' ' + chat.sender"
                        class="text-center"
                      >
                        <b-card-text>
                          {{ chat.message }}
                        </b-card-text>
                      </b-card>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
              <!-- 실시간 입력으로 받는 값들을 계속해서 추가 -->
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
                <a name="target"></a>
                <b-button
                  pill
                  block
                  variant="success"
                  @click="sendMessage"
                  ref="button"
                >
                  Button
                </b-button>
              </b-col>
            </b-row>
          </b-form-group>
        </b-col>
      </b-row>
    </b-jumbotron>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import http from "@/api/http.js";
export default {
  name: "chatList",
  data() {
    return {
      crnt_date: "",
      room_no: "",
      receiver: "",
      chatHistory: {},
      crntInputMessage: "",
      realtimeChat: [],
    };
  },
  computed: {
    ...mapGetters(["loginUser"]),
    computedChatHistory() {
      return this.chatHistory;
    },
    computedChatList() {
      console.log("computedChatList : ", this.realtimeChat);
      return this.realtimeChat;
    },
  },
  methods: {
    DayDevider(index) {
      if (index - 1 < 0) {
        let first = this.chatHistory[0].date.split(" ");
        let firstSplit = first[0].split("-");
        return (
          firstSplit[0] + "년 " + firstSplit[1] + "월 " + firstSplit[2] + "일"
        );
      }

      let before = this.chatHistory[index - 1].date.split(" ");
      let crnt = this.chatHistory[index].date.split(" ");

      if (before[0] != crnt[0]) {
        let crntChatDaySplit = crnt[0].split("-");
        return (
          crntChatDaySplit[0] +
          "년 " +
          Number(crntChatDaySplit[1]) +
          "월 " +
          Number(crntChatDaySplit[2]) +
          "일"
        );
      }
      return "";
    },
    DateFormatter(date) {
      if (date == undefined) {
        let date = new Date();
        let addMinuteZero = "";
        if (date.getMinutes() < 10) addMinuteZero = "0";
        return date.getHours() + ":" + addMinuteZero + date.getMinutes();
      }
      let splitDate = date.split(" ");
      let splitTIme = splitDate[1].split(":");
      return Number(splitTIme[0]) + ":" + splitTIme[1];
    },

    async UpdateAlertOff() {
      //유저라면
      let sendData = {};
      sendData.id = this.loginUser.id;
      sendData.grade = Number(this.loginUser.grade);
      sendData.no = Number(this.room_no);
      await http
        .put("/chat/off", sendData)
        .then((res) => {
          console.log("UpdateAlertOff res : ", res);
        })
        .catch((err) => {
          console.log("UpdateAlertOff err", err);
        });
    },

    moveToDown() {
      window.location.href = "#target";
    },
    async loadChatHistory() {
      this.room_no = this.$route.params.no;
      this.receiver = this.$route.params.receiver;
      await http
        .get(`/chat/${this.room_no}`)
        .then((res) => {
          this.chatHistory = res.data;
        })
        .catch((err) => {
          console.log("loadChatHistory err : ", err);
        });

      //axios 통신이 종료된 후 스크롤 하단 a태그로 움직임
      this.$nextTick(function () {
        this.moveToDown();
      });
    },

    //메세지 전송
    sendMessage() {
      if (this.crntInputMessage.trim() != "") {
        let sendMessage = {};
        let random = new Uint32Array(1);
        window.crypto.getRandomValues(random);
        sendMessage.crypto = Number(random[0]);
        sendMessage.message = this.crntInputMessage;
        sendMessage.sender = this.loginUser.id;
        sendMessage.receiver = this.receiver;
        sendMessage.room_no = Number(this.room_no);
        sendMessage.loginUserGrade = Number(this.loginUser.grade);
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

      this.webSocket.onopen = (event) => {
        console.log("open : ", event);
        this.webSocket.send(
          JSON.stringify({ setSession: 1, id: this.loginUser.id })
        );
      };

      //데이터 수신
      this.webSocket.onmessage = (event) => {
        const chatMessageDto = JSON.parse(event.data);
        console.log("onmessage : ", chatMessageDto);
        this.realtimeChat.push(chatMessageDto);

        this.$nextTick(function () {
          this.moveToDown();
        });
      };

      this.webSocket.onclose = (event) => {
        console.log("close : ", event);
      };
    },
  },
  created() {
    this.loadChatHistory();
    this.openWebSocket();
    this.UpdateAlertOff();
  },
  destroyed() {
    this.closeWebSocket();
  },
};
</script>

<style></style>
