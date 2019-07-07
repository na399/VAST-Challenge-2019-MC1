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
        <a href="svg/MC1-demo" class="button--blue">Demo Dashboard</a>
        <a href="svg/MC1" class="button--blue">Full Dashboard</a>
        <a href="canvas/heatmap-multi" class="button--blue">Multiple Heatmap</a>
      </div>
      <div class="caution">
        <p></p>
        <p>
          <i>Optimized for screen resolution of 1920 x 1080px</i>
        </p>
        <p>
          <i>Require at least 300 MB of RAM for Demo Dashboard</i>
        </p>
        <p>
          <i>Require at least 2 GB of RAM for Full Dashboard & Multiple Heatmap</i>
        </p>
        <p>
          <i>Only tested on Chrome v75 and Firefox v67</i>
        </p>
        <p>
          <i>May not work on Safari v12 or Mobile</i>
        </p>
      </div>
    </div>
  </section>
</template>

<script>
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

.caution {
  margin: 40px;
  color: salmon;
}

.caution * {
  margin: 10px;
}
</style>
