<template>
  <div>
    <el-menu
        style="width: 200px; min-height: calc(100vh - 50px)"
        default-active="user"
        router
        class="el-menu-vertical-demo">
      <el-sub-menu index="1">
        <template #title>系統管理</template>
        <el-menu-item index="user"><el-icon><User/></el-icon>會員管理</el-menu-item>
      </el-sub-menu>
      <el-menu-item index="product"><el-icon><User/></el-icon>商品管理</el-menu-item>
    </el-menu>
  </div>
</template>

<script>
import {User,Menu} from "@element-plus/icons";
export default {
  name: "Aside",
  components: {User,Menu}

}
</script>

<style scoped>

</style>