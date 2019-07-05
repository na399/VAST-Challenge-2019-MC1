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

    <div class="cat-option">
      <SelectCategory />
    </div>

    <div class="chart">
      <div class="option-bar">
        <div class="left-group">
          <SwitchSlider :param="'HighlightSelectedLoc'" :values="highlightVal" />
          <SwitchSlider :param="'FillMap'" />
          <SwitchSlider :param="'ShowCategory'" :values="showCatVal" />
          <SwitchSlider :param="'ShowName'" :values="showNameVal" />
          <SwitchSlider :param="'ShowFacilities'" :values="showFacilitiesVal" />
        </div>

        <div class="middle-group">
          <GroupRadio :param="'TimelineControl'" />
          <SelectList :param="'SelectLocation'" :values="selectLocationVal" />
        </div>

        <div class="right-group">
          <SelectList :param="'SortOption'" :values="sortOptionVal" />
          <GroupRadio :param="'Colour'" :values="colourRadioVal" />
        </div>
      </div>
      <VegaChart
        :spec="spec"
        :renderer="'canvas'"
        :useSignalsFromStore="true"
        @SelectLocation="handleSelectLocation"
      />
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
      highlightVal: {
        activeText: 'Highlight the selected neighbourhood',
        inactiveText: ''
      },
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
      ],
      selectLocationVal: [
        { value: 1, label: '1 Palace Hills' },
        { value: 2, label: '2 Northwest' },
        { value: 3, label: '3 Old Town' },
        { value: 4, label: '4 Safe Town' }
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
    },
    handleSelectLocation: function(val) {
      this.$store.commit('signals/changeSignal', {
        key: 'SelectLocation',
        val: val
      })
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

.cat-option {
  margin-left: 700px;
  padding: 10px;
  background-color: hsl(0, 0%, 98%);
  border-radius: 10px;
}

.chart {
  position: relative;
}

.option-bar {
  display: flex;
  flex-direction: row;
  align-items: center;
  width: 1800px;
  position: absolute;
  top: 850px;
  left: 0;
  right: 0;
  margin-left: auto;
  margin-right: auto;
  background-color: hsl(0, 0%, 98%);
  border-radius: 10px;
}

.left-group {
  margin-left: 100px;
  flex-grow: 1;
}

.middle-group {
  flex-grow: 2;
}

.right-group {
  margin-left: 50px;
  flex-grow: 3;
}

.left-group > * {
  display: flex;
  align-self: flex-start;
}

.middle-group > *,
.right-group > * {
  margin: 30px 0px;
}

.vega-bindings {
  display: none;
}
</style>
