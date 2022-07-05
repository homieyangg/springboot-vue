<template>
  <div style="padding: 10px">
    <!--  功能區  -->
    <div style="margin: 10px 0">
      <el-button type="info" @click="add"><el-icon><Document/></el-icon>新增</el-button>
    </div>
    <!-- 搜索區   -->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="請輸入關鍵字" style="width: 10%" clearable>
        <template #prefix>
          <el-icon class="el-input__icon"><Search/></el-icon>
        </template>
      </el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load">查詢</el-button>
    </div>
    <el-table :data="tableData" border style="width: 100%" stripe>
      <el-table-column prop="id" label="ID" sortable/>
      <el-table-column prop="title" label="公告標題"/>
      <el-table-column prop="author" label="作者" />
      <el-table-column prop="time" label="時間" />
      <el-table-column label="新聞圖" >
        <template #default="scope">
          <el-image
              style="width: 100px; height: 100px"
              :src="scope.row.img"
              :preview-src-list="[scope.row.img]"
              :initial-index="1"
              fit="cover"
              :preview-teleported="true"
          />
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="300">
        <template #default="scope">
          <el-button @click="details(scope.row)">詳情</el-button>
          <el-button @click="handleEdit(scope.row)">編輯</el-button>
          <el-popconfirm title="確認刪除嗎?" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button type="danger">刪除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-Page="currentPage"
          :page-sizes="[5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
      />

      <el-dialog v-model="dialogVisible" title="新增公告" width="50%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="公告標題">
            <el-input v-model="form.title" style="width:50%" />
          </el-form-item>


            <div style="border: 1px solid #ccc">
              <Toolbar
                  style="border-bottom: 1px solid #ccc"
                  :editor="editorRef"
                  :defaultConfig="toolbarConfig"
                  :mode="mode"
              />
              <Editor
                  style="height: 500px; overflow-y: hidden;"
                  v-model="form.content"
                  :defaultConfig="editorConfig"
                  :mode="mode"
                  @onCreated="handleCreated"
              />
            </div>




        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取消</el-button>
            <el-button type="primary" @click="save">送出</el-button>
          </span>
        </template>
      </el-dialog>

      <el-dialog v-model="vis" title="詳細" width="50%">
        <el-card>
          <div v-html="detail.content" style="min-height: 100px"></div>
        </el-card>
      </el-dialog>
    </div>
  </div>
</template>

<script>

import '@wangeditor/editor/dist/css/style.css'

import { onBeforeUnmount, shallowRef, onMounted } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import {Document,Search,Plus,Download,Delete} from "@element-plus/icons";
import request from "@/utils/request";
import {ref} from "vue";
export default {
  name: 'News',
  components: {
    Document,Search,Plus,Download,Delete,Editor,Toolbar
  },
  setup(){
    //編輯器 ---
    const editorRef = shallowRef()
    const valueHtml = ref()
    const toolbarConfig = {}
    const editorConfig = { placeholder: '请输入内容...', MENU_CONF: {} }
    onBeforeUnmount(() => {
      const editor = editorRef.value
      if (editor == null) return
      editor.destroy()
    })

    editorConfig.MENU_CONF['uploadImage'] = {
      server: 'http://localhost:8080/files/editor/upload',
      fieldName: 'file',
    }


    const handleCreated = (editor) => {
      editorRef.value = editor
    }

    return {
      editorRef,
      valueHtml,
      mode: 'default',
      toolbarConfig,
      editorConfig,
      handleCreated
    };
    // ------
  },
  data(){
    return{
      form: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize:10,
      total: 0,
      background:"danger",
      tableData: [],
      size: "large",
      fileList: [],
      user: {},
      detail: {},
      vis: false,
    }
  },
  created() {
    this.load()
  },
  methods: {
    details(row){
      this.detail = row
      this.vis = true
    },
    filesUploadSuccess(res){
      console.log(res)
      this.form.img = res.data
    },
    load(){
      request.get("/news",{
        params:{
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res =>{
        console.log(res)
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    add(){
      this.dialogVisible=true;
      this.form = {}
      this.form.content = {}
    },
    save(){
      if(this.form.id){ //更新
        request.put("/news",this.form).then(res => {
          console.log(res)
          if(res.code === '0'){
            this.$message({
              type: "success",
              message: "更新成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load() //刷新表格數據
          this.dialogVisible = false //關閉彈窗
        })
      } else { //新增
        let userStr = sessionStorage.getItem("user") || "{}";
        let user = JSON.parse(userStr)
        this.form.author = user.nickName
        request.post("/news",this.form).then(res => {
          console.log(res)
          if(res.code === '0'){
            this.$message({
              type: "success",
              message: "新增成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load() //刷新表格數據
          this.dialogVisible = false //關閉彈窗
        })
      }
    },
    handleEdit(row){
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
    },
    handleDelete(id){
      console.log(id)
      request.delete("/news/" + id).then(res => {
        if(res.code === '0'){
          this.$message({
            type: "success",
            message: "刪除成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load() //刪除後重新加載表格數據
      })
    },
    handleSizeChange(pageSize){ //改變當前每頁的個數觸發
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum){ //改變當前頁碼觸發
      this.currentPage = pageNum
      this.load()
    },
    handlePictureCardPreview(){
    },
    handleRemove(){
    },


  },
}
</script>
