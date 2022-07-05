const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true
})
// 跨域配置
module.exports = {
  devServer: {                //設置本地默認端口
    port: 9876,
    host: 'localhost',
    open: true,
    proxy: {                 //設置代理伺服器
      '/api': {              //設置攔截器，名字可改
        target: 'http://localhost:8080',     //代理目標位置
        changeOrigin: true,              //是否設置同源
        pathRewrite: {                   //路徑重寫
          '^/api': ''                     //選擇忽略攔截器裡的內容
        }
      }
    }
  }
}
