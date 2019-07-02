<template>
  <section class="container">
    <div>
      <VegaChart :spec="specMC1" :renderer="'canvas'"/>
      <br>
      <p>
        <i>Only tested on Chrome v75</i>
      </p>
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'

import specMC1 from '~/assets/spec/MC1demo.json'

export default {
  components: {
    VegaChart
  },
  data: function() {
    return {
      specMC1: specMC1
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
