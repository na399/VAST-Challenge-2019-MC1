<template>
  <section class="container">
    <div class="content">
      <h1 class="title">About Project</h1>
      <p>
        This project is a submission to
        <a
          href="http://https://vast-challenge.github.io/2019"
          target="_blank"
        >VAST Challenge 2019</a>
        <a href="http://https://vast-challenge.github.io/2019/MC1" target="_blank">Mini-Challenge 1</a> created by
        <a
          href="https://natthawut.adulyanukosol.com"
          target="_blank"
        >Natthawut Adulyanukosol.</a>
      </p>

      <div class="quote">
        <p>The VAST Challenge 2019 presents three mini-challenges and a grand challenge for you to apply your visual analytics research and technologies to help a city grapple with the aftermath of an earthquake that damages their nuclear power plant.</p>
        <p>These challenges are open to participation by individuals and teams in industry, government, and academia. We encourage your submissions and look forward to seeing your innovative approaches to solving these challenges using visual analytics.</p>

        <h2>Overview</h2>
        <p>St. Himark is a vibrant community located in the Oceanus Sea. Home to the world-renowned St.&nbsp;Himark Museum, beautiful beaches, and the Wilson Forest Nature Preserve, St. Himark is one of the region’s best cities for raising a family and provides employment across a number of industries including the Always Safe Nuclear Power Plant. Well, all that was true before the disastrous earthquake that hits the area during the course of this year’s challenge. Mayor Jordan, city officials, and emergency services are overwhelmed and are desperate for assistance in understanding the true situation on the ground and how best to deploy the limited resources available to this relatively small community.</p>

        <h2>Mini-Challenge 1</h2>
        <p>In a prescient move, the city of St. Himark released a new damage reporting mobile application shortly before the earthquake. This app allows citizens to provide more timely information to the city to help them understand damage and prioritize their response. In this mini-challenge, use app responses in conjunction with shake maps of the earthquake strength to identify areas of concern and advise emergency planners.</p>
        <p>
          Please visit
          <a
            href="http://https://vast-challenge.github.io/2019/MC1"
          >VAST Challenge 2019: Mini-Challenge 1</a> for more information and to download the data.
        </p>
        <div style="text-align: right; margin-top: 20px">
          <small>
            Retrived from
            <a
              href="http://https://vast-challenge.github.io/2019"
              target="_blank"
            >VAST Challenge 2019</a>
          </small>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
</script>

<style scoped>
h1,
h2,
h3 {
  margin: 15px 0px;
  color: hsl(215, 99%, 14%);
  font-weight: 300;
  font-size: 30px;
}

a {
  color: #526488;
  text-decoration: none;
}

.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  text-align: left;
}

.content {
  max-width: 800px;
  margin-top: 5px;
  padding: 20px;
}

.quote {
  margin: 20px;
  padding: 30px;
  background-color: hsl(0, 0%, 95%);
  border-radius: 10px;
}

.title {
  font-family: 'Quicksand', 'Source Sans Pro', -apple-system, BlinkMacSystemFont,
    'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  display: block;
  font-weight: 300;
  font-size: 40px;
  color: #35495e;
  letter-spacing: 1px;
  text-align: center;
}

.subtitle {
  font-weight: 300;
  font-size: 22px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
