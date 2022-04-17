<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px"
  >
    <el-form
      :model="dataForm"
      :rules="dataRule"
      ref="dataForm"
      @keyup.enter.native="dataFormSubmit()"
      label-width="110px"
    >
      <el-form-item label="装配线id" prop="lineId">
        <el-input v-model="dataForm.lineId" placeholder="装配线id"></el-input>
      </el-form-item>
      <el-form-item label="品名" prop="productName">
        <el-input v-model="dataForm.productName" placeholder="品名"></el-input>
      </el-form-item>
      <el-form-item label="规格" prop="specification">
        <el-input
          v-model="dataForm.specification"
          placeholder="规格"
        ></el-input>
      </el-form-item>
      <el-form-item label="料号" prop="partNum">
        <el-input v-model="dataForm.partNum" placeholder="料号"></el-input>
      </el-form-item>
      <el-form-item label="生产计划数量" prop="productPlanAmount">
        <el-input
          v-model="dataForm.productPlanAmount"
          placeholder="生产计划数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="日期" prop="date">
        <el-input v-model="dataForm.date" placeholder="日期"></el-input>
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
  data() {
    return {
      visible: false,
      dataForm: {
        id: 0,
        lineId: "",
        productName: "",
        specification: "",
        partNum: "",
        productPlanAmount: "",
        date: "",
      },
      dataRule: {
        lineId: [
          { required: true, message: "装配线id不能为空", trigger: "blur" },
        ],
        productName: [
          { required: true, message: "品名不能为空", trigger: "blur" },
        ],
        specification: [
          { required: true, message: "规格不能为空", trigger: "blur" },
        ],
        partNum: [{ required: true, message: "料号不能为空", trigger: "blur" }],
        productPlanAmount: [
          { required: true, message: "生产计划数量不能为空", trigger: "blur" },
        ],
        date: [{ required: true, message: "日期不能为空", trigger: "blur" }],
      },
    };
  },
  methods: {
    init(id) {
      this.dataForm.id = id || 0;
      this.visible = true;
      this.$nextTick(() => {
        this.$refs["dataForm"].resetFields();
        if (this.dataForm.id) {
          this.$http({
            url: this.$http.adornUrl(
              `/rotor/rotorproductplanmanage/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.lineId = data.productPlanManage.lineId;
              this.dataForm.productName = data.productPlanManage.productName;
              this.dataForm.specification =
                data.productPlanManage.specification;
              this.dataForm.partNum = data.productPlanManage.partNum;
              this.dataForm.productPlanAmount =
                data.productPlanManage.productPlanAmount;
              this.dataForm.date = data.productPlanManage.date;
            }
          });
        }
      });
    },
    // 表单提交
    dataFormSubmit() {
      this.$refs["dataForm"].validate((valid) => {
        if (valid) {
          this.$http({
            url: this.$http.adornUrl(
              `/rotor/rotorproductplanmanage/${
                !this.dataForm.id ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              id: this.dataForm.id || undefined,
              lineId: this.dataForm.lineId,
              productName: this.dataForm.productName,
              specification: this.dataForm.specification,
              partNum: this.dataForm.partNum,
              productPlanAmount: this.dataForm.productPlanAmount,
              date: this.dataForm.date,
            }),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "操作成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  this.visible = false;
                  this.$emit("refreshDataList");
                },
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
  },
};
</script>
