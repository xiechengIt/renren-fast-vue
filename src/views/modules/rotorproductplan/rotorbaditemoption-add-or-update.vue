<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="不良原因选项" prop="optionname">
      <el-input v-model="dataForm.optionname" placeholder="不良原因选项"></el-input>
    </el-form-item>
    <el-form-item label="父id" prop="parentid">
      <el-input v-model="dataForm.parentid" placeholder="父id"></el-input>
    </el-form-item>
    <el-form-item label="选项等级" prop="optionlevel">
      <el-input v-model="dataForm.optionlevel" placeholder="选项等级"></el-input>
    </el-form-item>
    <el-form-item label="选项排序" prop="optionorder">
      <el-input v-model="dataForm.optionorder" placeholder="选项排序"></el-input>
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
          optionname: '',
          parentid: '',
          optionlevel: '',
          optionorder: ''
        },
        dataRule: {
          optionname: [
            { required: true, message: '不良原因选项不能为空', trigger: 'blur' }
          ],
          parentid: [
            { required: true, message: '父id不能为空', trigger: 'blur' }
          ],
          optionlevel: [
            { required: true, message: '选项等级不能为空', trigger: 'blur' }
          ],
          optionorder: [
            { required: true, message: '选项排序不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/rotor/rotorbaditemoption/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.optionname = data.rotorBadItemOption.optionname
                this.dataForm.parentid = data.rotorBadItemOption.parentid
                this.dataForm.optionlevel = data.rotorBadItemOption.optionlevel
                this.dataForm.optionorder = data.rotorBadItemOption.optionorder
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
              url: this.$http.adornUrl(`/rotor/rotorbaditemoption/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'optionname': this.dataForm.optionname,
                'parentid': this.dataForm.parentid,
                'optionlevel': this.dataForm.optionlevel,
                'optionorder': this.dataForm.optionorder
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
