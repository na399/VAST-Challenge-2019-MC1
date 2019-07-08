<template>
  <div class="nav">
    <el-menu :collapse="true" :router="true">
      <el-menu-item index="/">
        <i class="el-icon-house"></i>
        <span slot="title">Home</span>
      </el-menu-item>
      <el-submenu index="/">
        <template slot="title">
          <i class="el-icon-data-analysis"></i>
          <span slot="title">Pages</span>
        </template>
        <el-menu-item-group title="SVG">
          <el-menu-item index="/svg/MC1-demo">Demo Dashboard</el-menu-item>
          <el-menu-item index="/svg/MC1">Full Dashboard</el-menu-item>
          <el-menu-item index="/svg/Heatmap-multi">Multiple Heat Maps</el-menu-item>
        </el-menu-item-group>
        <el-menu-item-group title="Canvas">
          <el-menu-item index="/canvas/MC1-demo">Demo Dashboard</el-menu-item>
          <el-menu-item index="/canvas/MC1">Full Dashboard</el-menu-item>
          <el-menu-item index="/canvas/Heatmap-multi">Multiple Heat Maps</el-menu-item>
        </el-menu-item-group>
      </el-submenu>
      <el-menu-item index="/about">
        <i class="el-icon-reading"></i>
        <span slot="title">About the Project</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
import { Menu } from 'element-ui'

export default {}
</script>

<style>
.nav {
  opacity: 0.5;
  position: absolute;
  top: 20px;
  right: 20px;
}
</style>
