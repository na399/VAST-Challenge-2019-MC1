<template>
  <div class="switch">
    <el-switch
      @change="changeSignal"
      v-model="val"
      :active-value="values.activeVal"
      :inactive-value="values.inactiveVal"
      :active-text="values.activeText"
      :inactive-text="values.inactiveText"
      :disabled="disabled"
    ></el-switch>
  </div>
</template>

<script>
import { Switch } from 'element-ui'

export default {
  name: 'SwitchSlider',
  props: {
    param: {
      default: 'FillMap'
    },
    values: {
      default: () => ({
        activeVal: true,
        inactiveVal: false,
        activeText: 'Fill neighbourhoods with colours',
        inactiveText: ''
      })
    }
  },
  data: function() {
    return {
      val: null,
      valBeforeDisabled: null,
      disabled: false
    }
  },
  computed: {
    storedVal() {
      return this.$store.state.signals[this.param]
    },
    showCategorySignal() {
      return this.$store.state.signals.ShowCategory
    }
  },
  watch: {
    showCategorySignal: function() {
      if (this.param == 'FillMap') {
        if (this.showCategorySignal == 'All') {
          this.valBeforeDisabled = this.val
          this.val = false
          this.disabled = true
        } else {
          this.val = this.valBeforeDisabled
          this.disabled = false
        }
      }
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
.switch {
  margin: 10px;
}
</style>
