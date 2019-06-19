<template>
  <section class="container">
    <div>
      <VegaChart :spec="specDashboard" :renderer="'canvas'"/>
      <br>
      <p>
        <i>Tested on Chrome v75</i>
      </p>
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'

import specDashboard from '~/assets/spec/dashboard.json'

export default {
  components: {
    VegaChart
  },
  data: function() {
    return {
      specDashboard: specDashboard
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
