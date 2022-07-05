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
      <el-table-column prop="username" label="會員帳號"/>
      <el-table-column prop="nickName" label="暱稱" />
      <el-table-column prop="age" label="年齡" />
      <el-table-column prop="sex" label="性別" />
      <el-table-column prop="address" label="地址" />
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

      <el-dialog v-model="dialogVisible" title="Tips" width="25%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="會員帳號">
            <el-input v-model="form.username" style="width:60%" />
          </el-form-item>
          <el-form-item label="暱稱">
            <el-input v-model="form.nickName" style="width:60%" />
          </el-form-item>
          <el-form-item label="年齡">
            <el-input v-model="form.age" style="width:60%" />
          </el-form-item>
          <el-form-item label="性別">
            <el-radio v-model="form.sex" label="男">男</el-radio>
            <el-radio v-model="form.sex" label="女">女</el-radio>
            <el-radio v-model="form.sex" label="未知">未知</el-radio>
          </el-form-item>
          <el-form-item label="地址">
            <el-input type="textarea" v-model="form.address" style="width:60%" />
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


import {Document,Search} from "@element-plus/icons";
import request from "@/utils/request";
export default {
  name: 'User',
  components: {
    Document,Search
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
      tableData: []
    }
  },
  created() {
    this.load()
  },
  methods: {
    load(){
      request.get("/user",{
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
    },
    save(){
      if(this.form.id){ //更新
        request.put("/user",this.form).then(res => {
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
      request.post("/user",this.form).then(res => {
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
      request.delete("/user/" + id).then(res => {
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
    }
  }
}
</script>
