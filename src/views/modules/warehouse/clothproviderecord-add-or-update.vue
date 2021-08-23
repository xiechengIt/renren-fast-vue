<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="员工姓名" prop="emName">
      <el-input v-model="dataForm.emName" placeholder="员工姓名"></el-input>
    </el-form-item>
    <el-form-item label="员工工号" prop="emCode">
      <el-input v-model="dataForm.emCode" placeholder="员工工号"></el-input>
    </el-form-item>
    <el-form-item label="部门名称" prop="emDepartment">
      <el-input v-model="dataForm.emDepartment" placeholder="部门名称"></el-input>
    </el-form-item>
    <el-form-item label="职位" prop="emJob">
      <el-input v-model="dataForm.emJob" placeholder="职位"></el-input>
    </el-form-item>
    <el-form-item label="员工电话" prop="emMobile">
      <el-input v-model="dataForm.emMobile" placeholder="员工电话"></el-input>
    </el-form-item>
    <el-form-item label="员工照片" prop="emPhoto">
      <el-input v-model="dataForm.emPhoto" placeholder="员工照片"></el-input>
    </el-form-item>
    <el-form-item label="工衣类型" prop="clothType">
      <el-input v-model="dataForm.clothType" placeholder="工衣类型"></el-input>
    </el-form-item>
    <el-form-item label="工衣型号" prop="clothModel">
      <el-input v-model="dataForm.clothModel" placeholder="工衣型号"></el-input>
    </el-form-item>
    <el-form-item label="管理员姓名" prop="managerName">
      <el-input v-model="dataForm.managerName" placeholder="管理员姓名"></el-input>
    </el-form-item>
    <el-form-item label="领取日期" prop="updateTime">
      <el-input v-model="dataForm.updateTime" placeholder="领取日期"></el-input>
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
          emName: '',
          emCode: '',
          emPhoto: '',
          emDepartment: '',
          emJob: '',
          emMobile: '',
          clothType: '',
          clothModel: '',
          managerName: '',
          updateTime: ''
        },
        dataRule: {
          emName: [
            { required: true, message: '员工姓名不能为空', trigger: 'blur' }
          ],
          emCode: [
            { required: true, message: '员工工号不能为空', trigger: 'blur' }
          ],
          emPhoto: [
            { required: true, message: '员工照片不能为空', trigger: 'blur' }
          ],
          emDepartment: [
            { required: true, message: '部门名称不能为空', trigger: 'blur' }
          ],
          emJob: [
            { required: true, message: '职位不能为空', trigger: 'blur' }
          ],
          emMobile: [
            { required: true, message: '员工电话不能为空', trigger: 'blur' }
          ],
          clothType: [
            { required: true, message: '工衣类型不能为空', trigger: 'blur' }
          ],
          clothModel: [
            { required: true, message: '工衣型号不能为空', trigger: 'blur' }
          ],
          managerName: [
            { required: true, message: '管理员姓名不能为空', trigger: 'blur' }
          ],
          updateTime: [
            { required: true, message: '领取日期不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/warehouse/clothproviderecord/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.emName = data.clothProvideRecord.emName
                this.dataForm.emCode = data.clothProvideRecord.emCode
                this.dataForm.emPhoto = data.clothProvideRecord.emPhoto
                this.dataForm.emDepartment = data.clothProvideRecord.emDepartment
                this.dataForm.emJob = data.clothProvideRecord.emJob
                this.dataForm.emMobile = data.clothProvideRecord.emMobile
                this.dataForm.clothType = data.clothProvideRecord.clothType
                this.dataForm.clothModel = data.clothProvideRecord.clothModel
                this.dataForm.managerName = data.clothProvideRecord.managerName
                this.dataForm.updateTime = data.clothProvideRecord.updateTime
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
              url: this.$http.adornUrl(`/warehouse/clothproviderecord/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'emName': this.dataForm.emName,
                'emCode': this.dataForm.emCode,
                'emPhoto': this.dataForm.emPhoto,
                'emDepartment': this.dataForm.emDepartment,
                'emJob': this.dataForm.emJob,
                'emMobile': this.dataForm.emMobile,
                'clothType': this.dataForm.clothType,
                'clothModel': this.dataForm.clothModel,
                'managerName': this.dataForm.managerName,
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
