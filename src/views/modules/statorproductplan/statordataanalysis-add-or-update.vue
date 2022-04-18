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
    <el-form-item label="计划id" prop="planId">
      <el-input v-model="dataForm.planId" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="投入量" prop="inputCount">
      <el-input v-model="dataForm.inputCount" placeholder="投入量"></el-input>
    </el-form-item>
    <el-form-item label="产出量" prop="outputCount">
      <el-input v-model="dataForm.outputCount" placeholder="产出量"></el-input>
    </el-form-item>
    <el-form-item label="良率" prop="productYield">
      <el-input v-model="dataForm.productYield" placeholder="良率"></el-input>
    </el-form-item>
    <el-form-item label="产品直通率" prop="firstPassYield">
      <el-input v-model="dataForm.firstPassYield" placeholder="产品直通率"></el-input>
    </el-form-item>
    <el-form-item label="在线量" prop="machineOnlineCount">
      <el-input v-model="dataForm.machineOnlineCount" placeholder="在线量"></el-input>
    </el-form-item>
    <el-form-item label="工序总数" prop="machineTotalCount">
      <el-input v-model="dataForm.machineTotalCount" placeholder="工序总数"></el-input>
    </el-form-item>
    <el-form-item label="稼动率" prop="activation">
      <el-input v-model="dataForm.activation" placeholder="稼动率"></el-input>
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
          lineId: '',
          planId: '',
          inputCount: '',
          outputCount: '',
          productYield: '',
          firstPassYield: '',
          machineOnlineCount: '',
          machineTotalCount: '',
          activation: ''
        },
        dataRule: {
          lineId: [
            { required: true, message: '产线id不能为空', trigger: 'blur' }
          ],
          planId: [
            { required: true, message: '计划id不能为空', trigger: 'blur' }
          ],
          inputCount: [
            { required: true, message: '投入量不能为空', trigger: 'blur' }
          ],
          outputCount: [
            { required: true, message: '产出量不能为空', trigger: 'blur' }
          ],
          productYield: [
            { required: true, message: '良率不能为空', trigger: 'blur' }
          ],
          firstPassYield: [
            { required: true, message: '产品直通率不能为空', trigger: 'blur' }
          ],
          machineOnlineCount: [
            { required: true, message: '在线量不能为空', trigger: 'blur' }
          ],
          machineTotalCount: [
            { required: true, message: '工序总数不能为空', trigger: 'blur' }
          ],
          activation: [
            { required: true, message: '稼动率不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/stator/statordataanalysis/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.lineId = data.statorDataAnalysis.lineId
                this.dataForm.planId = data.statorDataAnalysis.planId
                this.dataForm.inputCount = data.statorDataAnalysis.inputCount
                this.dataForm.outputCount = data.statorDataAnalysis.outputCount
                this.dataForm.productYield = data.statorDataAnalysis.productYield
                this.dataForm.firstPassYield = data.statorDataAnalysis.firstPassYield
                this.dataForm.machineOnlineCount = data.statorDataAnalysis.machineOnlineCount
                this.dataForm.machineTotalCount = data.statorDataAnalysis.machineTotalCount
                this.dataForm.activation = data.statorDataAnalysis.activation
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
              url: this.$http.adornUrl(`/stator/statordataanalysis/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'lineId': this.dataForm.lineId,
                'planId': this.dataForm.planId,
                'inputCount': this.dataForm.inputCount,
                'outputCount': this.dataForm.outputCount,
                'productYield': this.dataForm.productYield,
                'firstPassYield': this.dataForm.firstPassYield,
                'machineOnlineCount': this.dataForm.machineOnlineCount,
                'machineTotalCount': this.dataForm.machineTotalCount,
                'activation': this.dataForm.activation
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
