<template>
  <div class="group-radio">
    <el-radio-group @change="changeSignal" v-model="val" size="medium">
      <el-radio-button
        v-for="val in values"
        v-bind:key="val.label"
        :label="val.label"
      >{{ val.text }}</el-radio-button>
    </el-radio-group>
  </div>
</template>

<script>
import { Radio } from 'element-ui'

export default {
  name: 'GroupRadio',
  props: {
    param: {
      default: 'TimelineControl'
    },
    values: {
      default: () => [
        { label: 'Play', text: 'Play ▶︎' },
        { label: 'Pause', text: '|| Pause' }
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
.group-radio {
  margin: 10px;
}
</style>
