<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="点位id" prop="machineid">
      <el-input v-model="dataForm.machineid" placeholder="点位id"></el-input>
    </el-form-item>
    <el-form-item label="线别" prop="lineid">
      <el-input v-model="dataForm.lineid" placeholder="线别"></el-input>
    </el-form-item>
    <el-form-item label="计划id" prop="planid">
      <el-input v-model="dataForm.planid" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="数据A" prop="dataa">
      <el-input v-model="dataForm.dataa" placeholder="数据A"></el-input>
    </el-form-item>
    <el-form-item label="数据B" prop="datab">
      <el-input v-model="dataForm.datab" placeholder="数据B"></el-input>
    </el-form-item>
    <el-form-item label="数据C" prop="datac">
      <el-input v-model="dataForm.datac" placeholder="数据C"></el-input>
    </el-form-item>
    <el-form-item label="更新时间" prop="date">
      <el-input v-model="dataForm.date" placeholder="更新时间"></el-input>
    </el-form-item>
    <el-form-item label="数据采集量" prop="datacount">
      <el-input v-model="dataForm.datacount" placeholder="数据采集量"></el-input>
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
          machineid: '',
          lineid: '',
          planid: '',
          dataa: '',
          datab: '',
          datac: '',
          date: '',
          datacount: ''
        },
        dataRule: {
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
            { required: true, message: '数据A不能为空', trigger: 'blur' }
          ],
          datab: [
            { required: true, message: '数据B不能为空', trigger: 'blur' }
          ],
          datac: [
            { required: true, message: '数据C不能为空', trigger: 'blur' }
          ],
          date: [
            { required: true, message: '更新时间不能为空', trigger: 'blur' }
          ],
          datacount: [
            { required: true, message: '数据采集量不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/productionplan/lineboarddata/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.machineid = data.lineBoardData.machineid
                this.dataForm.lineid = data.lineBoardData.lineid
                this.dataForm.planid = data.lineBoardData.planid
                this.dataForm.dataa = data.lineBoardData.dataa
                this.dataForm.datab = data.lineBoardData.datab
                this.dataForm.datac = data.lineBoardData.datac
                this.dataForm.date = data.lineBoardData.date
                this.dataForm.datacount = data.lineBoardData.datacount
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
              url: this.$http.adornUrl(`/productionplan/lineboarddata/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'machineid': this.dataForm.machineid,
                'lineid': this.dataForm.lineid,
                'planid': this.dataForm.planid,
                'dataa': this.dataForm.dataa,
                'datab': this.dataForm.datab,
                'datac': this.dataForm.datac,
                'date': this.dataForm.date,
                'datacount': this.dataForm.datacount
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
