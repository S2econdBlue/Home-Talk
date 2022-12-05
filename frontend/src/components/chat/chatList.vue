<template>
  <div>
    <b-jumbotron
      border-variant="dark"
      class="overflow-auto"
      style="height: 640px; background: #0099ef"
    >
      <b-row>
        <b-col>
          <!-- 불러들인 채팅 기록 출력 -->
          <template v-for="(chat, index) in gettersChatHistory">
            {{ DayDevider(index) }}

            <b-row :key="chat.no" :id="index">
              <!-- 채팅 기록된 메세지의 아이디가 현재 로그인된 아이디일 경우 오른쪽에 출력 -->
              <template v-if="chat.id == loginUser.id">
                <b-col>
                  <b-row align-h="end">
                    <b-col cols="7">
                      <b-row>
                        <b-col class="text-right" style="color: white">{{
                          loginUser.id
                        }}</b-col>
                      </b-row>
                      <b-row align-h="end">
                        <!-- 오른쪽에 출력 -->
                        <b-col class="text-right" style="color: white">
                          {{ DateFormatter(chat.date) }}
                        </b-col>
                        <b-col>
                          <div
                            style="
                              background-color: #ffbe49;
                              border-radius: 10px;
                              color: black;
                            "
                          >
                            {{ chat.message }}
                          </div>
                        </b-col>
                      </b-row>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
              <!-- 채팅 아이디가 현재 로그인한 유저의 아이디와 다를 때 == 상대방 아이디일 때 -->
              <template v-else>
                <b-col>
                  <b-row>
                    <b-col cols="7">
                      <b-row>
                        <b-col class="text-left" style="color: white">{{
                          chat.id
                        }}</b-col>
                      </b-row>
                      <b-row>
                        <b-col>
                          <div
                            style="
                              background-color: #ffbe49;
                              border-radius: 10px;
                              color: black;
                            "
                          >
                            {{ chat.message }}
                          </div>
                        </b-col>
                        <!-- 왼쪽에 출력 -->
                        <b-col class="text-left" style="color: white">
                          {{ DateFormatter(chat.date) }}
                        </b-col>
                      </b-row>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
            </b-row>
          </template>
          <!-- 입력하는 메세지들을 추가 -->
          <template v-for="chat in computedChatList">
            <b-row :key="chat.crypto" :id="chat.crypto">
              <!-- 송신자가 본인일 경우 -->
              <template v-if="chat.sender == loginUser.id">
                <b-col>
                  <b-row align-h="end">
                    <b-col cols="7">
                      <b-row>
                        <b-col class="text-right" style="color: white">{{
                          loginUser.id
                        }}</b-col>
                      </b-row>
                      <b-row align-h="end">
                        <b-col class="text-right" style="color: white">
                          {{ DateFormatter(chat.date) }}
                        </b-col>
                        <b-col>
                          <div
                            style="
                              background-color: #ffbe49;
                              border-radius: 10px;
                              color: black;
                            "
                          >
                            {{ chat.message }}
                          </div>
                        </b-col>
                      </b-row>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
              <!-- 송신자가 본인이 아닐 경우 -->
              <template v-else-if="chat.receiver == loginUser.id">
                <b-col>
                  <b-row>
                    <b-col cols="7">
                      <b-row>
                        <b-col class="text-left" style="color: white">{{
                          chat.sender
                        }}</b-col>
                      </b-row>
                      <b-row>
                        <b-col>
                          <div
                            style="
                              background-color: #ffbe49;
                              border-radius: 10px;
                              color: black;
                              border-radius: 10px;
                            "
                          >
                            {{ chat.message }}
                          </div>
                        </b-col>
                        <b-col class="text-left" style="color: white">
                          {{ DateFormatter(chat.date) }}
                        </b-col>
                      </b-row>
                    </b-col>
                  </b-row>
                </b-col>
              </template>
              <!-- 실시간 입력으로 받는 값들을 계속해서 추가 -->
            </b-row>
          </template>
        </b-col>
      </b-row>
    </b-jumbotron>
    <!-- 관리자 전용 공지 채팅방일 경우 일반 사용자는 입력창이 사라짐, 그 외에는 입력창이 보임 -->
    <template
      v-if="
        this.$route.params.receiver != 'admin' || this.loginUser.id == 'admin'
      "
    >
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
              <!-- 전송 버튼 -->
              <b-col>
                <a name="target"></a>
                <b-button
                  pill
                  block
                  variant="success"
                  @click="sendMessage"
                  ref="button"
                >
                  전송
                </b-button>
              </b-col>
            </b-row>
          </b-form-group>
        </b-col>
      </b-row>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import http from "@/api/http.js";
