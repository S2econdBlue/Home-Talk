<template>
  <div id="app">
    <!-- 
      style="position: fixed; z-index: 11; width: 100%; top: 0px" -->
    <navi-bar></navi-bar>
    <!-- style="position: absolute; top: 70px" -->
    <router-view></router-view>
  </div>
</template>

<script>
import NaviBar from "@/components/layout/HeaderNaviBar.vue";

export default {
  name: "App",
  components: {
    NaviBar,
  },
};
</script>

<style>
a {
  text-decoration: none;
}

a:hover {
  text-decoration: none;
  font-weight: bold;
  color: rgb(255, 255, 255);
}

a.router-link-exact-active {
  color: #db1637;
}
</style>
