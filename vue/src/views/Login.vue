<template>
  <div style="width: 100%; height: 100vh; background-color: darkslategrey; overflow: hidden">
    <div style="width: 400px; margin: 350px auto">
      <div style="color: #cccccc; font-size: 30px; text-align: center;padding: 30px 0">歡迎登入</div>
      <el-form ref="form" :model="form" size="large" :rules="rules">
        <el-form-item prop="username">
          <el-input :prefix-icon="Avatar" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input :prefix-icon="Lock" v-model="form.password" show-password></el-input>
        </el-form-item>
        <el-form-item>
          <el-button style="width: 100%" type="primary" @click="login">登 入</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import { Avatar,Lock } from "@element-plus/icons-vue";
import request from "@/utils/request";
export default {
  name: "Login",
  setup(){
    return {
      Avatar,Lock,
      rules: {
        username: [
          { required: true, message: '請輸入帳號', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '請輸入密碼', trigger: 'blur' },
        ],
      }
    }
  },
  data(){
    return {
      form: {},

    }
  },
  methods:{
    login(){
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/user/login", this.form).then(res => {
            if(res.code === '0'){
              this.$message({
                type: "success",
                message: "登入成功"
              })
              this.$router.push("/") //登入成功後進行頁面跳轉,跳轉到後台主頁
            } else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>

</style>