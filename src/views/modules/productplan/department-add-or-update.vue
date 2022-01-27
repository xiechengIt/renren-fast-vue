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
      <el-form-item label="${column.comments}" prop="parentid">
        <el-input
          v-model="dataForm.parentid"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="remark">
        <el-input
          v-model="dataForm.remark"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="fstatus">
        <el-input
          v-model="dataForm.fstatus"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="iLevel">
        <el-input
          v-model="dataForm.iLevel"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="loginCount">
        <el-input
          v-model="dataForm.loginCount"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="deptid">
        <el-input
          v-model="dataForm.deptid"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="iOrder">
        <el-input
          v-model="dataForm.iOrder"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="deptname">
        <el-input
          v-model="dataForm.deptname"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="resetCount">
        <el-input
          v-model="dataForm.resetCount"
          placeholder="${column.comments}"
        ></el-input>
      </el-form-item>
      <el-form-item label="${column.comments}" prop="status">
        <el-input
          v-model="dataForm.status"
          placeholder="${column.comments}"
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
        percentage: 0,
        parentid: "",
        remark: "",
        fstatus: "",
        iLevel: "",
        loginCount: "",
        deptid: "",
        iOrder: "",
        deptname: "",
        resetCount: "",
        status: "",
      },
      dataRule: {
        parentid: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        remark: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        fstatus: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        iLevel: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        loginCount: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        deptid: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        iOrder: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        deptname: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        resetCount: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
        status: [
          {
            required: true,
            message: "${column.comments}不能为空",
            trigger: "blur",
          },
        ],
      },
    };
  },
  methods: {
    init(id) {
      this.dataForm.percentage = id || 0;
      this.visible = true;
      this.$nextTick(() => {
        this.$refs["dataForm"].resetFields();
        if (this.dataForm.percentage) {
          this.$http({
            url: this.$http.adornUrl(
              `/productionplan/department/info/${this.dataForm.percentage}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.parentid = data.department.parentid;
              this.dataForm.remark = data.department.remark;
              this.dataForm.fstatus = data.department.fstatus;
              this.dataForm.iLevel = data.department.iLevel;
              this.dataForm.loginCount = data.department.loginCount;
              this.dataForm.deptid = data.department.deptid;
              this.dataForm.iOrder = data.department.iOrder;
              this.dataForm.deptname = data.department.deptname;
              this.dataForm.resetCount = data.department.resetCount;
              this.dataForm.status = data.department.status;
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
              `/productionplan/department/${
                !this.dataForm.percentage ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              percentage: this.dataForm.percentage || undefined,
              parentid: this.dataForm.parentid,
              remark: this.dataForm.remark,
              fstatus: this.dataForm.fstatus,
              iLevel: this.dataForm.iLevel,
              loginCount: this.dataForm.loginCount,
              deptid: this.dataForm.deptid,
              iOrder: this.dataForm.iOrder,
              deptname: this.dataForm.deptname,
              resetCount: this.dataForm.resetCount,
              status: this.dataForm.status,
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
