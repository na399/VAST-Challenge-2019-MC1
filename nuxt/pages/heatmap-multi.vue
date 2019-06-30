<template>
  <section class="container">
    <div>
      <VegaChart :spec="specHeatmap" :renderer="'canvas'"/>
      <br>
      <p>
        <i>Only tested on Chrome v75</i>
      </p>
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'

import specHeatmap from '~/assets/spec/heatmap-multi.json'

export default {
  components: {
    VegaChart
  },
  data: function() {
    return {
      specHeatmap: specHeatmap
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

.vega-bind-name {
  padding: 0px 10px;
}

.vega-bind-radio * {
  padding: 0px 5px;
}
</style>
