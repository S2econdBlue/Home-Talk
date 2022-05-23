<template>
  <b-container class="bv-example-row mt-3">
    <b-row>
      <b-col>
        <b-alert variant="secondary" show><h3>로그인</h3></b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-card class="text-center mt-3" style="max-width: 40rem" align="left">
          <b-form class="text-left">
            <b-alert show variant="danger" v-if="isError"
              >아이디 또는 비밀번호를 확인하세요.</b-alert
            >
            <b-form-group label="아이디:" label-for="userid">
              <b-form-input
                id="userid"
                v-model="user.userid"
                required
                placeholder="아이디 입력...."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-form-group label="비밀번호:" label-for="userpwd">
              <b-form-input
                type="password"
                id="userpw"
                v-model="user.userpw"
                required
                placeholder="비밀번호 입력...."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-button
              type="button"
              variant="primary"
              class="m-1"
              @click="confirm"
              >로그인</b-button
            >
            <router-link :to="{ name: 'signUp' }"
              ><b-button type="button" variant="success" class="m-1"
                >회원가입</b-button
              ></router-link
            >
          </b-form>
        </b-card>
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions } from "vuex";
import http from "@/api/http";
export default {
  name: "MemberLogin",
  data() {
    return {
      isError: false,
      user: {
        id: "",
        pw: "",
      },
    };
  },
  computed: {},
  methods: {
    ...mapActions(["loginSuccess"]),
    // 아이디, 비밀번호 입력하면 db 조회 후 로그인 세팅하기
    confirm() {
      if (this.user.userid.trim() == "" || this.user.userpw.trim() == "") {
        this.isError = true;
        return;
      }
      this.RequestLogin();
    },
    RequestLogin() {
      http
        .post("/user/login", this.user)
        .then((res) => {
          if (res.data == "") {
            alert("아이디나 비밀번호가 틀렸습니다.");
          } else {
            this.loginSuccess(res.data);
            this.$router.push({ name: "home" });
          }
        })
        .catch();
    },
  },
};
</script>

<style></style>
