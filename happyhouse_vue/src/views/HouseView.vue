<template>
  <b-container class="bv-example-row mt-3 text-center">
    <h3 class="underline-orange">
      <b-icon icon="house-fill"></b-icon> 상권조회
    </h3>
    <b-row>
      <b-col>
        <house-search-bar></house-search-bar>
      </b-col>
    </b-row>
    <!-- <b-row>
      <b-col cols="12">
        <map-around />
      </b-col>
    </b-row> -->
  </b-container>
</template>
<script>
import HouseSearchBar from "@/components/house/HouseSearchBar copy.vue";
// import MapAround from "@/components/house/MapAround.vue";

export default {
  name: "HouseView",
  components: {
    HouseSearchBar,
    // MapAround,
  },
};
</script>
<style scoped>
.underline-orange {
  display: inline-block;
  background: linear-gradient(
    180deg,
    rgba(255, 255, 255, 0) 70%,
    rgba(231, 149, 27, 0.3) 30%
  );
}
</style>
