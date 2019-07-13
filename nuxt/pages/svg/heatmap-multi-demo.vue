<template>
  <section class="container">
    <WarningCard />

    <div class="top-bar">
      <div class="header">
        <h1>Earthquake Damage Report Heat Maps of Neighbourhoods [DEMO]</h1>
        <h2>VAST Challenge 2019</h2>
      </div>
    </div>

    <div class="options">
      <GroupRadio :param="'TimelineControl'" />
      <div class="text-option">
        <span>Colour palette</span>
        <GroupRadio :param="'Colour'" :values="colourRadioVal" />
      </div>
    </div>

    <div>
      <VegaChart :spec="specHeatmap" :renderer="'svg'" :useSignalsFromStore="true" />
    </div>

    <div>
      <InfoButton :isWide="true" />
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'
import GroupRadio from '~/components/GroupRadio.vue'
import WarningCard from '~/components/WarningCard.vue'
import InfoButton from '~/components/InfoButton.vue'

import specHeatmap from '~/assets/spec/heatmap-multi-demo.json'

export default {
  components: {
    VegaChart,
    GroupRadio,
    WarningCard,
    InfoButton
  },
  data: function() {
    return {
      specHeatmap: specHeatmap,
      colourRadioVal: [
        { label: 'VSUP', text: 'VSUP' },
        { label: 'VSUP_', text: 'VSUP Extended' },
        { label: 'Normal', text: 'Normal' }
      ]
    }
  },
  methods: {
    logEvent: function(name, value) {
      console.log(name, value)
    }
  }
}
</script>

<style scoped>
h1,
h2,
h3 {
  margin: 15px 0px;
  color: #35495e;
  font-weight: 300;
  font-size: 30px;
}

.container {
  margin: 30px auto;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.top-bar {
  display: flex;
  width: 1800px;
  height: 100px;
}

.header {
  margin-left: 20px;
  width: 600px;
  text-align: left;
  flex-grow: 1;
}

.options {
  display: flex;
  flex-direction: row;
}

.text-option {
  margin-left: 150px;
  display: flex;
  flex-direction: row;
  align-items: center;
  font-size: 14px;
}
</style>
