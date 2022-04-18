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
    <el-form-item label="点位id" prop="machineId">
      <el-input v-model="dataForm.machineId" placeholder="点位id"></el-input>
    </el-form-item>
    <el-form-item label="线别" prop="lineId">
      <el-input v-model="dataForm.lineId" placeholder="线别"></el-input>
    </el-form-item>
    <el-form-item label="计划id" prop="planId">
      <el-input v-model="dataForm.planId" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="投入量" prop="dataA">
      <el-input v-model="dataForm.dataA" placeholder="投入量"></el-input>
    </el-form-item>
    <el-form-item label="产出量" prop="dataB">
      <el-input v-model="dataForm.dataB" placeholder="产出量"></el-input>
    </el-form-item>
    <el-form-item label="待传递" prop="dataC">
      <el-input v-model="dataForm.dataC" placeholder="待传递"></el-input>
    </el-form-item>
    <el-form-item label="数据采集量" prop="dataCount">
      <el-input v-model="dataForm.dataCount" placeholder="数据采集量"></el-input>
    </el-form-item>
    <el-form-item label="计划产量" prop="planCount">
      <el-input v-model="dataForm.planCount" placeholder="计划产量"></el-input>
    </el-form-item>
    <el-form-item label="更新时间" prop="date">
      <el-input v-model="dataForm.date" placeholder="更新时间"></el-input>
    </el-form-item>
    <el-form-item label="不良品数量" prop="badItemCount">
      <el-input v-model="dataForm.badItemCount" placeholder="不良品数量"></el-input>
    </el-form-item>
    <el-form-item label="完成率" prop="productYield">
      <el-input v-model="dataForm.productYield" placeholder="完成率"></el-input>
    </el-form-item>
    <el-form-item label="结案" prop="finish">
      <el-input v-model="dataForm.finish" placeholder="结案"></el-input>
    </el-form-item>
    <el-form-item label="待完成量" prop="dataD">
      <el-input v-model="dataForm.dataD" placeholder="待完成量"></el-input>
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
          processName: '',
          machineId: '',
          lineId: '',
          planId: '',
          dataA: '',
          dataB: '',
          dataC: '',
          dataCount: '',
          planCount: '',
          date: '',
          badItemCount: '',
          productYield: '',
          finish: '',
          dataD: ''
        },
        dataRule: {
          processName: [
            { required: true, message: '工序名称不能为空', trigger: 'blur' }
          ],
          machineId: [
            { required: true, message: '点位id不能为空', trigger: 'blur' }
          ],
          lineId: [
            { required: true, message: '线别不能为空', trigger: 'blur' }
          ],
          planId: [
            { required: true, message: '计划id不能为空', trigger: 'blur' }
          ],
          dataA: [
            { required: true, message: '投入量不能为空', trigger: 'blur' }
          ],
          dataB: [
            { required: true, message: '产出量不能为空', trigger: 'blur' }
          ],
          dataC: [
            { required: true, message: '待传递不能为空', trigger: 'blur' }
          ],
          dataCount: [
            { required: true, message: '数据采集量不能为空', trigger: 'blur' }
          ],
          planCount: [
            { required: true, message: '计划产量不能为空', trigger: 'blur' }
          ],
          date: [
            { required: true, message: '更新时间不能为空', trigger: 'blur' }
          ],
          badItemCount: [
            { required: true, message: '不良品数量不能为空', trigger: 'blur' }
          ],
          productYield: [
            { required: true, message: '完成率不能为空', trigger: 'blur' }
          ],
          finish: [
            { required: true, message: '结案不能为空', trigger: 'blur' }
          ],
          dataD: [
            { required: true, message: '待完成量不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/stator/statorboarddata/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.processName = data.statorBoardData.processName
                this.dataForm.machineId = data.statorBoardData.machineId
                this.dataForm.lineId = data.statorBoardData.lineId
                this.dataForm.planId = data.statorBoardData.planId
                this.dataForm.dataA = data.statorBoardData.dataA
                this.dataForm.dataB = data.statorBoardData.dataB
                this.dataForm.dataC = data.statorBoardData.dataC
                this.dataForm.dataCount = data.statorBoardData.dataCount
                this.dataForm.planCount = data.statorBoardData.planCount
                this.dataForm.date = data.statorBoardData.date
                this.dataForm.badItemCount = data.statorBoardData.badItemCount
                this.dataForm.productYield = data.statorBoardData.productYield
                this.dataForm.finish = data.statorBoardData.finish
                this.dataForm.dataD = data.statorBoardData.dataD
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
              url: this.$http.adornUrl(`/stator/statorboarddata/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'processName': this.dataForm.processName,
                'machineId': this.dataForm.machineId,
                'lineId': this.dataForm.lineId,
                'planId': this.dataForm.planId,
                'dataA': this.dataForm.dataA,
                'dataB': this.dataForm.dataB,
                'dataC': this.dataForm.dataC,
                'dataCount': this.dataForm.dataCount,
                'planCount': this.dataForm.planCount,
                'date': this.dataForm.date,
                'badItemCount': this.dataForm.badItemCount,
                'productYield': this.dataForm.productYield,
                'finish': this.dataForm.finish,
                'dataD': this.dataForm.dataD
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
