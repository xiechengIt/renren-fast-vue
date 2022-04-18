<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="计划id" prop="planId">
      <el-input v-model="dataForm.planId" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="开工计划人力" prop="beginScheduleResource">
      <el-input v-model="dataForm.beginScheduleResource" placeholder="开工计划人力"></el-input>
    </el-form-item>
    <el-form-item label="开工实到人力" prop="beginTrueResource">
      <el-input v-model="dataForm.beginTrueResource" placeholder="开工实到人力"></el-input>
    </el-form-item>
    <el-form-item label="设备点检" prop="equipmentLocating">
      <el-input v-model="dataForm.equipmentLocating" placeholder="设备点检"></el-input>
    </el-form-item>
    <el-form-item label="工单发料" prop="planIssuanceOfMaterials">
      <el-input v-model="dataForm.planIssuanceOfMaterials" placeholder="工单发料"></el-input>
    </el-form-item>
    <el-form-item label="实际发料" prop="trueIssuanceOfMaterials">
      <el-input v-model="dataForm.trueIssuanceOfMaterials" placeholder="实际发料"></el-input>
    </el-form-item>
    <el-form-item label="SOP确认" prop="sOPverify">
      <el-input v-model="dataForm.sOPverify" placeholder="SOP确认"></el-input>
    </el-form-item>
    <el-form-item label="计划开始" prop="planBeginTime">
      <el-input v-model="dataForm.planBeginTime" placeholder="计划开始"></el-input>
    </el-form-item>
    <el-form-item label="实际开始" prop="trueBeginTime">
      <el-input v-model="dataForm.trueBeginTime" placeholder="实际开始"></el-input>
    </el-form-item>
    <el-form-item label="首件确认" prop="firstItemTime">
      <el-input v-model="dataForm.firstItemTime" placeholder="首件确认"></el-input>
    </el-form-item>
    <el-form-item label="计划完工" prop="planEndTime">
      <el-input v-model="dataForm.planEndTime" placeholder="计划完工"></el-input>
    </el-form-item>
    <el-form-item label="实际完工" prop="trueEndTime">
      <el-input v-model="dataForm.trueEndTime" placeholder="实际完工"></el-input>
    </el-form-item>
    <el-form-item label="工单量" prop="productPlanAmount">
      <el-input v-model="dataForm.productPlanAmount" placeholder="工单量"></el-input>
    </el-form-item>
    <el-form-item label="现场在制" prop="productTrueAmount">
      <el-input v-model="dataForm.productTrueAmount" placeholder="现场在制"></el-input>
    </el-form-item>
    <el-form-item label="入库量" prop="stockInAmount">
      <el-input v-model="dataForm.stockInAmount" placeholder="入库量"></el-input>
    </el-form-item>
    <el-form-item label="报废量" prop="scrappedAmount">
      <el-input v-model="dataForm.scrappedAmount" placeholder="报废量"></el-input>
    </el-form-item>
    <el-form-item label="返修量" prop="repairAmount">
      <el-input v-model="dataForm.repairAmount" placeholder="返修量"></el-input>
    </el-form-item>
    <el-form-item label="完工计划人力" prop="endScheduleResource">
      <el-input v-model="dataForm.endScheduleResource" placeholder="完工计划人力"></el-input>
    </el-form-item>
    <el-form-item label="完工实际人力" prop="endTrueResource">
      <el-input v-model="dataForm.endTrueResource" placeholder="完工实际人力"></el-input>
    </el-form-item>
    <el-form-item label="设备状态" prop="machineStatus">
      <el-input v-model="dataForm.machineStatus" placeholder="设备状态"></el-input>
    </el-form-item>
    <el-form-item label="设备运行时长" prop="machineRunTime">
      <el-input v-model="dataForm.machineRunTime" placeholder="设备运行时长"></el-input>
    </el-form-item>
    <el-form-item label="设备操作时长" prop="machineOperateTime">
      <el-input v-model="dataForm.machineOperateTime" placeholder="设备操作时长"></el-input>
    </el-form-item>
    <el-form-item label="故障时长" prop="machineBreakDownTime">
      <el-input v-model="dataForm.machineBreakDownTime" placeholder="故障时长"></el-input>
    </el-form-item>
    <el-form-item label="停机时长" prop="machineOfflineTime">
      <el-input v-model="dataForm.machineOfflineTime" placeholder="停机时长"></el-input>
    </el-form-item>
    <el-form-item label="日报创建时间" prop="recordCreateTime">
      <el-input v-model="dataForm.recordCreateTime" placeholder="日报创建时间"></el-input>
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
          planId: '',
          beginScheduleResource: '',
          beginTrueResource: '',
          equipmentLocating: '',
          planIssuanceOfMaterials: '',
          trueIssuanceOfMaterials: '',
          sOPverify: '',
          planBeginTime: '',
          trueBeginTime: '',
          firstItemTime: '',
          planEndTime: '',
          trueEndTime: '',
          productPlanAmount: '',
          productTrueAmount: '',
          stockInAmount: '',
          scrappedAmount: '',
          repairAmount: '',
          endScheduleResource: '',
          endTrueResource: '',
          machineStatus: '',
          machineRunTime: '',
          machineOperateTime: '',
          machineBreakDownTime: '',
          machineOfflineTime: '',
          recordCreateTime: ''
        },
        dataRule: {
          planId: [
            { required: true, message: '计划id不能为空', trigger: 'blur' }
          ],
          beginScheduleResource: [
            { required: true, message: '开工计划人力不能为空', trigger: 'blur' }
          ],
          beginTrueResource: [
            { required: true, message: '开工实到人力不能为空', trigger: 'blur' }
          ],
          equipmentLocating: [
            { required: true, message: '设备点检不能为空', trigger: 'blur' }
          ],
          planIssuanceOfMaterials: [
            { required: true, message: '工单发料不能为空', trigger: 'blur' }
          ],
          trueIssuanceOfMaterials: [
            { required: true, message: '实际发料不能为空', trigger: 'blur' }
          ],
          sOPverify: [
            { required: true, message: 'SOP确认不能为空', trigger: 'blur' }
          ],
          planBeginTime: [
            { required: true, message: '计划开始不能为空', trigger: 'blur' }
          ],
          trueBeginTime: [
            { required: true, message: '实际开始不能为空', trigger: 'blur' }
          ],
          firstItemTime: [
            { required: true, message: '首件确认不能为空', trigger: 'blur' }
          ],
          planEndTime: [
            { required: true, message: '计划完工不能为空', trigger: 'blur' }
          ],
          trueEndTime: [
            { required: true, message: '实际完工不能为空', trigger: 'blur' }
          ],
          productPlanAmount: [
            { required: true, message: '工单量不能为空', trigger: 'blur' }
          ],
          productTrueAmount: [
            { required: true, message: '现场在制不能为空', trigger: 'blur' }
          ],
          stockInAmount: [
            { required: true, message: '入库量不能为空', trigger: 'blur' }
          ],
          scrappedAmount: [
            { required: true, message: '报废量不能为空', trigger: 'blur' }
          ],
          repairAmount: [
            { required: true, message: '返修量不能为空', trigger: 'blur' }
          ],
          endScheduleResource: [
            { required: true, message: '完工计划人力不能为空', trigger: 'blur' }
          ],
          endTrueResource: [
            { required: true, message: '完工实际人力不能为空', trigger: 'blur' }
          ],
          machineStatus: [
            { required: true, message: '设备状态不能为空', trigger: 'blur' }
          ],
          machineRunTime: [
            { required: true, message: '设备运行时长不能为空', trigger: 'blur' }
          ],
          machineOperateTime: [
            { required: true, message: '设备操作时长不能为空', trigger: 'blur' }
          ],
          machineBreakDownTime: [
            { required: true, message: '故障时长不能为空', trigger: 'blur' }
          ],
          machineOfflineTime: [
            { required: true, message: '停机时长不能为空', trigger: 'blur' }
          ],
          recordCreateTime: [
            { required: true, message: '日报创建时间不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/stator/statorproductiondailyrecord/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.planId = data.statorProductionDailyRecord.planId
                this.dataForm.beginScheduleResource = data.statorProductionDailyRecord.beginScheduleResource
                this.dataForm.beginTrueResource = data.statorProductionDailyRecord.beginTrueResource
                this.dataForm.equipmentLocating = data.statorProductionDailyRecord.equipmentLocating
                this.dataForm.planIssuanceOfMaterials = data.statorProductionDailyRecord.planIssuanceOfMaterials
                this.dataForm.trueIssuanceOfMaterials = data.statorProductionDailyRecord.trueIssuanceOfMaterials
                this.dataForm.sOPverify = data.statorProductionDailyRecord.sOPverify
                this.dataForm.planBeginTime = data.statorProductionDailyRecord.planBeginTime
                this.dataForm.trueBeginTime = data.statorProductionDailyRecord.trueBeginTime
                this.dataForm.firstItemTime = data.statorProductionDailyRecord.firstItemTime
                this.dataForm.planEndTime = data.statorProductionDailyRecord.planEndTime
                this.dataForm.trueEndTime = data.statorProductionDailyRecord.trueEndTime
                this.dataForm.productPlanAmount = data.statorProductionDailyRecord.productPlanAmount
                this.dataForm.productTrueAmount = data.statorProductionDailyRecord.productTrueAmount
                this.dataForm.stockInAmount = data.statorProductionDailyRecord.stockInAmount
                this.dataForm.scrappedAmount = data.statorProductionDailyRecord.scrappedAmount
                this.dataForm.repairAmount = data.statorProductionDailyRecord.repairAmount
                this.dataForm.endScheduleResource = data.statorProductionDailyRecord.endScheduleResource
                this.dataForm.endTrueResource = data.statorProductionDailyRecord.endTrueResource
                this.dataForm.machineStatus = data.statorProductionDailyRecord.machineStatus
                this.dataForm.machineRunTime = data.statorProductionDailyRecord.machineRunTime
                this.dataForm.machineOperateTime = data.statorProductionDailyRecord.machineOperateTime
                this.dataForm.machineBreakDownTime = data.statorProductionDailyRecord.machineBreakDownTime
                this.dataForm.machineOfflineTime = data.statorProductionDailyRecord.machineOfflineTime
                this.dataForm.recordCreateTime = data.statorProductionDailyRecord.recordCreateTime
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
              url: this.$http.adornUrl(`/stator/statorproductiondailyrecord/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'planId': this.dataForm.planId,
                'beginScheduleResource': this.dataForm.beginScheduleResource,
                'beginTrueResource': this.dataForm.beginTrueResource,
                'equipmentLocating': this.dataForm.equipmentLocating,
                'planIssuanceOfMaterials': this.dataForm.planIssuanceOfMaterials,
                'trueIssuanceOfMaterials': this.dataForm.trueIssuanceOfMaterials,
                'sOPverify': this.dataForm.sOPverify,
                'planBeginTime': this.dataForm.planBeginTime,
                'trueBeginTime': this.dataForm.trueBeginTime,
                'firstItemTime': this.dataForm.firstItemTime,
                'planEndTime': this.dataForm.planEndTime,
                'trueEndTime': this.dataForm.trueEndTime,
                'productPlanAmount': this.dataForm.productPlanAmount,
                'productTrueAmount': this.dataForm.productTrueAmount,
                'stockInAmount': this.dataForm.stockInAmount,
                'scrappedAmount': this.dataForm.scrappedAmount,
                'repairAmount': this.dataForm.repairAmount,
                'endScheduleResource': this.dataForm.endScheduleResource,
                'endTrueResource': this.dataForm.endTrueResource,
                'machineStatus': this.dataForm.machineStatus,
                'machineRunTime': this.dataForm.machineRunTime,
                'machineOperateTime': this.dataForm.machineOperateTime,
                'machineBreakDownTime': this.dataForm.machineBreakDownTime,
                'machineOfflineTime': this.dataForm.machineOfflineTime,
                'recordCreateTime': this.dataForm.recordCreateTime
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
