<template>
  <section class="container">
    <div>
      <VegaChart :spec="specErrorBar" :renderer="'canvas'" />
      <p><i>Tested on Chrome v75</i></p>
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'

import specErrorBar from '~/assets/spec/errorbar.json'


export default {
  components: {
    VegaChart
  },
  data: function() {
    return {
      specErrorBar: specErrorBar,
    }
  },
  methods: {
    logEvent: function(name, value) {
      console.log(name, value)
    }
  }
}
</script>

<style>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}
</style>
