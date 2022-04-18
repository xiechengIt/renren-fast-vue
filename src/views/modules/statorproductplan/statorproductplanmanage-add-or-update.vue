<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="产线id" prop="lineId">
      <el-input v-model="dataForm.lineId" placeholder="产线id"></el-input>
    </el-form-item>
    <el-form-item label="品名" prop="productName">
      <el-input v-model="dataForm.productName" placeholder="品名"></el-input>
    </el-form-item>
    <el-form-item label="规格" prop="specification">
      <el-input v-model="dataForm.specification" placeholder="规格"></el-input>
    </el-form-item>
    <el-form-item label="料号" prop="partNum">
      <el-input v-model="dataForm.partNum" placeholder="料号"></el-input>
    </el-form-item>
    <el-form-item label="计划产量" prop="productPlanAmount">
      <el-input v-model="dataForm.productPlanAmount" placeholder="计划产量"></el-input>
    </el-form-item>
    <el-form-item label="订单号" prop="orderNum">
      <el-input v-model="dataForm.orderNum" placeholder="订单号"></el-input>
    </el-form-item>
    <el-form-item label="工单号" prop="workNum">
      <el-input v-model="dataForm.workNum" placeholder="工单号"></el-input>
    </el-form-item>
    <el-form-item label="结案" prop="finish">
      <el-input v-model="dataForm.finish" placeholder="结案"></el-input>
    </el-form-item>
    <el-form-item label="日期" prop="date">
      <el-input v-model="dataForm.date" placeholder="日期"></el-input>
    </el-form-item>
    <el-form-item label="结束日期" prop="endDate">
      <el-input v-model="dataForm.endDate" placeholder="结束日期"></el-input>
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
          lineId: '',
          productName: '',
          specification: '',
          partNum: '',
          productPlanAmount: '',
          orderNum: '',
          workNum: '',
          finish: '',
          date: '',
          endDate: ''
        },
        dataRule: {
          lineId: [
            { required: true, message: '产线id不能为空', trigger: 'blur' }
          ],
          productName: [
            { required: true, message: '品名不能为空', trigger: 'blur' }
          ],
          specification: [
            { required: true, message: '规格不能为空', trigger: 'blur' }
          ],
          partNum: [
            { required: true, message: '料号不能为空', trigger: 'blur' }
          ],
          productPlanAmount: [
            { required: true, message: '计划产量不能为空', trigger: 'blur' }
          ],
          orderNum: [
            { required: true, message: '订单号不能为空', trigger: 'blur' }
          ],
          workNum: [
            { required: true, message: '工单号不能为空', trigger: 'blur' }
          ],
          finish: [
            { required: true, message: '结案不能为空', trigger: 'blur' }
          ],
          date: [
            { required: true, message: '日期不能为空', trigger: 'blur' }
          ],
          endDate: [
            { required: true, message: '结束日期不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/stator/statorproductplanmanage/info/${this.dataForm.planId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.lineId = data.statorProductPlanManage.lineId
                this.dataForm.productName = data.statorProductPlanManage.productName
                this.dataForm.specification = data.statorProductPlanManage.specification
                this.dataForm.partNum = data.statorProductPlanManage.partNum
                this.dataForm.productPlanAmount = data.statorProductPlanManage.productPlanAmount
                this.dataForm.orderNum = data.statorProductPlanManage.orderNum
                this.dataForm.workNum = data.statorProductPlanManage.workNum
                this.dataForm.finish = data.statorProductPlanManage.finish
                this.dataForm.date = data.statorProductPlanManage.date
                this.dataForm.endDate = data.statorProductPlanManage.endDate
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
              url: this.$http.adornUrl(`/stator/statorproductplanmanage/${!this.dataForm.planId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'planId': this.dataForm.planId || undefined,
                'lineId': this.dataForm.lineId,
                'productName': this.dataForm.productName,
                'specification': this.dataForm.specification,
                'partNum': this.dataForm.partNum,
                'productPlanAmount': this.dataForm.productPlanAmount,
                'orderNum': this.dataForm.orderNum,
                'workNum': this.dataForm.workNum,
                'finish': this.dataForm.finish,
                'date': this.dataForm.date,
                'endDate': this.dataForm.endDate
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
