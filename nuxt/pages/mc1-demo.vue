<template>
  <section class="container">
    <SelectCategory />
    <div>
      <VegaChart :spec="spec" :renderer="'canvas'" />
      <br />
      <p>
        <i>Optimized for screen width of 1920px</i>
      </p>
      <p>
        <i>Only tested on Chrome v75</i>
      </p>
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'
import SelectCategory from '~/components/SelectCategory.vue'

import spec from '~/assets/spec/MC1demo.json'

export default {
  components: {
    VegaChart,
    SelectCategory
  },
  data: function() {
    return {
      spec: spec,
    }
  },
  head() {
    return {
      meta: [{ hid: 'viewport', name: 'viewport', content: 'width=1920' }]
    }
  },
  methods: {
    logEvent: function(name, val) {
      console.log(name, val)
    }
  }
}
</script>

<style>
.container {
  margin: 30px auto;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  width: max-content;
  overflow: scroll;
}

.vega-bind-name {
  padding: 0px 10px;
}

.vega-bind-radio * {
  padding: 0px 5px;
}
</style>
