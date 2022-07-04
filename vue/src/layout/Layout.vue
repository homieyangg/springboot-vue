<template>
<!-- 後台框架 -->
 <div>
   <!--  頭部   -->
   <Header/>

   <!--  主體  -->
   <div style="display: flex">
     <!--  側邊欄    -->
     <Aside/>
     <!--  內容區    -->
     <router-view style="flex: 1"/>
   </div>
 </div>
</template>

<script>
import Header from "@/components/Header";
import Aside from "@/components/Aside";

export default {
  name: "Layout",
  components:{
    Header,
    Aside
  }
}
</script>

<style scoped>

</style>