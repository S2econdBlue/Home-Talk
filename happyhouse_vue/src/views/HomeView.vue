<template>
  <div id="screen">
    <house-search-bar></house-search-bar>
  </div>
</template>

<script>
import HouseSearchBar from "@/components/house/HouseSearchBar copy.vue";
export default {
  components: {
    HouseSearchBar,
  },
};
</script>

<style>
#screen {
  overflow: hidden;
}
</style>
