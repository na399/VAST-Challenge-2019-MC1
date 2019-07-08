<template>
  <section class="container">
    <div>
      <a href="https://vast-challenge.github.io/2019/MC1" target="_blank">
        <h1 class="title">VAST Challenge 2019 MC1</h1>
      </a>
      <a href="https://natthawut.adulyanukosol.com" target="_blank">
        <h2 class="subtitle">Natthawut Adulyanukosol</h2>
      </a>
      <div class="links">
        <n-link to="/svg/MC1-demo" class="button--blue">Demo Dashboard</n-link>
        <n-link to="/canvas/MC1" class="button--blue">Full Dashboard</n-link>
        <n-link to="/canvas/heatmap-multi-demo" class="button--blue">Demo Multiple Heatmap</n-link>
        <n-link to="/canvas/heatmap-multi" class="button--blue">Multiple Heatmap</n-link>
      </div>
      <div class="thumbnail">
        <n-link to="/svg/MC1-demo" class="button--blue">
          <img
            src="~/assets/img/screenshot-full-dashboard.png"
            style="width: 100%; max-width: 555px; height: auto;"
          />
        </n-link>
      </div>
    </div>
  </section>
</template>


<script>
import { Notification } from 'element-ui'

export default {
  head() {
    return {
      meta: [
        { hid: 'viewport', name: 'viewport', content: 'width=device-width' }
      ]
    }
  },
  mounted() {
    this.caution()
  },
  methods: {
    caution() {
      setTimeout(function() {
        Notification({
          title: 'Warning',
          dangerouslyUseHTMLString: true,
          message: `<div style="text-align: left;">
            <ul>
              <li>Optimized for screen (viewport) resolution of 1920 x 1080 pixels</li>
              <li>Required at least 2 GB of available RAM for Full Dashboard & Multiple Heatmap</li>
              <li>Only tested on Chrome v75 and Firefox v67</li>
              <li>May not work on Safari v12 or Mobile</li>
            </ul>
            </div>`,
          type: 'warning',
          position: 'bottom-right',
          duration: 15000
        })
      }, 3000)
    }
  }
}
</script>

<style scoped>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.title {
  font-family: 'Quicksand', 'Source Sans Pro', -apple-system, BlinkMacSystemFont,
    'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  display: block;
  font-weight: 300;
  font-size: 40px;
  color: #35495e;
  letter-spacing: 1px;
  margin: 20px;
}

.subtitle {
  font-weight: 300;
  font-size: 22px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
  margin: 10px;
}
a {
  text-decoration: none;
}

.links {
  padding-top: 15px;
}
</style>
