<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="工序名称" prop="processname">
      <el-input v-model="dataForm.processname" placeholder="工序名称"></el-input>
    </el-form-item>
    <el-form-item label="点位id" prop="machineid">
      <el-input v-model="dataForm.machineid" placeholder="点位id"></el-input>
    </el-form-item>
    <el-form-item label="线别" prop="lineid">
      <el-input v-model="dataForm.lineid" placeholder="线别"></el-input>
    </el-form-item>
    <el-form-item label="计划id" prop="planid">
      <el-input v-model="dataForm.planid" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="投入量" prop="dataa">
      <el-input v-model="dataForm.dataa" placeholder="投入量"></el-input>
    </el-form-item>
    <el-form-item label="产出量" prop="datab">
      <el-input v-model="dataForm.datab" placeholder="产出量"></el-input>
    </el-form-item>
    <el-form-item label="待传递" prop="datac">
      <el-input v-model="dataForm.datac" placeholder="待传递"></el-input>
    </el-form-item>
    <el-form-item label="数据采集量" prop="datacount">
      <el-input v-model="dataForm.datacount" placeholder="数据采集量"></el-input>
    </el-form-item>
    <el-form-item label="计划产量" prop="plancount">
      <el-input v-model="dataForm.plancount" placeholder="计划产量"></el-input>
    </el-form-item>
    <el-form-item label="更新时间" prop="date">
      <el-input v-model="dataForm.date" placeholder="更新时间"></el-input>
    </el-form-item>
    <el-form-item label="转子端(1是A端，2是B端)" prop="rotortype">
      <el-input v-model="dataForm.rotortype" placeholder="转子端(1是A端，2是B端)"></el-input>
    </el-form-item>
    <el-form-item label="不良品数量" prop="baditemcount">
      <el-input v-model="dataForm.baditemcount" placeholder="不良品数量"></el-input>
    </el-form-item>
    <el-form-item label="完成率" prop="productyield">
      <el-input v-model="dataForm.productyield" placeholder="完成率"></el-input>
    </el-form-item>
    <el-form-item label="结案" prop="finish">
      <el-input v-model="dataForm.finish" placeholder="结案"></el-input>
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
          processname: '',
          machineid: '',
          lineid: '',
          planid: '',
          dataa: '',
          datab: '',
          datac: '',
          datacount: '',
          plancount: '',
          date: '',
          rotortype: '',
          baditemcount: '',
          productyield: '',
          finish: ''
        },
        dataRule: {
          processname: [
            { required: true, message: '工序名称不能为空', trigger: 'blur' }
          ],
          machineid: [
            { required: true, message: '点位id不能为空', trigger: 'blur' }
          ],
          lineid: [
            { required: true, message: '线别不能为空', trigger: 'blur' }
          ],
          planid: [
            { required: true, message: '计划id不能为空', trigger: 'blur' }
          ],
          dataa: [
            { required: true, message: '投入量不能为空', trigger: 'blur' }
          ],
          datab: [
            { required: true, message: '产出量不能为空', trigger: 'blur' }
          ],
          datac: [
            { required: true, message: '待传递不能为空', trigger: 'blur' }
          ],
          datacount: [
            { required: true, message: '数据采集量不能为空', trigger: 'blur' }
          ],
          plancount: [
            { required: true, message: '计划产量不能为空', trigger: 'blur' }
          ],
          date: [
            { required: true, message: '更新时间不能为空', trigger: 'blur' }
          ],
          rotortype: [
            { required: true, message: '转子端(1是A端，2是B端)不能为空', trigger: 'blur' }
          ],
          baditemcount: [
            { required: true, message: '不良品数量不能为空', trigger: 'blur' }
          ],
          productyield: [
            { required: true, message: '完成率不能为空', trigger: 'blur' }
          ],
          finish: [
            { required: true, message: '结案不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/rotor/rotorboarddata/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.processname = data.rotorBoardData.processname
                this.dataForm.machineid = data.rotorBoardData.machineid
                this.dataForm.lineid = data.rotorBoardData.lineid
                this.dataForm.planid = data.rotorBoardData.planid
                this.dataForm.dataa = data.rotorBoardData.dataa
                this.dataForm.datab = data.rotorBoardData.datab
                this.dataForm.datac = data.rotorBoardData.datac
                this.dataForm.datacount = data.rotorBoardData.datacount
                this.dataForm.plancount = data.rotorBoardData.plancount
                this.dataForm.date = data.rotorBoardData.date
                this.dataForm.rotortype = data.rotorBoardData.rotortype
                this.dataForm.baditemcount = data.rotorBoardData.baditemcount
                this.dataForm.productyield = data.rotorBoardData.productyield
                this.dataForm.finish = data.rotorBoardData.finish
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
              url: this.$http.adornUrl(`/rotor/rotorboarddata/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'processname': this.dataForm.processname,
                'machineid': this.dataForm.machineid,
                'lineid': this.dataForm.lineid,
                'planid': this.dataForm.planid,
                'dataa': this.dataForm.dataa,
                'datab': this.dataForm.datab,
                'datac': this.dataForm.datac,
                'datacount': this.dataForm.datacount,
                'plancount': this.dataForm.plancount,
                'date': this.dataForm.date,
                'rotortype': this.dataForm.rotortype,
                'baditemcount': this.dataForm.baditemcount,
                'productyield': this.dataForm.productyield,
                'finish': this.dataForm.finish
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
