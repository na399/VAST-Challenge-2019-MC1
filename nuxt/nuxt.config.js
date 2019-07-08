import pkg from './package'

export default {
  mode: 'spa',

  /*
   ** Headers of the page
   */
  head: {
    title: 'VAST Challenge 2019 MC1',
    meta: [
      { charset: 'utf-8' },
      {
        hid: 'viewport',
        name: 'viewport',
        content: 'width=1920'
      },
      {
        hid: 'description',
        name: 'description',
        content:
          'Visual Analytics Science and Technology (VAST) Challenge 2019 submission by Natthawut Adulyanukosol'
      },
      { hid: 'author', name: 'author', content: pkg.author }
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }]
  },

  /*
   ** Customize the progress-bar color
   */
  loading: { color: '#35495e' },

  /*
   ** Global CSS
   */
  css: ['element-ui/lib/theme-chalk/index.css', '~/assets/main.css'],

  /*
   ** Plugins to load before mounting the App
   */
  plugins: ['@/plugins/element-ui'],

  /*
   ** Nuxt.js modules
   */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    // '@nuxtjs/axios',
    '@nuxtjs/pwa',
    '@nuxtjs/google-analytics',
    'nuxt-vuex-localstorage',
    [
      'nuxt-social-meta',
      {
        title: 'VAST Challenge 2019 MC1 by N. Adulyanukosol',
        description:
          'Visual Analytics Science and Technology (VAST) Challenge 2019 submission by Natthawut Adulyanukosol',
        img: 'img/screenshot-full-dashboard-top.png',
        locale: 'en_gb',
        twitter: '@MaxNAdul',
        themeColor: '#35495e'
      }
    ]
  ],
  /*
   ** Analytics module configuration
   */
  googleAnalytics: {
    id: 'UA-98889378-3'
  },

  /*
   ** Build configuration
   */
  build: {
    transpile: [/^element-ui/],

    /*
     ** You can extend webpack config here
     */
    extend(config, ctx) {
      // Run ESLint on save
      if (ctx.isDev && ctx.isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          // loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  },

  /*
   ** Generate configuration
   */
  generate: {
    subFolders: false
  }
}
