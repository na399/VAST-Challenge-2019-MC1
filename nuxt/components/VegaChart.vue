<template>
  <div
    v-loading.fullscreen.lock="fullscreenLoading"
    element-loading-text="With massive quakes come massive data ... that is being loaded and analyzed."
    element-loading-background="rgba(0, 0, 0, 0.8)"
  ></div>
</template>

<script>
import * as vega from 'vega'

import { Loading } from 'element-ui'

export default {
  name: 'VegaChart',
  props: {
    spec: {
      type: Object,
      default: null
    },
    renderer: {
      default: 'svg'
    },
    hover: {
      default: 'hover'
    }
  },
  data: function() {
    return {
      view: null,
      fullscreenLoading: false
    }
  },
  computed: {
    signals() {
      return this.$store.state.signals
    }
  },
  mounted: function() {
    this.fullscreenLoading = true
    this.view = this.createView(this.spec)
  },
  beforeDestroy: function() {
    if (this.view) {
      this.view.finalize()
    }
  },
  watch: {
    spec: {
      handler: function() {
        this.view = this.createView(this.spec)
      },
      deep: true
    },
    signals: {
      handler: function() {
        this.signalsHandler()
      },
      deep: true
    }
  },
  methods: {
    createView: function(spec) {
      const runtime = vega.parse(spec)

      const view = new vega.View(runtime)
        .renderer(this.renderer)
        .hover(this.hover)
        .initialize(this.$el)

      view.initialize(this.$el)

      if (spec.signals) {
        this.addSignalEmitter(spec, view)
      }

      view.runAsync().then(() => {
        this.signalsHandler()
        this.fullscreenLoading = false
      })

      return view
    },
    addSignalEmitter: function(spec, view) {
      if (view && spec && spec.signals.length > 0) {
        spec.signals.forEach(signal => {
          view.addSignalListener(signal.name, (name, value) =>
            this.$emit(name, value)
          )
        })
      }
    },
    signalsHandler: function() {
      let state = this.view.getState()

      if (this.signals !== null) {
        for (const key in this.signals) {
          const val = this.signals[key]
          state['signals'][key] = val
        }

        this.view.setState(state)
      }
    }
  }
}
</script>

<style>
</style>
