<template>
  <div id="categories">
    <div>
      <el-radio v-model="selectedCategory" label="shake_intensity" border>Shake Intensity</el-radio>
      <el-radio v-model="selectedCategory" label="medical" border>Medical</el-radio>
      <el-radio v-model="selectedCategory" label="power" border>Power</el-radio>
    </div>
    <div style="margin-top: 20px">
      <el-radio v-model="selectedCategory" label="buildings" border>Buildings</el-radio>
      <el-radio v-model="selectedCategory" label="sewer_and_water" border>Sewer & Water</el-radio>
      <el-radio v-model="selectedCategory" label="roads_and_bridges" border>Roads & Bridges</el-radio>
    </div>
  </div>
</template>

<script>
import { Radio } from 'element-ui'

export default {
  name: 'SelectCategory',
  props: {
    default: {
      default: 'shake_intensity'
    }
  },
  data: function() {
    return {
      selectedCategory: this.default
    }
  },
  watch: {
    selectedCategory: {
      handler: function() {
        this.$emit('change', 'SelectCategory', this.selectedCategory)
      }
    }
  },
  methods: {}
}
</script>

<style>
#categories {
  margin-left: 666px;
}

.el-radio {
  width: 200px;
}
</style>
