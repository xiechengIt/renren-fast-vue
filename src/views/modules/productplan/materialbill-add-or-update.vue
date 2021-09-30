<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="日期" prop="date">
      <el-input v-model="dataForm.date" placeholder="日期"></el-input>
    </el-form-item>
    <el-form-item label="计划号" prop="planNum">
      <el-input v-model="dataForm.planNum" placeholder="计划号"></el-input>
    </el-form-item>
    <el-form-item label="机号" prop="machineId">
      <el-input v-model="dataForm.machineId" placeholder="机号"></el-input>
    </el-form-item>
    <el-form-item label="机名" prop="machineName">
      <el-input v-model="dataForm.machineName" placeholder="机名"></el-input>
    </el-form-item>
    <el-form-item label="代码" prop="code">
      <el-input v-model="dataForm.code" placeholder="代码"></el-input>
    </el-form-item>
    <el-form-item label="品名" prop="itemName">
      <el-input v-model="dataForm.itemName" placeholder="品名"></el-input>
    </el-form-item>
    <el-form-item label="子项物料代码" prop="subMaterialCode">
      <el-input v-model="dataForm.subMaterialCode" placeholder="子项物料代码"></el-input>
    </el-form-item>
    <el-form-item label="物料名称" prop="materialName">
      <el-input v-model="dataForm.materialName" placeholder="物料名称"></el-input>
    </el-form-item>
    <el-form-item label="规格型号" prop="model">
      <el-input v-model="dataForm.model" placeholder="规格型号"></el-input>
    </el-form-item>
    <el-form-item label="单位" prop="unit">
      <el-input v-model="dataForm.unit" placeholder="单位"></el-input>
    </el-form-item>
    <el-form-item label="用量" prop="used">
      <el-input v-model="dataForm.used" placeholder="用量"></el-input>
    </el-form-item>
    <el-form-item label="数量" prop="amount">
      <el-input v-model="dataForm.amount" placeholder="数量"></el-input>
    </el-form-item>
    <el-form-item label="合计" prop="total">
      <el-input v-model="dataForm.total" placeholder="合计"></el-input>
    </el-form-item>
    <el-form-item label="仓库" prop="warehouse">
      <el-input v-model="dataForm.warehouse" placeholder="仓库"></el-input>
    </el-form-item>
    <el-form-item label="组合号" prop="combineNum">
      <el-input v-model="dataForm.combineNum" placeholder="组合号"></el-input>
    </el-form-item>
    <el-form-item label="订单号" prop="orderNum">
      <el-input v-model="dataForm.orderNum" placeholder="订单号"></el-input>
    </el-form-item>
    <el-form-item label="计算标示" prop="calculateLabeled">
      <el-input v-model="dataForm.calculateLabeled" placeholder="计算标示"></el-input>
    </el-form-item>
    <el-form-item label="成功数量" prop="successNum">
      <el-input v-model="dataForm.successNum" placeholder="成功数量"></el-input>
    </el-form-item>
    <el-form-item label="未导入数量" prop="notImportNum">
      <el-input v-model="dataForm.notImportNum" placeholder="未导入数量"></el-input>
    </el-form-item>
    <el-form-item label="原因分析" prop="reasonAnalysis">
      <el-input v-model="dataForm.reasonAnalysis" placeholder="原因分析"></el-input>
    </el-form-item>
    <el-form-item label="工单号" prop="workNum">
      <el-input v-model="dataForm.workNum" placeholder="工单号"></el-input>
    </el-form-item>
    <el-form-item label="工单余量" prop="workRestNum">
      <el-input v-model="dataForm.workRestNum" placeholder="工单余量"></el-input>
    </el-form-item>
    <el-form-item label="领料类别" prop="materialType">
      <el-input v-model="dataForm.materialType" placeholder="领料类别"></el-input>
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
          id: 0,
          date: '',
          planNum: '',
          machineId: '',
          machineName: '',
          code: '',
          itemName: '',
          subMaterialCode: '',
          materialName: '',
          model: '',
          unit: '',
          used: '',
          amount: '',
          total: '',
          warehouse: '',
          combineNum: '',
          orderNum: '',
          calculateLabeled: '',
          successNum: '',
          notImportNum: '',
          reasonAnalysis: '',
          workNum: '',
          workRestNum: '',
          materialType: ''
        },
        dataRule: {
          date: [
            { required: true, message: '日期不能为空', trigger: 'blur' }
          ],
          planNum: [
            { required: true, message: '计划号不能为空', trigger: 'blur' }
          ],
          machineId: [
            { required: true, message: '机号不能为空', trigger: 'blur' }
          ],
          machineName: [
            { required: true, message: '机名不能为空', trigger: 'blur' }
          ],
          code: [
            { required: true, message: '代码不能为空', trigger: 'blur' }
          ],
          itemName: [
            { required: true, message: '品名不能为空', trigger: 'blur' }
          ],
          subMaterialCode: [
            { required: true, message: '子项物料代码不能为空', trigger: 'blur' }
          ],
          materialName: [
            { required: true, message: '物料名称不能为空', trigger: 'blur' }
          ],
          model: [
            { required: true, message: '规格型号不能为空', trigger: 'blur' }
          ],
          unit: [
            { required: true, message: '单位不能为空', trigger: 'blur' }
          ],
          used: [
            { required: true, message: '用量不能为空', trigger: 'blur' }
          ],
          amount: [
            { required: true, message: '数量不能为空', trigger: 'blur' }
          ],
          total: [
            { required: true, message: '合计不能为空', trigger: 'blur' }
          ],
          warehouse: [
            { required: true, message: '仓库不能为空', trigger: 'blur' }
          ],
          combineNum: [
            { required: true, message: '组合号不能为空', trigger: 'blur' }
          ],
          orderNum: [
            { required: true, message: '订单号不能为空', trigger: 'blur' }
          ],
          calculateLabeled: [
            { required: true, message: '计算标示不能为空', trigger: 'blur' }
          ],
          successNum: [
            { required: true, message: '成功数量不能为空', trigger: 'blur' }
          ],
          notImportNum: [
            { required: true, message: '未导入数量不能为空', trigger: 'blur' }
          ],
          reasonAnalysis: [
            { required: true, message: '原因分析不能为空', trigger: 'blur' }
          ],
          workNum: [
            { required: true, message: '工单号不能为空', trigger: 'blur' }
          ],
          workRestNum: [
            { required: true, message: '工单余量不能为空', trigger: 'blur' }
          ],
          materialType: [
            { required: true, message: '领料类别不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/productionplan/materialBill/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.date = data.materialBill.date
                this.dataForm.planNum = data.materialBill.planNum
                this.dataForm.machineId = data.materialBill.machineId
                this.dataForm.machineName = data.materialBill.machineName
                this.dataForm.code = data.materialBill.code
                this.dataForm.itemName = data.materialBill.itemName
                this.dataForm.subMaterialCode = data.materialBill.subMaterialCode
                this.dataForm.materialName = data.materialBill.materialName
                this.dataForm.model = data.materialBill.model
                this.dataForm.unit = data.materialBill.unit
                this.dataForm.used = data.materialBill.used
                this.dataForm.amount = data.materialBill.amount
                this.dataForm.total = data.materialBill.total
                this.dataForm.warehouse = data.materialBill.warehouse
                this.dataForm.combineNum = data.materialBill.combineNum
                this.dataForm.orderNum = data.materialBill.orderNum
                this.dataForm.calculateLabeled = data.materialBill.calculateLabeled
                this.dataForm.successNum = data.materialBill.successNum
                this.dataForm.notImportNum = data.materialBill.notImportNum
                this.dataForm.reasonAnalysis = data.materialBill.reasonAnalysis
                this.dataForm.workNum = data.materialBill.workNum
                this.dataForm.workRestNum = data.materialBill.workRestNum
                this.dataForm.materialType = data.materialBill.materialType
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
              url: this.$http.adornUrl(`/productionplan/materialBill/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'date': this.dataForm.date,
                'planNum': this.dataForm.planNum,
                'machineId': this.dataForm.machineId,
                'machineName': this.dataForm.machineName,
                'code': this.dataForm.code,
                'itemName': this.dataForm.itemName,
                'subMaterialCode': this.dataForm.subMaterialCode,
                'materialName': this.dataForm.materialName,
                'model': this.dataForm.model,
                'unit': this.dataForm.unit,
                'used': this.dataForm.used,
                'amount': this.dataForm.amount,
                'total': this.dataForm.total,
                'warehouse': this.dataForm.warehouse,
                'combineNum': this.dataForm.combineNum,
                'orderNum': this.dataForm.orderNum,
                'calculateLabeled': this.dataForm.calculateLabeled,
                'successNum': this.dataForm.successNum,
                'notImportNum': this.dataForm.notImportNum,
                'reasonAnalysis': this.dataForm.reasonAnalysis,
                'workNum': this.dataForm.workNum,
                'workRestNum': this.dataForm.workRestNum,
                'materialType': this.dataForm.materialType
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
