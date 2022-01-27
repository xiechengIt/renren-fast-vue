<template>
  <el-dialog
    :title="!dataForm.catId ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
  >
    <el-form
      :model="dataForm"
      :rules="dataRule"
      ref="dataForm"
      @keyup.enter.native="dataFormSubmit()"
      label-width="80px"
    >
      <el-form-item label="名称" prop="parentName">
        <el-input v-model="dataForm.parentName" placeholder="名称"></el-input>
      </el-form-item>
      <el-form-item label="型号" prop="name">
        <el-input v-model="dataForm.name" placeholder="型号"></el-input>
      </el-form-item>
      <!-- <el-form-item label="是否显示" prop="showStatus">
        <el-input
          v-model="dataForm.showStatus"
          placeholder="[0不显示，1显示]"
        ></el-input>
      </el-form-item>
      <el-form-item label="排序" prop="sort">
        <el-input v-model="dataForm.sort" placeholder="排序"></el-input>
      </el-form-item>
      <el-form-item label="图标地址" prop="icon">
        <el-input v-model="dataForm.icon" placeholder="图标地址"></el-input>
      </el-form-item> -->
      <el-form-item label="库存数量" prop="stockCount">
        <el-input
          v-model="dataForm.stockCount"
          placeholder="库存数量"
          disabled
        ></el-input>
      </el-form-item>
      <el-form-item label="计量单位" prop="stockUnit">
        <el-input
          v-model="dataForm.stockUnit"
          placeholder="计量单位"
        ></el-input>
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-input
          v-model="dataForm.updateTime"
          placeholder="更新时间"
          :disabled="true"
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
        catId: 0,
        name: "",
        parentCid: "",
        parentName: "",
        catLevel: "",
        showStatus: "1",
        sort: "",
        icon: "",
        stockCount: "",
        stockUnit: "",
        updateTime: this.dateFormat("YYYY-mm-dd HH:MM:SS", new Date()),
      },
      dataRule: {
        parentName: [
          { required: true, message: "名称不能为空", trigger: "blur" },
        ],
        name: [{ required: true, message: "型号不能为空", trigger: "blur" }],
        /* showStatus: [
          {
            required: true,
            message: "是否显示[0-不显示，1显示]不能为空",
            trigger: "blur",
          },
        ],
        sort: [{ required: true, message: "排序不能为空", trigger: "blur" }],
        icon: [
          { required: true, message: "图标地址不能为空", trigger: "blur" },
        ], */
        stockCount: [
          { required: true, message: "库存数量不能为空", trigger: "blur" },
          /* { type: "integer", message: "计量单位必须为整数" }, */
        ],
        stockUnit: [
          { required: true, message: "计量单位不能为空", trigger: "blur" },
        ],
        updateTime: [
          { required: true, message: "更新时间不能为空", trigger: "blur" },
        ],
      },
    };
  },
  methods: {
    init(id) {
      this.dataForm.catId = id || 0;
      this.visible = true;
      this.$nextTick(() => {
        this.$refs["dataForm"].resetFields();
        if (this.dataForm.catId) {
          this.$http({
            url: this.$http.adornUrl(`/it/stock/info/${this.dataForm.catId}`),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.name = data.stock.name;
              this.dataForm.parentCid = data.stock.parentCid;
              this.dataForm.parentName = data.stock.parentName;
              this.dataForm.catLevel = data.stock.catLevel;
              this.dataForm.showStatus = data.stock.showStatus;
              this.dataForm.sort = data.stock.sort;
              this.dataForm.icon = data.stock.icon;
              this.dataForm.stockCount = data.stock.stockCount;
              this.dataForm.stockUnit = data.stock.stockUnit;
              this.dataForm.updateTime = data.stock.updateTime;
            }
          });
        }
      });
    },
    //时间格式化
    dateFormat(fmt, date) {
      let ret;
      const opt = {
        "Y+": date.getFullYear().toString(), // 年
        "m+": (date.getMonth() + 1).toString(), // 月
        "d+": date.getDate().toString(), // 日
        "H+": date.getHours().toString(), // 时
        "M+": date.getMinutes().toString(), // 分
        "S+": date.getSeconds().toString(), // 秒
        // 有其他格式化字符需求可以继续添加，必须转化成字符串
      };
      for (let k in opt) {
        ret = new RegExp("(" + k + ")").exec(fmt);
        if (ret) {
          fmt = fmt.replace(
            ret[1],
            ret[1].length == 1 ? opt[k] : opt[k].padStart(ret[1].length, "0")
          );
        }
      }
      return fmt;
    },
    // 表单提交
    dataFormSubmit() {
      this.$refs["dataForm"].validate((valid) => {
        if (valid) {
          this.$http({
            url: this.$http.adornUrl(
              `/it/stock/${!this.dataForm.catId ? "save" : "update"}`
            ),
            method: "post",
            data: this.$http.adornData({
              catId: this.dataForm.catId || undefined,
              name: this.dataForm.name,
              parentCid: this.dataForm.parentCid,
              catLevel: this.dataForm.catLevel,
              showStatus: this.dataForm.showStatus,
              sort: this.dataForm.sort,
              icon: this.dataForm.icon,
              stockCount: this.dataForm.stockCount,
              stockUnit: this.dataForm.stockUnit,
              updateTime: this.dateFormat("YYYY-mm-dd HH:MM:SS", new Date()),
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
