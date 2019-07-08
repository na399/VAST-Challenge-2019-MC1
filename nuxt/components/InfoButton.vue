<template>
  <div class="info-button">
    <el-popover
      placement="top-end"
      title="Information"
      :width="width"
      trigger="manual"
      v-model="visible"
    >
      <el-button slot="reference" @click="visible = !visible">
        <i class="el-icon-info" style="font-size:24px"></i>
      </el-button>
      <el-table :data="info" stripe style="width: 100%" height="400">
        <el-table-column fixed label="Neighbourhood" width="190">
          <el-table-column sortable prop="locID" label="#" width="60"></el-table-column>
          <el-table-column sortable prop="locName" label="Name" width="130"></el-table-column>
        </el-table-column>
        <el-table-column label="Ongoing work">
          <el-table-column sortable prop="power" label="Power" width="250"></el-table-column>
          <el-table-column sortable prop="buildings" label="Buildings" width="250"></el-table-column>
          <el-table-column sortable prop="sewer_and_water" label="Sewer & Water" width="250"></el-table-column>
          <el-table-column sortable prop="roads_and_bridges" label="Roads & Bridges" width="250"></el-table-column>
        </el-table-column>
        <el-table-column label="Other">
          <el-table-column prop="overview" label="Overview" width="250"></el-table-column>
          <el-table-column sortable prop="hospital" label="Hospital (H)" width="250"></el-table-column>
        </el-table-column>
      </el-table>
      <br />
      <n-link id="about-link" to="/about">More information about the dashboard</n-link>
    </el-popover>
  </div>
</template>

<script>
import { Popover, Table } from 'element-ui'
import info from '~/static/data/neighbourhoods_info.json'
import infoDemo from '~/static/data/demo/neighbourhoods_info.json'

export default {
  props: {
    isDemo: {
      default: false
    },
    isWide: {
      default: false
    }
  },
  data: function() {
    return {
      info: this.isDemo ? infoDemo : info,
      width: this.isWide ? 1700 : 1020,
      visible: false,
    }
  }
}
</script>

<style>
.info-button {
  position: fixed;
  bottom: 20px;
  right: 20px;
}

.el-table .cell {
  text-align: left;
  word-break: keep-all;
}

#about-link {
  color: #526488;
}
</style>
