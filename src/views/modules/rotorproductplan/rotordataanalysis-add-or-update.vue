<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="产线id" prop="lineid">
      <el-input v-model="dataForm.lineid" placeholder="产线id"></el-input>
    </el-form-item>
    <el-form-item label="计划id" prop="planid">
      <el-input v-model="dataForm.planid" placeholder="计划id"></el-input>
    </el-form-item>
    <el-form-item label="转子端(1是A端，2是B端)" prop="rotortype">
      <el-input v-model="dataForm.rotortype" placeholder="转子端(1是A端，2是B端)"></el-input>
    </el-form-item>
    <el-form-item label="投入量" prop="inputcount">
      <el-input v-model="dataForm.inputcount" placeholder="投入量"></el-input>
    </el-form-item>
    <el-form-item label="产出量" prop="outputcount">
      <el-input v-model="dataForm.outputcount" placeholder="产出量"></el-input>
    </el-form-item>
    <el-form-item label="良率" prop="productyield">
      <el-input v-model="dataForm.productyield" placeholder="良率"></el-input>
    </el-form-item>
    <el-form-item label="产品直通率" prop="firstpassyield">
      <el-input v-model="dataForm.firstpassyield" placeholder="产品直通率"></el-input>
    </el-form-item>
    <el-form-item label="在线量" prop="machineonlinecount">
      <el-input v-model="dataForm.machineonlinecount" placeholder="在线量"></el-input>
    </el-form-item>
    <el-form-item label="工序总数" prop="machinetotalcount">
      <el-input v-model="dataForm.machinetotalcount" placeholder="工序总数"></el-input>
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
          lineid: '',
          planid: '',
          rotortype: '',
          inputcount: '',
          outputcount: '',
          productyield: '',
          firstpassyield: '',
          machineonlinecount: '',
          machinetotalcount: '',
          activation: ''
        },
        dataRule: {
          lineid: [
            { required: true, message: '产线id不能为空', trigger: 'blur' }
          ],
          planid: [
            { required: true, message: '计划id不能为空', trigger: 'blur' }
          ],
          rotortype: [
            { required: true, message: '转子端(1是A端，2是B端)不能为空', trigger: 'blur' }
          ],
          inputcount: [
            { required: true, message: '投入量不能为空', trigger: 'blur' }
          ],
          outputcount: [
            { required: true, message: '产出量不能为空', trigger: 'blur' }
          ],
          productyield: [
            { required: true, message: '良率不能为空', trigger: 'blur' }
          ],
          firstpassyield: [
            { required: true, message: '产品直通率不能为空', trigger: 'blur' }
          ],
          machineonlinecount: [
            { required: true, message: '在线量不能为空', trigger: 'blur' }
          ],
          machinetotalcount: [
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
              url: this.$http.adornUrl(`/rotor/rotordataanalysis/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.lineid = data.rotorDataAnalysis.lineid
                this.dataForm.planid = data.rotorDataAnalysis.planid
                this.dataForm.rotortype = data.rotorDataAnalysis.rotortype
                this.dataForm.inputcount = data.rotorDataAnalysis.inputcount
                this.dataForm.outputcount = data.rotorDataAnalysis.outputcount
                this.dataForm.productyield = data.rotorDataAnalysis.productyield
                this.dataForm.firstpassyield = data.rotorDataAnalysis.firstpassyield
                this.dataForm.machineonlinecount = data.rotorDataAnalysis.machineonlinecount
                this.dataForm.machinetotalcount = data.rotorDataAnalysis.machinetotalcount
                this.dataForm.activation = data.rotorDataAnalysis.activation
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
              url: this.$http.adornUrl(`/rotor/rotordataanalysis/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'lineid': this.dataForm.lineid,
                'planid': this.dataForm.planid,
                'rotortype': this.dataForm.rotortype,
                'inputcount': this.dataForm.inputcount,
                'outputcount': this.dataForm.outputcount,
                'productyield': this.dataForm.productyield,
                'firstpassyield': this.dataForm.firstpassyield,
                'machineonlinecount': this.dataForm.machineonlinecount,
                'machinetotalcount': this.dataForm.machinetotalcount,
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
