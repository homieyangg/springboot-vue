<template>
  <div style="padding: 10px">
    <!--  功能區  -->
    <div style="margin: 10px 0">
      <el-button type="info" @click="add"><el-icon><Document/></el-icon>新增</el-button>
      <el-button type="primary">導入</el-button>
      <el-button type="primary">導出</el-button>
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
      <el-table-column prop="name" label="商品名稱"/>
      <el-table-column prop="price" label="單價" />
      <el-table-column prop="content" label="內容" />
      <el-table-column prop="createTime" label="建立時間" />
      <el-table-column prop="amount" label="庫存" />
      <el-table-column label="商品圖" >
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
      <el-table-column fixed="right" label="操作" width="200">
        <template #default="scope">
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

      <el-dialog v-model="dialogVisible" title="新增商品" width="30%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="商品名稱">
            <el-input v-model="form.name" style="width:60%" />
          </el-form-item>
          <el-form-item label="單價">
            <el-input v-model="form.price" style="width:60%" />
          </el-form-item>
          <el-form-item label="內容">
            <el-input type="textarea" v-model="form.content" style="width:60%" />
          </el-form-item>
          <el-form-item label="建立日期">
            <el-date-picker v-model="form.createTime" value-format="YYYY-MM-DD" type="date" style="width: 80%" clearable :size="size"/>
          </el-form-item>
          <el-form-item label="庫存">
            <el-input v-model="form.amount" style="width:60%" />
          </el-form-item>
          <el-form-item label="商品圖">
            <el-upload
                ref="upload"
                v-model:file-list="fileList"
                action="http://localhost:8080/files/upload"
                list-type="picture-card"
                :on-preview="handlePictureCardPreview"
                :on-remove="handleRemove"
                :on-success="filesUploadSuccess"
            >
              <el-icon><Plus /></el-icon>
            </el-upload>


          </el-form-item>
        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取消</el-button>
            <el-button type="primary" @click="save">送出</el-button>
          </span>
        </template>
      </el-dialog>
    </div>
  </div>
</template>

<script>


import {Document,Search,Plus,Download,Delete} from "@element-plus/icons";
import request from "@/utils/request";
import {ref} from "vue";
export default {
  name: 'Product',
  components: {
    Document,Search,Plus,Download,Delete
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
      fileList: []
    }
  },
  created() {
    this.load()
  },
  methods: {
    filesUploadSuccess(res){
      console.log(res)
      this.form.img = res.data
    },
    load(){
      request.get("/product",{
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
      this.$nextTick( () => {
        if(this.$refs['upload']){
          this.$refs['upload'].clearFiles() //清除歷史圖片
        }
      } )
    },
    save(){
      if(this.form.id){ //更新
        request.put("/product",this.form).then(res => {
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
        request.post("/product",this.form).then(res => {
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
      this.$nextTick( () => {
        if(this.$refs['upload']){
          this.$refs['upload'].clearFiles() //清除歷史圖片
        }
      } )
    },
    handleDelete(id){
      console.log(id)
      request.delete("/product/" + id).then(res => {
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

  }
}
</script>
