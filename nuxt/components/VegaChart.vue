<template>
  <div></div>
</template>

<script>
import * as vega from 'vega'

export default {
  name: 'VegaChart',
  props: {
    spec: {
      type: Object,
      default: null
    },
    renderer: {
      default: 'canvas'
    },
    hover: {
      default: 'hover'
    }
  },
  data: function() {
    return {
      view: {}
    }
  },
  mounted: function() {
    this.view = this.createView(this.spec)
  },
  beforeDestroy: function() {
    this.view.finalize()
  },
  watch: {
    spec: {
      handler: function() {
        this.view = this.createView(this.spec)
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

      this.addSignalEmitter(spec, view)

      view.run()

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
    }
  }
}
</script>

<style>
</style>
