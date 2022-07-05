import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
import * as ElIconModules  from '@element-plus/icons-vue'
import zhCn from 'element-plus/es/locale/lang/zh-tw'


import '@/assets/css/global.css'

createApp(App).use(store).use(router).use(ElementPlus,{locale: zhCn,size: 'big'}).mount('#app')

const app = createApp(App)
//  统一注册el-icon图标
for(let iconName in ElIconModules){
    app.component(iconName,ElIconModules[iconName])
}
