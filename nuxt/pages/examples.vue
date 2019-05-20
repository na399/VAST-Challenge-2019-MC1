<template>
  <section class="container">
    <div>
      <VegaChart :spec="specSampleBar" @tooltip="logEvent"/>
      <VegaChart :spec="specErrorBar"/>
      <VegaChart :spec="specCrossfilter"/>
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'

import specSampleBar from '~/assets/spec/sample-bar.json'
import specErrorBar from '~/assets/spec/sample-errorbar.json'
import specCrossfilter from '~/assets/spec/crossfilter.json'

export default {
  components: {
    VegaChart
  },
  data: function() {
    return {
      specSampleBar: specSampleBar,
      specErrorBar: specErrorBar,
      specCrossfilter: specCrossfilter
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