export default {
  name: "chatList",
  data() {
    return {
      // 현재 채팅방의 번호
      room_no: "",
      // 내가 입력한 채팅을 받는 수신자 == 상대방
      receiver: "",
      // 마지막으로 입력한 메세지
      crntInputMessage: "",
      // 실시간으로 추가되는 메세지 배열
      realtimeChat: [],
    };
  },
  computed: {
    ...mapGetters(["loginUser", "gettersChatHistory"]),
    // ChatView.vue에서  vuex에 저장한 채팅 내역을 반환
    computedGettersChatHistory() {
      if (this.gettersChatHistory == undefined) return {};
      return this.gettersChatHistory;
    },
    // 실시간으로 입력되는 채팅 목록을 반환
    computedChatList() {
      return this.realtimeChat;
    },
  },
  methods: {
    ...mapActions(["getChatHistory"]),
    moveToDown() {
      //채팅 리스트를 화면에 출력할 때 설정한 아이디를 통해 스크롤을 가장 아래로 이동
      window.location.href =
        "#" + String(Object.keys(this.chatHistory).length - 1);
    },
    // 새로운 채팅을 입력했을 때 새롭게 생성된 채팅으로 이동
    realTimeChatMoveToDown() {
      if (this.computedChatList[this.computedChatList.length - 2] == undefined)
        return;
      window.location.href =
        "#" +
        String(this.computedChatList[this.computedChatList.length - 1].crypto);
      console.log(
        "realTimeChatMoveToDown ",
        String(this.computedChatList[this.computedChatList.length - 1].crypto)
      );
    },

    //일자가 변경되었을 때 그 경계선을 출력
    DayDevider(index) {
      if (index - 1 < 0) {
        let first = this.computedGettersChatHistory[0].date.split(" ");
        let firstSplit = first[0].split("-");
        return (
          firstSplit[0] + "년 " + firstSplit[1] + "월 " + firstSplit[2] + "일"
        );
      }

      let before = this.computedGettersChatHistory[index - 1].date.split(" ");
      let crnt = this.computedGettersChatHistory[index].date.split(" ");

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
    },
    //채팅 입력 시간을 시간:분으로 변경 후 반환
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

    //채팅 목록을 불러왔을 때 불러온 유저 쪽에서 보여지는 알람을 off로 변경
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
    //채팅 목록을 웹서버로부터 가져온 뒤 data()에 저장
    async loadChatHistory() {
      this.room_no = this.$route.params.no;
      this.receiver = this.$route.params.receiver;
      await http
        .get(`/chat/${this.room_no}`)
        .then((res) => {
          this.getChatHistory = res.data;
          this.chatHistory = res.data;
          console.log("loadChatHistory");
        })
        .catch((err) => {
          console.log("loadChatHistory err : ", err);
        });
    },

    //메세지 전송
    sendMessage() {
      if (this.crntInputMessage.trim() != "") {
        let sendMessage = {};
        //랜덤값 생성
        let random = new Uint32Array(1);
        window.crypto.getRandomValues(random);
        //랜덤값 생성 완료

        //채팅 데이터 저장
        sendMessage.crypto = Number(random[0]);
        sendMessage.message = this.crntInputMessage;
        sendMessage.sender = this.loginUser.id;
        sendMessage.receiver = this.receiver;
        sendMessage.room_no = Number(this.room_no);
        sendMessage.loginUserGrade = Number(this.loginUser.grade);

        //웹서버로 채팅 데이터 전송
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
    async openWebSocket() {
      this.webSocket = new WebSocket(`ws://localhost/vue/livechat`);

      this.webSocket.onopen = (event) => {
        console.log("openWebSocket open : ", event);
        // 채팅이 열리면 현재 아이디로 첫 데이터를 전송
        //서버는 입력받은 첫 메세지를 통해 현재 아이디와 해당 세션 값을 map을 통해 저장
        this.webSocket.send(
          JSON.stringify({ setSession: 1, id: this.loginUser.id })
        );
      };

      //데이터 수신
      this.webSocket.onmessage = (event) => {
        const chatMessageDto = JSON.parse(event.data);
        console.log("onmessage : ", chatMessageDto);
        //push로 새로운 값이 화면에 뿌려질 수 있도록 함
        this.realtimeChat.push(chatMessageDto);
      };

      this.webSocket.onclose = (event) => {
        console.log("close : ", event);
      };
    },
  },
  async created() {
    //현재 채팅방의 채팅목록을 불러옴
    await this.loadChatHistory();
    //spring boot를 통해 websocket 통신 시작
    await this.openWebSocket();
    // 웹서버에 알람 아이콘을 끄도록 데이터 전송
    await this.UpdateAlertOff();
    // 채팅 목록을 불러왔다면 가장 하단으로 채팅창이 옮겨져야 함.
    // 하지만 현재 렉이 있을 경우 채팅 목록이 덜 불러와진 채로 실행이 되어 중간까지 옮겨짐
    await this.moveToDown();
  },
  //컴포넌트가 종료된 경우 websocket을 종료
  destroyed() {
    this.closeWebSocket();
  },
};
</script>

<style scoped>
template * {
  color: white;
}
</style>
