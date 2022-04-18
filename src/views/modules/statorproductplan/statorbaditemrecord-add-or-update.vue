<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="返修原因" prop="badItemReason">
      <el-input v-model="dataForm.badItemReason" placeholder="返修原因"></el-input>
    </el-form-item>
    <el-form-item label="父id" prop="parentId">
      <el-input v-model="dataForm.parentId" placeholder="父id"></el-input>
    </el-form-item>
    <el-form-item label="装配线id" prop="lineId">
      <el-input v-model="dataForm.lineId" placeholder="装配线id"></el-input>
    </el-form-item>
    <el-form-item label="计划id" prop="planId">
      <el-input v-model="dataForm.planId" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="层级" prop="reasonLevel">
      <el-input v-model="dataForm.reasonLevel" placeholder="层级"></el-input>
    </el-form-item>
    <el-form-item label="排序" prop="reasonOrder">
      <el-input v-model="dataForm.reasonOrder" placeholder="排序"></el-input>
    </el-form-item>
    <el-form-item label="返修数量" prop="badItemCount">
      <el-input v-model="dataForm.badItemCount" placeholder="返修数量"></el-input>
    </el-form-item>
    <el-form-item label="计划生产量" prop="planProductAmount">
      <el-input v-model="dataForm.planProductAmount" placeholder="计划生产量"></el-input>
    </el-form-item>
    <el-form-item label="返修率" prop="percentage">
      <el-input v-model="dataForm.percentage" placeholder="返修率"></el-input>
    </el-form-item>
    <el-form-item label="创建日期" prop="createDate">
      <el-input v-model="dataForm.createDate" placeholder="创建日期"></el-input>
    </el-form-item>
    <el-form-item label="更新日期" prop="updateTime">
      <el-input v-model="dataForm.updateTime" placeholder="更新日期"></el-input>
    </el-form-item>
    <el-form-item label="操作员" prop="operator">
      <el-input v-model="dataForm.operator" placeholder="操作员"></el-input>
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
          badItemReason: '',
          parentId: '',
          lineId: '',
          planId: '',
          reasonLevel: '',
          reasonOrder: '',
          badItemCount: '',
          planProductAmount: '',
          percentage: '',
          createDate: '',
          updateTime: '',
          operator: ''
        },
        dataRule: {
          badItemReason: [
            { required: true, message: '返修原因不能为空', trigger: 'blur' }
          ],
          parentId: [
            { required: true, message: '父id不能为空', trigger: 'blur' }
          ],
          lineId: [
            { required: true, message: '装配线id不能为空', trigger: 'blur' }
          ],
          planId: [
            { required: true, message: '计划id不能为空', trigger: 'blur' }
          ],
          reasonLevel: [
            { required: true, message: '层级不能为空', trigger: 'blur' }
          ],
          reasonOrder: [
            { required: true, message: '排序不能为空', trigger: 'blur' }
          ],
          badItemCount: [
            { required: true, message: '返修数量不能为空', trigger: 'blur' }
          ],
          planProductAmount: [
            { required: true, message: '计划生产量不能为空', trigger: 'blur' }
          ],
          percentage: [
            { required: true, message: '返修率不能为空', trigger: 'blur' }
          ],
          createDate: [
            { required: true, message: '创建日期不能为空', trigger: 'blur' }
          ],
          updateTime: [
            { required: true, message: '更新日期不能为空', trigger: 'blur' }
          ],
          operator: [
            { required: true, message: '操作员不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/stator/statorbaditemrecord/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.badItemReason = data.statorBadItemRecord.badItemReason
                this.dataForm.parentId = data.statorBadItemRecord.parentId
                this.dataForm.lineId = data.statorBadItemRecord.lineId
                this.dataForm.planId = data.statorBadItemRecord.planId
                this.dataForm.reasonLevel = data.statorBadItemRecord.reasonLevel
                this.dataForm.reasonOrder = data.statorBadItemRecord.reasonOrder
                this.dataForm.badItemCount = data.statorBadItemRecord.badItemCount
                this.dataForm.planProductAmount = data.statorBadItemRecord.planProductAmount
                this.dataForm.percentage = data.statorBadItemRecord.percentage
                this.dataForm.createDate = data.statorBadItemRecord.createDate
                this.dataForm.updateTime = data.statorBadItemRecord.updateTime
                this.dataForm.operator = data.statorBadItemRecord.operator
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
              url: this.$http.adornUrl(`/stator/statorbaditemrecord/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'badItemReason': this.dataForm.badItemReason,
                'parentId': this.dataForm.parentId,
                'lineId': this.dataForm.lineId,
                'planId': this.dataForm.planId,
                'reasonLevel': this.dataForm.reasonLevel,
                'reasonOrder': this.dataForm.reasonOrder,
                'badItemCount': this.dataForm.badItemCount,
                'planProductAmount': this.dataForm.planProductAmount,
                'percentage': this.dataForm.percentage,
                'createDate': this.dataForm.createDate,
                'updateTime': this.dataForm.updateTime,
                'operator': this.dataForm.operator
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
