<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="类型" prop="type">
      <el-input v-model="dataForm.type" placeholder="类型"></el-input>
    </el-form-item>
    <el-form-item label="型号" prop="model">
      <el-input v-model="dataForm.model" placeholder="型号"></el-input>
    </el-form-item>
    <el-form-item label="型号id" prop="modelId">
      <el-input v-model="dataForm.modelId" placeholder="型号id"></el-input>
    </el-form-item>
    <el-form-item label="单位" prop="unit">
      <el-input v-model="dataForm.unit" placeholder="单位"></el-input>
    </el-form-item>
    <el-form-item label="原库存" prop="previousStock">
      <el-input v-model="dataForm.previousStock" placeholder="原库存"></el-input>
    </el-form-item>
    <el-form-item label="增加库存" prop="uploadStock">
      <el-input v-model="dataForm.uploadStock" placeholder="增加库存"></el-input>
    </el-form-item>
    <el-form-item label="当前库存" prop="currentStock">
      <el-input v-model="dataForm.currentStock" placeholder="当前库存"></el-input>
    </el-form-item>
    <el-form-item label="备注" prop="comment">
      <el-input v-model="dataForm.comment" placeholder="备注"></el-input>
    </el-form-item>
    <el-form-item label="上传人名字" prop="uploadName">
      <el-input v-model="dataForm.uploadName" placeholder="上传人名字"></el-input>
    </el-form-item>
    <el-form-item label="上传时间" prop="updateTime">
      <el-input v-model="dataForm.updateTime" placeholder="上传时间"></el-input>
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
          type: '',
          model: '',
          modelId: '',
          unit: '',
          previousStock: '',
          uploadStock: '',
          currentStock: '',
          comment: '',
          uploadName: '',
          updateTime: ''
        },
        dataRule: {
          type: [
            { required: true, message: '类型不能为空', trigger: 'blur' }
          ],
          model: [
            { required: true, message: '型号不能为空', trigger: 'blur' }
          ],
          modelId: [
            { required: true, message: '型号id不能为空', trigger: 'blur' }
          ],
          unit: [
            { required: true, message: '单位不能为空', trigger: 'blur' }
          ],
          previousStock: [
            { required: true, message: '原库存不能为空', trigger: 'blur' }
          ],
          uploadStock: [
            { required: true, message: '增加库存不能为空', trigger: 'blur' }
          ],
          currentStock: [
            { required: true, message: '当前库存不能为空', trigger: 'blur' }
          ],
          comment: [
            { required: true, message: '备注不能为空', trigger: 'blur' }
          ],
          uploadName: [
            { required: true, message: '上传人名字不能为空', trigger: 'blur' }
          ],
          updateTime: [
            { required: true, message: '上传时间不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/warehouse/clothstockuploadrecord/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.type = data.clothStockUploadRecord.type
                this.dataForm.model = data.clothStockUploadRecord.model
                this.dataForm.modelId = data.clothStockUploadRecord.modelId
                this.dataForm.unit = data.clothStockUploadRecord.unit
                this.dataForm.previousStock = data.clothStockUploadRecord.previousStock
                this.dataForm.uploadStock = data.clothStockUploadRecord.uploadStock
                this.dataForm.currentStock = data.clothStockUploadRecord.currentStock
                this.dataForm.comment = data.clothStockUploadRecord.comment
                this.dataForm.uploadName = data.clothStockUploadRecord.uploadName
                this.dataForm.updateTime = data.clothStockUploadRecord.updateTime
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
              url: this.$http.adornUrl(`/warehouse/clothstockuploadrecord/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'type': this.dataForm.type,
                'model': this.dataForm.model,
                'modelId': this.dataForm.modelId,
                'unit': this.dataForm.unit,
                'previousStock': this.dataForm.previousStock,
                'uploadStock': this.dataForm.uploadStock,
                'currentStock': this.dataForm.currentStock,
                'comment': this.dataForm.comment,
                'uploadName': this.dataForm.uploadName,
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
