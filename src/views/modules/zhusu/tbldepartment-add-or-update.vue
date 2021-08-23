<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="${column.comments}" prop="percentage">
      <el-input v-model="dataForm.percentage" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="parentid">
      <el-input v-model="dataForm.parentid" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="remark">
      <el-input v-model="dataForm.remark" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="fstatus">
      <el-input v-model="dataForm.fstatus" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="deptid">
      <el-input v-model="dataForm.deptid" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="iLevel">
      <el-input v-model="dataForm.iLevel" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="loginCount">
      <el-input v-model="dataForm.loginCount" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="iOrder">
      <el-input v-model="dataForm.iOrder" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="deptname">
      <el-input v-model="dataForm.deptname" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="resetCount">
      <el-input v-model="dataForm.resetCount" placeholder="${column.comments}"></el-input>
    </el-form-item>
    <el-form-item label="${column.comments}" prop="status">
      <el-input v-model="dataForm.status" placeholder="${column.comments}"></el-input>
    </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          userId: 0,
          percentage: '',
          parentid: '',
          remark: '',
          fstatus: '',
          deptid: '',
          iLevel: '',
          loginCount: '',
          iOrder: '',
          deptname: '',
          resetCount: '',
          status: ''
        },
        dataRule: {
          percentage: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          parentid: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          remark: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          fstatus: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          deptid: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          iLevel: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          loginCount: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          iOrder: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          deptname: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          resetCount: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ],
          status: [
            { required: true, message: '${column.comments}不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.userId = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.userId) {
            this.$http({
              url: this.$http.adornUrl(`/board/tbldepartment/info/${this.dataForm.userId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.percentage = data.tbldepartment.percentage
                this.dataForm.parentid = data.tbldepartment.parentid
                this.dataForm.remark = data.tbldepartment.remark
                this.dataForm.fstatus = data.tbldepartment.fstatus
                this.dataForm.deptid = data.tbldepartment.deptid
                this.dataForm.iLevel = data.tbldepartment.iLevel
                this.dataForm.loginCount = data.tbldepartment.loginCount
                this.dataForm.iOrder = data.tbldepartment.iOrder
                this.dataForm.deptname = data.tbldepartment.deptname
                this.dataForm.resetCount = data.tbldepartment.resetCount
                this.dataForm.status = data.tbldepartment.status
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/board/tbldepartment/${!this.dataForm.userId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'userId': this.dataForm.userId || undefined,
                'percentage': this.dataForm.percentage,
                'parentid': this.dataForm.parentid,
                'remark': this.dataForm.remark,
                'fstatus': this.dataForm.fstatus,
                'deptid': this.dataForm.deptid,
                'iLevel': this.dataForm.iLevel,
                'loginCount': this.dataForm.loginCount,
                'iOrder': this.dataForm.iOrder,
                'deptname': this.dataForm.deptname,
                'resetCount': this.dataForm.resetCount,
                'status': this.dataForm.status
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message({
                  message: '操作成功',
                  type: 'success',
                  duration: 1500,
                  onClose: () => {
                    this.visible = false
                    this.$emit('refreshDataList')
                  }
                })
              } else {
                this.$message.error(data.msg)
              }
            })
          }
        })
      }
    }
  }
</script>
