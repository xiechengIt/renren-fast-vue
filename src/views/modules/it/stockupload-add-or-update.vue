<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="材料名称" prop="name">
      <el-input v-model="dataForm.name" placeholder="材料名称"></el-input>
    </el-form-item>
    <el-form-item label="型号" prop="model">
      <el-input v-model="dataForm.model" placeholder="型号"></el-input>
    </el-form-item>
    <el-form-item label="型号id" prop="modelCid">
      <el-input v-model="dataForm.modelCid" placeholder="型号id"></el-input>
    </el-form-item>
    <el-form-item label="单位" prop="unit">
      <el-input v-model="dataForm.unit" placeholder="单位"></el-input>
    </el-form-item>
    <el-form-item label="原库存" prop="previousStock">
      <el-input v-model="dataForm.previousStock" placeholder="原库存"></el-input>
    </el-form-item>
    <el-form-item label="增加数量" prop="amount">
      <el-input v-model="dataForm.amount" placeholder="增加数量"></el-input>
    </el-form-item>
    <el-form-item label="当前库存" prop="currentStock">
      <el-input v-model="dataForm.currentStock" placeholder="当前库存"></el-input>
    </el-form-item>
    <el-form-item label="单价" prop="price">
      <el-input v-model="dataForm.price" placeholder="单价"></el-input>
    </el-form-item>
    <el-form-item label="总价" prop="totalPrice">
      <el-input v-model="dataForm.totalPrice" placeholder="总价"></el-input>
    </el-form-item>
    <el-form-item label="备注" prop="comment">
      <el-input v-model="dataForm.comment" placeholder="备注"></el-input>
    </el-form-item>
    <el-form-item label="上传人名字" prop="uploadName">
      <el-input v-model="dataForm.uploadName" placeholder="上传人名字"></el-input>
    </el-form-item>
    <el-form-item label="上传时间" prop="date">
      <el-input v-model="dataForm.date" placeholder="上传时间"></el-input>
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
          model: '',
          modelCid: '',
          unit: '',
          previousStock: '',
          amount: '',
          currentStock: '',
          price: '',
          totalPrice: '',
          comment: '',
          uploadName: '',
          date: ''
        },
        dataRule: {
          name: [
            { required: true, message: '材料名称不能为空', trigger: 'blur' }
          ],
          model: [
            { required: true, message: '型号不能为空', trigger: 'blur' }
          ],
          modelCid: [
            { required: true, message: '型号id不能为空', trigger: 'blur' }
          ],
          unit: [
            { required: true, message: '单位不能为空', trigger: 'blur' }
          ],
          previousStock: [
            { required: true, message: '原库存不能为空', trigger: 'blur' }
          ],
          amount: [
            { required: true, message: '增加数量不能为空', trigger: 'blur' }
          ],
          currentStock: [
            { required: true, message: '当前库存不能为空', trigger: 'blur' }
          ],
          price: [
            { required: true, message: '单价不能为空', trigger: 'blur' }
          ],
          totalPrice: [
            { required: true, message: '总价不能为空', trigger: 'blur' }
          ],
          comment: [
            { required: true, message: '备注不能为空', trigger: 'blur' }
          ],
          uploadName: [
            { required: true, message: '上传人名字不能为空', trigger: 'blur' }
          ],
          date: [
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
              url: this.$http.adornUrl(`/it/stockupload/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.name = data.stockUpload.name
                this.dataForm.model = data.stockUpload.model
                this.dataForm.modelCid = data.stockUpload.modelCid
                this.dataForm.unit = data.stockUpload.unit
                this.dataForm.previousStock = data.stockUpload.previousStock
                this.dataForm.amount = data.stockUpload.amount
                this.dataForm.currentStock = data.stockUpload.currentStock
                this.dataForm.price = data.stockUpload.price
                this.dataForm.totalPrice = data.stockUpload.totalPrice
                this.dataForm.comment = data.stockUpload.comment
                this.dataForm.uploadName = data.stockUpload.uploadName
                this.dataForm.date = data.stockUpload.date
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
              url: this.$http.adornUrl(`/it/stockupload/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'name': this.dataForm.name,
                'model': this.dataForm.model,
                'modelCid': this.dataForm.modelCid,
                'unit': this.dataForm.unit,
                'previousStock': this.dataForm.previousStock,
                'amount': this.dataForm.amount,
                'currentStock': this.dataForm.currentStock,
                'price': this.dataForm.price,
                'totalPrice': this.dataForm.totalPrice,
                'comment': this.dataForm.comment,
                'uploadName': this.dataForm.uploadName,
                'date': this.dataForm.date
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
