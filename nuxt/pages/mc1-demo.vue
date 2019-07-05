<template>
  <section class="container">
    <div class="caution">
      <p>
        <b>
          <i>WORK IN PROGRESS</i>
        </b>
      </p>
      <p>
        <i>Optimized for screen resolution of 1920 x 1080px</i>
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

    <div>
      <SelectCategory />
    </div>

    <div class="chart">
      <div class="option-bar">
        <div class="left-group">
          <SwitchSlider :param="'FillMap'" />
          <SwitchSlider :param="'ShowCategory'" :values="showCatVal" />
          <SwitchSlider :param="'ShowName'" :values="showNameVal" />
          <SwitchSlider :param="'ShowFacilities'" :values="showFacilitiesVal" />
        </div>

        <div class="middle-group">
          <GroupRadio :param="'TimelineControl'" />
          <SelectList :param="'SelectLocation'" />
        </div>

        <div class="right-group">
          <SelectList :param="'SortOption'" :values="sortOptionVal" />
          <GroupRadio :param="'Colour'" :values="colourRadioVal" />
        </div>
      </div>
      <VegaChart :spec="spec" :renderer="'canvas'" :useSignalsFromStore="true" />
    </div>

    <div>
      <SwitchSlider :param="'ShowRawReports'" :values="showRawReportsVal" />
    </div>
  </section>
</template>

<script>
import VegaChart from '~/components/VegaChart.vue'
import SelectCategory from '~/components/SelectCategory.vue'
import GroupRadio from '~/components/GroupRadio.vue'
import SwitchSlider from '~/components/SwitchSlider.vue'
import SelectList from '~/components/SelectList.vue'

import spec from '~/assets/spec/MC1demo.json'

export default {
  components: {
    VegaChart,
    SelectCategory,
    GroupRadio,
    SwitchSlider,
    SelectList
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
      sortOptionVal: [
        { value: 'hdi95\\.lower', label: '95% CI lower bound' },
        { value: 'hdi80\\.lower', label: '80% CI lower bound' },
        { value: 'hdi50\\.lower', label: '50% CI lower bound' },
        { value: 'MAP', label: 'MAP' }
      ]
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
  color: salmon;
}

.vega-bindings {
  display: none;
}

.chart{
  position: relative;
}

.option-bar {
  display: flex;
  flex-direction: row;
  align-items: center;
  width: 1600px;
  position: absolute;
  top: 850px;
  left: 0;
  right: 0;
  margin-left: auto;
  margin-right: auto;
}

.left-group,
.middle-group {
  flex-grow: 1;
}

.right-group {
  flex-grow: 2;
}

.left-group > * {
  display: flex;
  align-self: flex-start;
}

.middle-group > *,
.right-group > * {
  margin: 30px 0px;
}
</style>
