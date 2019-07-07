<template>
  <section class="container">
    <div class="top-bar">
      <div class="header">
        <h1>Earthquake Damage Report Interactive Dashboard [DEMO]</h1>
        <h2>VAST Challenge 2019</h2>
      </div>
      <div class="cat-option">
        <SelectCategory />
      </div>
    </div>

    <div class="chart">
      <div class="option-bar">
        <div class="left-group">
          <SwitchSlider :param="'FillMap'" />
          <SwitchSlider :param="'ShowCategory'" :values="showCatVal" />
          <SwitchSlider :param="'HighlightSelectedLoc'" :values="highlightVal" />
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
        :renderer="'svg'"
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
  justify-content: center;
  align-items: center;
  text-align: center;
  width: max-content;
  overflow: scroll;
}

.top-bar {
  display: flex;
  width: 1800px;
}

.header {
  margin-left: 20px;
  width: 600px;
  text-align: left;
  flex-grow: 1;
}

.cat-option {
  margin: 0px 190px 0px 0px;
  padding: 10px;
  background-color: hsl(0, 0%, 98%);
  border-radius: 10px;
  flex-grow: 0;
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
</style>

<style>
.vega-bindings {
  display: none;
}
</style>
