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
    <el-form-item label="工序单价(元/个)" prop="processUnitPrice">
      <el-input v-model="dataForm.processUnitPrice" placeholder="工序单价(元/个)"></el-input>
    </el-form-item>
    <el-form-item label="产能(H)" prop="productCapacity">
      <el-input v-model="dataForm.productCapacity" placeholder="产能(H)"></el-input>
    </el-form-item>
    <el-form-item label="工序人员数量(人/个)" prop="processOperatorNum">
      <el-input v-model="dataForm.processOperatorNum" placeholder="工序人员数量(人/个)"></el-input>
    </el-form-item>
    <el-form-item label="工资基数" prop="salaryCardinality">
      <el-input v-model="dataForm.salaryCardinality" placeholder="工资基数"></el-input>
    </el-form-item>
    <el-form-item label="备注" prop="comment">
      <el-input v-model="dataForm.comment" placeholder="备注"></el-input>
    </el-form-item>
    <el-form-item label="料号" prop="partNum">
      <el-input v-model="dataForm.partNum" placeholder="料号"></el-input>
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
          machineId: 0,
          processName: '',
          processUnitPrice: '',
          productCapacity: '',
          processOperatorNum: '',
          salaryCardinality: '',
          comment: '',
          partNum: ''
        },
        dataRule: {
          processName: [
            { required: true, message: '工序名称不能为空', trigger: 'blur' }
          ],
          processUnitPrice: [
            { required: true, message: '工序单价(元/个)不能为空', trigger: 'blur' }
          ],
          productCapacity: [
            { required: true, message: '产能(H)不能为空', trigger: 'blur' }
          ],
          processOperatorNum: [
            { required: true, message: '工序人员数量(人/个)不能为空', trigger: 'blur' }
          ],
          salaryCardinality: [
            { required: true, message: '工资基数不能为空', trigger: 'blur' }
          ],
          comment: [
            { required: true, message: '备注不能为空', trigger: 'blur' }
          ],
          partNum: [
            { required: true, message: '料号不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.machineId = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.machineId) {
            this.$http({
              url: this.$http.adornUrl(`/stator/statorstandardsalary/info/${this.dataForm.machineId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.processName = data.statorStandardSalary.processName
                this.dataForm.processUnitPrice = data.statorStandardSalary.processUnitPrice
                this.dataForm.productCapacity = data.statorStandardSalary.productCapacity
                this.dataForm.processOperatorNum = data.statorStandardSalary.processOperatorNum
                this.dataForm.salaryCardinality = data.statorStandardSalary.salaryCardinality
                this.dataForm.comment = data.statorStandardSalary.comment
                this.dataForm.partNum = data.statorStandardSalary.partNum
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
              url: this.$http.adornUrl(`/stator/statorstandardsalary/${!this.dataForm.machineId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'machineId': this.dataForm.machineId || undefined,
                'processName': this.dataForm.processName,
                'processUnitPrice': this.dataForm.processUnitPrice,
                'productCapacity': this.dataForm.productCapacity,
                'processOperatorNum': this.dataForm.processOperatorNum,
                'salaryCardinality': this.dataForm.salaryCardinality,
                'comment': this.dataForm.comment,
                'partNum': this.dataForm.partNum
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
