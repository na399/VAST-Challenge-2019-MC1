<template>
  <div class="select-list">
    <el-select @change="changeSignal" v-model="val" filterable>
      <el-option v-for="item in values" :key="item.value" :label="item.label" :value="item.value"></el-option>
    </el-select>
  </div>
</template>

<script>
import { Select } from 'element-ui'

export default {
  name: 'SelectList',
  props: {
    param: {
      default: 'SelectLocation'
    },
    values: {
      default: () => [
        { value: 1, label: '1 Palace Hills' },
        { value: 2, label: '2 Northwest' },
        { value: 3, label: '3 Old Town' },
        { value: 4, label: '4 Safe Town' },
        { value: 5, label: '5 Southwest' },
        { value: 6, label: '6 Downtown' },
        { value: 7, label: '7 Wilson Forest' },
        { value: 8, label: '8 Scenic Vista' },
        { value: 9, label: '9 Broadview' },
        { value: 10, label: '10 Chapparal' },
        { value: 11, label: '11 Terrapin' },
        { value: 12, label: '12 Pepper Mill' },
        { value: 13, label: '13 Cheddarford' },
        { value: 14, label: '14 Easton' },
        { value: 15, label: '15 Weston' },
        { value: 16, label: '16 Southton' },
        { value: 17, label: '17 Oak Willow' },
        { value: 18, label: '18 East Parton' },
        { value: 19, label: '19 West Parton' }
      ]
    }
  },
  data: function() {
    return {
      val: null
    }
  },
  computed: {
    storedVal() {
      return this.$store.state.signals[this.param]
    }
  },
  created: function() {
    this.val = this.storedVal
  },
  methods: {
    changeSignal: function() {
      this.$store.commit('signals/changeSignal', {
        key: this.param,
        val: this.val
      })
    }
  }
}
</script>

<style>
.select-list {
  margin: 10px;
}
</style>
