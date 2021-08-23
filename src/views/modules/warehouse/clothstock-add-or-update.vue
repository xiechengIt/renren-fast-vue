<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="名称" prop="name">
      <el-input v-model="dataForm.name" placeholder="名称" disabled></el-input>
    </el-form-item>
    <!-- <el-form-item label="父id" prop="parentId">
      <el-input v-model="dataForm.parentId" placeholder="父id"></el-input>
    </el-form-item>
    <el-form-item label="父名称" prop="parentName">
      <el-input v-model="dataForm.parentName" placeholder="父名称"></el-input>
    </el-form-item>
    <el-form-item label="级别" prop="catLevel">
      <el-input v-model="dataForm.catLevel" placeholder="级别"></el-input>
    </el-form-item>
    <el-form-item label="排序" prop="sort">
      <el-input v-model="dataForm.sort" placeholder="排序"></el-input>
    </el-form-item>
    <el-form-item label="图标" prop="icon">
      <el-input v-model="dataForm.icon" placeholder="图标"></el-input>
    </el-form-item>
    <el-form-item label="是否显示" prop="showStatus">
      <el-input v-model="dataForm.showStatus" placeholder="是否显示"></el-input>
    </el-form-item> -->
    <el-form-item label="数量" prop="stockCount">
      <el-input v-model="dataForm.stockCount" placeholder="库存数量" disabled></el-input>
    </el-form-item>
    <el-form-item label="单位" prop="stockUnit">
      <el-input v-model="dataForm.stockUnit" placeholder="库存单位"></el-input>
    </el-form-item>
    <el-form-item label="单价" prop="unitPrice">
      <el-input v-model="dataForm.unitPrice" placeholder="单价"></el-input>
    </el-form-item>
    <el-form-item label="时间" prop="updateTime">
      <el-input v-model="dataForm.updateTime" placeholder="时间"></el-input>
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
          parentId: '',
          parentName: '',
          catLevel: '',
          sort: '',
          icon: '',
          showStatus: '',
          stockCount: '',
          stockUnit: '',
          unitPrice: '',
          updateTime: ''
        },
        dataRule: {
          name: [
            { required: true, message: '名称不能为空', trigger: 'blur' }
          ],
          parentId: [
            { required: true, message: '父id不能为空', trigger: 'blur' }
          ],
          parentName: [
            { required: true, message: '父名称不能为空', trigger: 'blur' }
          ],
          catLevel: [
            { required: true, message: '级别不能为空', trigger: 'blur' }
          ],
          sort: [
            { required: true, message: '排序不能为空', trigger: 'blur' }
          ],
          icon: [
            { required: true, message: '图标不能为空', trigger: 'blur' }
          ],
          showStatus: [
            { required: true, message: '是否显示不能为空', trigger: 'blur' }
          ],
          stockCount: [
            { required: true, message: '库存数量不能为空', trigger: 'blur' }
          ],
          stockUnit: [
            { required: true, message: '库存单位不能为空', trigger: 'blur' }
          ],
          /* unitPrice: [
            { required: true, message: '单价不能为空', trigger: 'blur' }
          ], */
          updateTime: [
            { required: true, message: '时间不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/warehouse/clothstock/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.name = data.clothStock.name
                this.dataForm.parentId = data.clothStock.parentId
                this.dataForm.parentName = data.clothStock.parentName
                this.dataForm.catLevel = data.clothStock.catLevel
                this.dataForm.sort = data.clothStock.sort
                this.dataForm.icon = data.clothStock.icon
                this.dataForm.showStatus = data.clothStock.showStatus
                this.dataForm.stockCount = data.clothStock.stockCount
                this.dataForm.stockUnit = data.clothStock.stockUnit
                this.dataForm.unitPrice = data.clothStock.unitPrice
                this.dataForm.updateTime = data.clothStock.updateTime
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
              url: this.$http.adornUrl(`/warehouse/clothstock/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'name': this.dataForm.name,
                'parentId': this.dataForm.parentId,
                'parentName': this.dataForm.parentName,
                'catLevel': this.dataForm.catLevel,
                'sort': this.dataForm.sort,
                'icon': this.dataForm.icon,
                'showStatus': this.dataForm.showStatus,
                'stockCount': this.dataForm.stockCount,
                'stockUnit': this.dataForm.stockUnit,
                'unitPrice': this.dataForm.unitPrice,
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
