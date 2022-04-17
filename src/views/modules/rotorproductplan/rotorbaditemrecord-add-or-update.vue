<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="返修原因" prop="baditemreason">
      <el-input v-model="dataForm.baditemreason" placeholder="返修原因"></el-input>
    </el-form-item>
    <el-form-item label="父id" prop="parentid">
      <el-input v-model="dataForm.parentid" placeholder="父id"></el-input>
    </el-form-item>
    <el-form-item label="品名" prop="itemname">
      <el-input v-model="dataForm.itemname" placeholder="品名"></el-input>
    </el-form-item>
    <el-form-item label="品名id" prop="itemid">
      <el-input v-model="dataForm.itemid" placeholder="品名id"></el-input>
    </el-form-item>
    <el-form-item label="装配线id" prop="lineid">
      <el-input v-model="dataForm.lineid" placeholder="装配线id"></el-input>
    </el-form-item>
    <el-form-item label="计划id" prop="planid">
      <el-input v-model="dataForm.planid" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="层级" prop="reasonlevel">
      <el-input v-model="dataForm.reasonlevel" placeholder="层级"></el-input>
    </el-form-item>
    <el-form-item label="排序" prop="reasonorder">
      <el-input v-model="dataForm.reasonorder" placeholder="排序"></el-input>
    </el-form-item>
    <el-form-item label="返修数量" prop="baditemcount">
      <el-input v-model="dataForm.baditemcount" placeholder="返修数量"></el-input>
    </el-form-item>
    <el-form-item label="计划生产量" prop="planproductamount">
      <el-input v-model="dataForm.planproductamount" placeholder="计划生产量"></el-input>
    </el-form-item>
    <el-form-item label="返修率" prop="percentage">
      <el-input v-model="dataForm.percentage" placeholder="返修率"></el-input>
    </el-form-item>
    <el-form-item label="日期" prop="date">
      <el-input v-model="dataForm.date" placeholder="日期"></el-input>
    </el-form-item>
    <el-form-item label="结案" prop="finish">
      <el-input v-model="dataForm.finish" placeholder="结案"></el-input>
    </el-form-item>
    <el-form-item label="转子端(0是A端，1是B端)" prop="rotortype">
      <el-input v-model="dataForm.rotortype" placeholder="转子端(0是A端，1是B端)"></el-input>
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
          baditemreason: '',
          parentid: '',
          itemname: '',
          itemid: '',
          lineid: '',
          planid: '',
          reasonlevel: '',
          reasonorder: '',
          baditemcount: '',
          planproductamount: '',
          percentage: '',
          date: '',
          finish: '',
          rotortype: ''
        },
        dataRule: {
          baditemreason: [
            { required: true, message: '返修原因不能为空', trigger: 'blur' }
          ],
          parentid: [
            { required: true, message: '父id不能为空', trigger: 'blur' }
          ],
          itemname: [
            { required: true, message: '品名不能为空', trigger: 'blur' }
          ],
          itemid: [
            { required: true, message: '品名id不能为空', trigger: 'blur' }
          ],
          lineid: [
            { required: true, message: '装配线id不能为空', trigger: 'blur' }
          ],
          planid: [
            { required: true, message: '计划id不能为空', trigger: 'blur' }
          ],
          reasonlevel: [
            { required: true, message: '层级不能为空', trigger: 'blur' }
          ],
          reasonorder: [
            { required: true, message: '排序不能为空', trigger: 'blur' }
          ],
          baditemcount: [
            { required: true, message: '返修数量不能为空', trigger: 'blur' }
          ],
          planproductamount: [
            { required: true, message: '计划生产量不能为空', trigger: 'blur' }
          ],
          percentage: [
            { required: true, message: '返修率不能为空', trigger: 'blur' }
          ],
          date: [
            { required: true, message: '日期不能为空', trigger: 'blur' }
          ],
          finish: [
            { required: true, message: '结案不能为空', trigger: 'blur' }
          ],
          rotortype: [
            { required: true, message: '转子端(0是A端，1是B端)不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/rotor/rotorbaditemrecord/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.baditemreason = data.rotorBadItemRecord.baditemreason
                this.dataForm.parentid = data.rotorBadItemRecord.parentid
                this.dataForm.itemname = data.rotorBadItemRecord.itemname
                this.dataForm.itemid = data.rotorBadItemRecord.itemid
                this.dataForm.lineid = data.rotorBadItemRecord.lineid
                this.dataForm.planid = data.rotorBadItemRecord.planid
                this.dataForm.reasonlevel = data.rotorBadItemRecord.reasonlevel
                this.dataForm.reasonorder = data.rotorBadItemRecord.reasonorder
                this.dataForm.baditemcount = data.rotorBadItemRecord.baditemcount
                this.dataForm.planproductamount = data.rotorBadItemRecord.planproductamount
                this.dataForm.percentage = data.rotorBadItemRecord.percentage
                this.dataForm.date = data.rotorBadItemRecord.date
                this.dataForm.finish = data.rotorBadItemRecord.finish
                this.dataForm.rotortype = data.rotorBadItemRecord.rotortype
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
              url: this.$http.adornUrl(`/rotor/rotorbaditemrecord/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'baditemreason': this.dataForm.baditemreason,
                'parentid': this.dataForm.parentid,
                'itemname': this.dataForm.itemname,
                'itemid': this.dataForm.itemid,
                'lineid': this.dataForm.lineid,
                'planid': this.dataForm.planid,
                'reasonlevel': this.dataForm.reasonlevel,
                'reasonorder': this.dataForm.reasonorder,
                'baditemcount': this.dataForm.baditemcount,
                'planproductamount': this.dataForm.planproductamount,
                'percentage': this.dataForm.percentage,
                'date': this.dataForm.date,
                'finish': this.dataForm.finish,
                'rotortype': this.dataForm.rotortype
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
