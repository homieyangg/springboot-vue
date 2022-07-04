<template>
  <div style="height: 50px; line-height: 50px; border-bottom: 1px solid #ccc; display: flex">
    <div style="width: 200px; padding-left: 30px; font-weight: bold; color: cornflowerblue">後台管理</div>
    <div style="flex: 1"></div>
    <div style="width: 100px">
      <el-dropdown style="line-height: 50px">
        <span class="el-dropdown-link">
          管理員
          <el-icon class="el-icon--right">
            <ArrowDown/>
          </el-icon>
        </span>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item>個人資訊</el-dropdown-item>
            <el-dropdown-item @click="$router.push('/login')">退出系統</el-dropdown-item>
            </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script>
import {ArrowDown} from "@element-plus/icons";
export default {
  name: "Header",
  components: {ArrowDown}
}
</script>

<style scoped>
</style>