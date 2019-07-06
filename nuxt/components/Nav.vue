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
        <el-menu-item index="MC1-demo">Demo Dashboard</el-menu-item>
        <el-menu-item index="MC1">Full Dashboard</el-menu-item>
        <el-menu-item index="Heatmap-multi">Multiple Heat Map</el-menu-item>
      </el-submenu>
      <el-menu-item index="about">
        <i class="el-icon-user"></i>
        <span slot="title">About Us</span>
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
