<template>
  <div id="categories">
    <div>
      <el-radio @change="changeSignal" v-model="val" label="shake_intensity" border>Shake Intensity</el-radio>
      <el-radio @change="changeSignal" v-model="val" label="medical" border>Medical</el-radio>
      <el-radio @change="changeSignal" v-model="val" label="power" border>Power</el-radio>
    </div>
    <div style="margin-top: 20px">
      <el-radio @change="changeSignal" v-model="val" label="buildings" border>Buildings</el-radio>
      <el-radio @change="changeSignal" v-model="val" label="sewer_and_water" border>Sewer & Water</el-radio>
      <el-radio
        @change="changeSignal"
        v-model="val"
        label="roads_and_bridges"
        border
      >Roads & Bridges</el-radio>
    </div>
  </div>
</template>

<script>
import { Radio } from 'element-ui'

export default {
  name: 'SelectCategory',
  props: {
    name: {
      default: 'SelectCategory'
    }
  },
  data: function() {
    return {
      val: null
    }
  },
  computed: {
    selectedCategory() {
      return this.$store.state.signals.SelectCategory
    }
  },
  created: function() {
    this.val = this.selectedCategory
  },
  methods: {
    changeSignal: function() {
      this.$store.commit('signals/changeSignal', {
        key: this.name,
        val: this.val
      })
    }
  }
}
</script>

<style>
#categories {
  margin: 10px 10px 10px 700px;
}

.el-radio {
  width: 200px;
}
</style>
