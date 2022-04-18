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
      label-width="auto"
    >
      <el-form-item label="不良原因选项" prop="optionName">
        <el-input
          v-model="dataForm.optionName"
          placeholder="不良原因选项"
        ></el-input>
      </el-form-item>
      <el-form-item label="父id" prop="parentId">
        <el-input v-model="dataForm.parentId" placeholder="父id"></el-input>
      </el-form-item>
      <el-form-item label="选项等级" prop="optionLevel">
        <el-input
          v-model="dataForm.optionLevel"
          placeholder="选项等级"
        ></el-input>
      </el-form-item>
      <el-form-item label="选项排序" prop="optionOrder">
        <el-input
          v-model="dataForm.optionOrder"
          placeholder="选项排序"
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
        id: 0,
        optionName: "",
        parentId: "",
        optionLevel: "",
        optionOrder: "",
      },
      dataRule: {
        optionName: [
          { required: true, message: "不良原因选项不能为空", trigger: "blur" },
        ],
        parentId: [
          { required: true, message: "父id不能为空", trigger: "blur" },
        ],
        optionLevel: [
          { required: true, message: "选项等级不能为空", trigger: "blur" },
        ],
        optionOrder: [
          { required: true, message: "选项排序不能为空", trigger: "blur" },
        ],
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
              `/rotor/rotorbaditemoption/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.optionName = data.rotorBadItemOption.optionName;
              this.dataForm.parentId = data.rotorBadItemOption.parentId;
              this.dataForm.optionLevel = data.rotorBadItemOption.optionLevel;
              this.dataForm.optionOrder = data.rotorBadItemOption.optionOrder;
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
              `/rotor/rotorbaditemoption/${
                !this.dataForm.id ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              id: this.dataForm.id || undefined,
              optionName: this.dataForm.optionName,
              parentId: this.dataForm.parentId,
              optionLevel: this.dataForm.optionLevel,
              optionOrder: this.dataForm.optionOrder,
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
