<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="dark">
      <b-navbar-brand href="#">
        <router-link to="/">
          <b-img :src="image" thumbnail fluid style="width: 100px"> </b-img>
        </router-link>
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item href="#">
            <router-link :to="{ name: 'home' }" class="link">
              <b-icon icon="house" font-scale="1.5"></b-icon>
              메인화면
            </router-link>
          </b-nav-item>
          <b-nav-item href="#">
            <router-link :to="{ name: 'board' }" class="link">
              <b-icon icon="journal" font-scale="1.5"> </b-icon>
              매물 등록 게시판
            </router-link>
          </b-nav-item>
          <b-nav-item href="#">
            <router-link :to="{ name: 'chat' }" class="link">
              <b-icon icon="inbox-fill" font-scale="1.5"></b-icon>
              상담 관리
            </router-link>
          </b-nav-item>
          <b-nav-item href="#">
            <router-link :to="{ name: 'house' }" class="link">
              <b-icon icon="house-fill" font-scale="1.5"></b-icon>
              아파트정보
            </router-link>
          </b-nav-item>
          <!-- <b-nav-item href="#"
            ><router-link :to="{ name: 'todo' }" class="link"
              ><b-icon icon="calendar-check" font-scale="1.5"></b-icon>
              TodoList</router-link
            ></b-nav-item
          > -->
        </b-navbar-nav>

        <b-navbar-nav class="ml-auto">
          <b-card class="text-center" v-if="this.loginUser.id"
            ><div>{{ this.loginUser.id }}님</div></b-card
          >
          <b-nav-item-dropdown right>
            <template #button-content>
              <b-icon icon="people" font-scale="2"></b-icon>
            </template>

            <template v-if="!this.loginUser.id">
              <b-dropdown-item href="#"
                ><router-link :to="{ name: 'signUp' }" class="link"
                  ><b-icon icon="person-circle"></b-icon> 회원가입</router-link
                ></b-dropdown-item
              >
              <b-dropdown-item href="#"
                ><router-link :to="{ name: 'signIn' }" class="link"
                  ><b-icon icon="key"></b-icon> 로그인</router-link
                ></b-dropdown-item
              >
            </template>
            <template v-else>
              <b-dropdown-item href="#"
                ><router-link :to="{ name: 'info' }" class="link"
                  ><b-icon icon="person-circle"></b-icon>회원정보</router-link
                ></b-dropdown-item
              >
              <b-dropdown-item href="#" @click="this.logout"
                ><router-link :to="{ name: 'home' }" class="link"
                  ><b-icon icon="key"></b-icon> 로그아웃</router-link
                ></b-dropdown-item
              >
            </template>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
import image from "@/assets/R.png";
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
  created() {
    console.log(this.loginUser);
  },
  methods: {
    ...mapActions(["logout"]),
  },
};
</script>

<style></style>
