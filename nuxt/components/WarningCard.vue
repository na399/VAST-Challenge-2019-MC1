<template>
  <div class="warning-card" v-if="warningShown == false">
    <el-dialog type="warning" title="Caution" :visible.sync="dialogVisible" width="720px">
      <div class="caution">
        <ul>
          <li>Full Dashboard & Multiple Heatmap require at least 2 GB of available RAM.</li>
          <li>If the site becomes unresponsive, please consider closing the tab and opening a new one.</li>
          <li>Some interactions may not function properly on the dashboards rendered as canvas.</li>
          <li>Optimized for screen (viewport) resolution of 1920 x 1080 pixels</li>
          <li>Only tested on Chrome v75 and Firefox v67</li>
          <li>May not work on Safari v12 or Mobile</li>
        </ul>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button type="warning" @click="dialogVisible = false; acknowledged()">Acknowledged</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { Dialog } from 'element-ui'

export default {
  name: 'WarningCard',
  data: function() {
    return {
      dialogVisible: true
    }
  },
  computed: {
    warningShown() {
      return this.$store.state.sessionStorage.warningShown
    }
  },
  methods: {
    acknowledged: function() {
      this.$store.commit('sessionStorage/registerWarningShown')
    }
  }
}
</script>

<style>
.caution {
  text-align: left;
  text-justify: none;
  color: salmon;
}

.caution * {
  margin: 10px;
}
</style>
