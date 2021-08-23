<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="100px">
    <el-form-item label="姓名" prop="name">
      <el-input v-model="dataForm.name" placeholder="姓名"></el-input>
    </el-form-item>
    <el-form-item label="性别" prop="sex">
      <el-input v-model="dataForm.sex" placeholder="性别"></el-input>
    </el-form-item>
    <el-form-item label="手机号" prop="phoneNum">
      <el-input v-model="dataForm.phoneNum" placeholder="手机号"></el-input>
    </el-form-item>
    <el-form-item label="身份证号码" prop="identityNum">
      <el-input v-model="dataForm.identityNum" placeholder="身份证号码"></el-input>
    </el-form-item>
    <el-form-item label="岗位" prop="job">
      <el-input v-model="dataForm.job" placeholder="岗位"></el-input>
    </el-form-item>
    <el-form-item label="介绍人" prop="introducer">
      <el-input v-model="dataForm.introducer" placeholder="介绍人"></el-input>
    </el-form-item>
    <el-form-item label="更新时间" prop="updateTime">
      <el-input v-model="dataForm.updateTime" placeholder="更新时间"></el-input>
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
          name: '',
          sex: '',
          phoneNum: '',
          identityNum: '',
          job: '',
          introducer: '',
          updateTime: ''
        },
        dataRule: {
          name: [
            { required: true, message: '姓名不能为空', trigger: 'blur' }
          ],
          sex: [
            { required: true, message: '性别不能为空', trigger: 'blur' }
          ],
          phoneNum: [
            { required: true, message: '手机号不能为空', trigger: 'blur' }
          ],
          identityNum: [
            { required: true, message: '身份证号码不能为空', trigger: 'blur' }
          ],
          job: [
            { required: true, message: '岗位不能为空', trigger: 'blur' }
          ],
          introducer: [
            { required: true, message: '介绍人不能为空', trigger: 'blur' }
          ],
          updateTime: [
            { required: true, message: '更新时间不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/employ/employinvite/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.name = data.employInvite.name
                this.dataForm.sex = data.employInvite.sex
                this.dataForm.phoneNum = data.employInvite.phoneNum
                this.dataForm.identityNum = data.employInvite.identityNum
                this.dataForm.job = data.employInvite.job
                this.dataForm.introducer = data.employInvite.introducer
                this.dataForm.updateTime = data.employInvite.updateTime
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
              url: this.$http.adornUrl(`/employ/employinvite/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'name': this.dataForm.name,
                'sex': this.dataForm.sex,
                'phoneNum': this.dataForm.phoneNum,
                'identityNum': this.dataForm.identityNum,
                'job': this.dataForm.job,
                'introducer': this.dataForm.introducer,
                'updateTime': this.dataForm.updateTime
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
