<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="企业id" prop="corpid">
      <el-input v-model="dataForm.corpid" placeholder="企业id"></el-input>
    </el-form-item>
    <el-form-item label="应用私钥" prop="corpsecret">
      <el-input v-model="dataForm.corpsecret" placeholder="应用私钥"></el-input>
    </el-form-item>
    <el-form-item label="应用ID" prop="agentid">
      <el-input v-model="dataForm.agentid" placeholder="应用ID"></el-input>
    </el-form-item>
    <el-form-item label="发送消息" prop="message">
      <el-input v-model="dataForm.message" placeholder="发送消息"></el-input>
    </el-form-item>
    <el-form-item label="接收人" prop="touser">
      <el-input v-model="dataForm.touser" placeholder="接收人"></el-input>
    </el-form-item>
    <el-form-item label="发送日期" prop="sendTime">
      <el-input v-model="dataForm.sendTime" placeholder="发送日期"></el-input>
    </el-form-item>
    <el-form-item label="消息发送状态" prop="status">
      <el-input v-model="dataForm.status" placeholder="消息发送状态"></el-input>
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
          corpid: '',
          corpsecret: '',
          agentid: '',
          message: '',
          touser: '',
          sendTime: '',
          status: ''
        },
        dataRule: {
          corpid: [
            { required: true, message: '企业id不能为空', trigger: 'blur' }
          ],
          corpsecret: [
            { required: true, message: '应用私钥不能为空', trigger: 'blur' }
          ],
          agentid: [
            { required: true, message: '应用ID不能为空', trigger: 'blur' }
          ],
          message: [
            { required: true, message: '发送消息不能为空', trigger: 'blur' }
          ],
          touser: [
            { required: true, message: '接收人不能为空', trigger: 'blur' }
          ],
          sendTime: [
            { required: true, message: '发送日期不能为空', trigger: 'blur' }
          ],
          status: [
            { required: true, message: '消息发送状态不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/board/wechatmessage/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.corpid = data.wechatMessage.corpid
                this.dataForm.corpsecret = data.wechatMessage.corpsecret
                this.dataForm.agentid = data.wechatMessage.agentid
                this.dataForm.message = data.wechatMessage.message
                this.dataForm.touser = data.wechatMessage.touser
                this.dataForm.sendTime = data.wechatMessage.sendTime
                this.dataForm.status = data.wechatMessage.status
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
              url: this.$http.adornUrl(`/board/wechatmessage/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'corpid': this.dataForm.corpid,
                'corpsecret': this.dataForm.corpsecret,
                'agentid': this.dataForm.agentid,
                'message': this.dataForm.message,
                'touser': this.dataForm.touser,
                'sendTime': this.dataForm.sendTime,
                'status': this.dataForm.status
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
