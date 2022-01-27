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
      label-width="80px"
    >
      <el-form-item label="组合号" prop="combineNo">
        <el-input v-model="dataForm.combineNo" placeholder="组合号"></el-input>
      </el-form-item>
      <el-form-item label="组合订单号" prop="combineOrderNo">
        <el-input
          v-model="dataForm.combineOrderNo"
          placeholder="组合订单号"
        ></el-input>
      </el-form-item>
      <el-form-item label="工单合计数量" prop="orderTotalCount">
        <el-input
          v-model="dataForm.orderTotalCount"
          placeholder="工单合计数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="分计划合计数量" prop="planTotalCount">
        <el-input
          v-model="dataForm.planTotalCount"
          placeholder="分计划合计数量"
        ></el-input>
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
        mplanId: 0,
        combineNo: "",
        combineOrderNo: "",
        orderTotalCount: "",
        planTotalCount: "",
      },
      dataRule: {
        combineNo: [
          { required: true, message: "组合号不能为空", trigger: "blur" },
        ],
        combineOrderNo: [
          { required: true, message: "组合订单号不能为空", trigger: "blur" },
        ],
        orderTotalCount: [
          { required: true, message: "工单合计数量不能为空", trigger: "blur" },
        ],
        planTotalCount: [
          {
            required: true,
            message: "分计划合计数量不能为空",
            trigger: "blur",
          },
        ],
      },
    };
  },
  methods: {
    init(id) {
      this.dataForm.mplanId = id || 0;
      this.visible = true;
      this.$nextTick(() => {
        this.$refs["dataForm"].resetFields();
        if (this.dataForm.mplanId) {
          this.$http({
            url: this.$http.adornUrl(
              `/productionplan/tblmplangroup/info/${this.dataForm.mplanId}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.combineNo = data.tblmplanGroup.combineNo;
              this.dataForm.combineOrderNo = data.tblmplanGroup.combineOrderNo;
              this.dataForm.orderTotalCount =
                data.tblmplanGroup.orderTotalCount;
              this.dataForm.planTotalCount = data.tblmplanGroup.planTotalCount;
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
              `/productionplan/tblmplangroup/${
                !this.dataForm.mplanId ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              mplanId: this.dataForm.mplanId || undefined,
              combineNo: this.dataForm.combineNo,
              combineOrderNo: this.dataForm.combineOrderNo,
              orderTotalCount: this.dataForm.orderTotalCount,
              planTotalCount: this.dataForm.planTotalCount,
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
