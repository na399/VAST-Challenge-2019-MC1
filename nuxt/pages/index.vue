<template>
  <section class="container">
    <div>
      <a href="https://vast-challenge.github.io/2019/MC1" target="_blank">
        <h1 class="title">VAST Challenge 2019 MC1</h1>
      </a>
      <h2 class="subtitle">
        Visual Analytics Science and Technology (VAST) Challenge 2019 submission
        <br />by
        <a href="https://natthawut.adulyanukosol.com" target="_blank">Natthawut Adulyanukosol</a>
      </h2>
      <h2 class="subtitle">Award for Operationalizing Visualization Theory</h2>
      <div class="links">
        <div>
          <n-link to="/svg/MC1-demo" class="button--blue page-link">Demo Dashboard</n-link>
          <n-link to="/canvas/MC1" class="button--blue page-link">Full Dashboard</n-link>
        </div>
        <div>
          <n-link
            to="/canvas/heatmap-multi-demo"
            class="button--blue page-link"
          >Demo Multiple Heat Maps</n-link>
          <n-link to="/canvas/heatmap-multi" class="button--blue page-link">Multiple Heat Maps</n-link>
        </div>
      </div>
      <div class="thumbnail">
        <n-link to="/svg/MC1-demo" class="button--blue">
          <video
            id="gif-mp4"
            poster="/img/dashboard-thumbnail-s.gif"
            style="margin: 0; padding: 0; width: 100%; max-width: 480px; height: auto;"
            autoplay
            loop
          >
            <source
              src="~/assets/img/dashboard-thumbnail.mp4"
              type="video/mp4; codecs=&quot;avc1.42E01E, mp4a.40.2&quot;"
            />
            <img
              src="~/assets/img/dashboard-thumbnail.gif"
              title="Your browser does not support the mp4 video codec."
            />
          </video>
        </n-link>
      </div>
      <div class="links">
        <div>
          <n-link to="/about" class="button--blue page-link">About the Project</n-link>
        </div>
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
  font-size: 20px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
  margin: 10px;
}
a {
  color: #409eff;
  text-decoration: none;
}

.links {
  padding-top: 15px;
}

.page-link {
  width: 260px;
}
</style>
