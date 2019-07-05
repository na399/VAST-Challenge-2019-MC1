<template>
  <section class="container">
    <div class="caution">
      <p>
        <b>
          <i>WORK IN PROGRESS</i>
        </b>
      </p>
      <p>
        <i>Optimized for screen width of 1920px</i>
      </p>
      <p>
        <i>Require at least 300 MB of RAM</i>
      </p>
      <p>
        <i>Only tested on Chrome v75</i>
      </p>
      <p>
        <i>May not work on Mobile</i>
      </p>
    </div>
    <SelectCategory />
    <GroupRadio :param="'TimelineControl'" />
    <GroupRadio :param="'Colour'" :values="colourRadioVal" />
    <SwitchSlider :param="'FillMap'" />
    <SwitchSlider :param="'ShowCategory'" :values="showCatVal" />
    <SwitchSlider :param="'ShowName'" :values="showNameVal" />
    <SwitchSlider :param="'ShowFacilities'" :values="showFacilitiesVal" />
    <SwitchSlider :param="'ShowRawReports'" :values="showRawReportsVal" />
    <div>
      <VegaChart :spec="spec" :renderer="'canvas'" :useSignalsFromStore="true" />
      <br />
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'
import SelectCategory from '~/components/SelectCategory.vue'
import GroupRadio from '~/components/GroupRadio.vue'
import SwitchSlider from '~/components/SwitchSlider.vue'

import spec from '~/assets/spec/MC1demo.json'

export default {
  components: {
    VegaChart,
    SelectCategory,
    GroupRadio,
    SwitchSlider
  },
  data: function() {
    return {
      spec: spec,
      colourRadioVal: [
        { label: 'VSUP', text: 'VSUP' },
        { label: 'VSUP_', text: 'VSUP Extended' },
        { label: 'Normal', text: 'Normal' }
      ],
      showCatVal: {
        activeVal: 'All',
        inactiveVal: 'Single',
        activeText: 'Show all categories on the map',
        inactiveText: ''
      },
      showNameVal: {
        activeText: 'Show neighbourhood names',
        inactiveText: ''
      },
      showFacilitiesVal: {
        activeText: 'Show hospitals and the nuclear plant',
        inactiveText: ''
      },
      showRawReportsVal: {
        activeText: 'Show raw reports on the line charts',
        inactiveText: ''
      },
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

.caution {
  margin: 20px;
}

.vega-bind-name {
  padding: 0px 10px;
}

.vega-bind-radio * {
  padding: 0px 5px;
}
</style>
