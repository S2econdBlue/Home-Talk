<template>
  <div>
    <b-navbar type="dark" variant="dark">
      <b-row align-h="around" class="w-100" align-v="center">
        <b-col cols="4">
          <b-navbar-nav>
            <b-nav-item href="#">
              <router-link :to="{ name: 'home' }" class="link">
                메인화면
              </router-link>
            </b-nav-item>
            <b-nav-item href="#">
              <router-link :to="{ name: 'board' }" class="link">
                매물 등록 게시판
              </router-link>
            </b-nav-item>
            <b-nav-item href="#">
              <router-link :to="{ name: 'chat' }" class="link">
                상담 관리
              </router-link>
            </b-nav-item>
          </b-navbar-nav>
        </b-col>
        <b-col cols="2"></b-col>
        <b-col cols="1" class="nav justify-content-start bg-light">
          <b-navbar-brand href="#">
            <router-link to="/">
              <b-img :src="image" thumbnail fluid style="width: 100px"> </b-img>
            </router-link>
          </b-navbar-brand>
        </b-col>
        <b-col></b-col>
        <b-col cols="3">
          <b-row align-h="end" align-v="center">
            <template v-if="this.loginUser.id">
              <b-col cols="5">
                <router-link :to="{ name: 'info' }" class="link">
                  <div style="text-align: center; color: white">
                    {{ this.loginUser.id }}님
                  </div>
                </router-link>
              </b-col>
              <b-col cols="4">
                <router-link :to="{ name: 'home' }" class="link">
                  로그아웃
                </router-link>
              </b-col>
            </template>
            <template v-else>
              <b-col class="float-right">
                <router-link :to="{ name: 'signUp' }" class="link">
                  회원가입
                </router-link>
              </b-col>
              <b-col class="float-right">
                <router-link :to="{ name: 'signIn' }" class="link">
                  로그인
                </router-link>
              </b-col>
            </template>
          </b-row>
        </b-col>
      </b-row>
    </b-navbar>
  </div>
</template>

<script>
import image from "@/assets/logo.jpg";
import { mapGetters, mapActions } from "vuex";
export default {
  name: "HeaderNaviBar",
  data() {
    return {
      image,
    };
  },
  computed: {
    ...mapGetters(["loginUser"]),
  },
  created() {},
  methods: {
    ...mapActions(["logout"]),
  },
};
</script>

<style>
a {
  text-decoration: none;
  color: rgb(255, 255, 255);
}

a:hover {
  text-decoration: none;
  font-weight: bold;
  color: rgb(42, 132, 250);
}

a.router-link-exact-active {
  color: rgb(42, 132, 250);
  font-weight: bold;
}
</style>
