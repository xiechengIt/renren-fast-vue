<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="工序名称" prop="processName">
      <el-input v-model="dataForm.processName" placeholder="工序名称"></el-input>
    </el-form-item>
    <el-form-item label="操作员姓名" prop="operatorName">
      <el-input v-model="dataForm.operatorName" placeholder="操作员姓名"></el-input>
    </el-form-item>
    <el-form-item label="工序产品单价" prop="processUnitPrice">
      <el-input v-model="dataForm.processUnitPrice" placeholder="工序产品单价"></el-input>
    </el-form-item>
    <el-form-item label="工序完成量" prop="processFinishCount">
      <el-input v-model="dataForm.processFinishCount" placeholder="工序完成量"></el-input>
    </el-form-item>
    <el-form-item label="操作员工序薪资" prop="processSalary">
      <el-input v-model="dataForm.processSalary" placeholder="操作员工序薪资"></el-input>
    </el-form-item>
    <el-form-item label="点位id" prop="machineId">
      <el-input v-model="dataForm.machineId" placeholder="点位id"></el-input>
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
          planId: 0,
          processName: '',
          operatorName: '',
          processUnitPrice: '',
          processFinishCount: '',
          processSalary: '',
          machineId: ''
        },
        dataRule: {
          processName: [
            { required: true, message: '工序名称不能为空', trigger: 'blur' }
          ],
          operatorName: [
            { required: true, message: '操作员姓名不能为空', trigger: 'blur' }
          ],
          processUnitPrice: [
            { required: true, message: '工序产品单价不能为空', trigger: 'blur' }
          ],
          processFinishCount: [
            { required: true, message: '工序完成量不能为空', trigger: 'blur' }
          ],
          processSalary: [
            { required: true, message: '操作员工序薪资不能为空', trigger: 'blur' }
          ],
          machineId: [
            { required: true, message: '点位id不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.planId = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.planId) {
            this.$http({
              url: this.$http.adornUrl(`/stator/statorprocesssalary/info/${this.dataForm.planId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.processName = data.statorProcessSalary.processName
                this.dataForm.operatorName = data.statorProcessSalary.operatorName
                this.dataForm.processUnitPrice = data.statorProcessSalary.processUnitPrice
                this.dataForm.processFinishCount = data.statorProcessSalary.processFinishCount
                this.dataForm.processSalary = data.statorProcessSalary.processSalary
                this.dataForm.machineId = data.statorProcessSalary.machineId
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
              url: this.$http.adornUrl(`/stator/statorprocesssalary/${!this.dataForm.planId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'planId': this.dataForm.planId || undefined,
                'processName': this.dataForm.processName,
                'operatorName': this.dataForm.operatorName,
                'processUnitPrice': this.dataForm.processUnitPrice,
                'processFinishCount': this.dataForm.processFinishCount,
                'processSalary': this.dataForm.processSalary,
                'machineId': this.dataForm.machineId
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
