<template>
  <div>
    <el-form
      :model="form"
      :rules="rules"
      ref="form"
      label-width="55px"
      class="demo-ruleForm"
    >
      <el-form-item label="类型">
        <el-select
          v-model="typeCid"
          filterable
          placeholder="类型"
          @change="typeChange"
        >
          <el-option
            v-for="item in types"
            :key="item.catId"
            :label="item.name"
            :value="item.catId"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="名称">
        <el-select
          v-model="nameCid"
          ref="name"
          filterable
          placeholder="名称"
          @change="nameChange"
        >
          <el-option
            v-for="item in names"
            :key="item.catId"
            :label="item.name"
            :value="item.catId"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="型号" prop="model"
        ><!-- prop="model" -->
        <el-select
          v-model="form.model"
          filterable
          placeholder="型号"
          @change="modelChange"
        >
          <el-option
            v-for="item in models"
            :key="item.catId"
            :label="item.name"
            :value="item.catId"
          >
            <span style="float: left">{{ item.name }}</span>
            <span style="float: right; color: #8492a6; font-size: 13px"
              >库存：{{ item.stockCount == null ? 0 : item.stockCount }}</span
            >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="数量">
        <el-input-number v-model="form.amount" :min="1"></el-input-number>
      </el-form-item>

      <el-form-item label="备注">
        <el-input
          type="textarea"
          :autosize="{ minRows: 2, maxRows: 4 }"
          v-model="form.comment"
          placeholder="备注"
          style="width: 15%"
        ></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="onSubmit">提交</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import Cookie from "js-cookie";
export default {
  data() {
    return {
      //===============提交表单===============
      form: {
        /* type: "",
        model: "",
        parcentCid: 0,
        parcentName: "",
        catLevel: 3, */
        name: "",
        model: "",
        modelName: "",
        amount: 0,
        comment: "",
        unit: "",
        uploadName: "",
        previousStock: 0,
      },

      //===============下拉数据绑定值===============
      typeCid: "",
      nameCid: "",

      //===============表单规则===============
      rules: {
        model: [{ required: true, message: "请选择型号", trigger: "change" }],
        /* type: [{ required: true, message: "请选择类型", trigger: "change" }],
        name: [{ required: true, message: "请选择名称", trigger: "change" }], 
        
         num: [
          {
            required: true,
            message: "请输入数量",
            trigger: "change",
          },
        ], */
      },

      //==============下拉框数据=================
      //类型下拉框
      types: [],

      //名字下拉框
      names: [],

      //型号下拉框
      models: [],
    };
  },
  computed: {},
  watch: {},
  methods: {
    //初始化所有单选框信息
    /* initModelSelect() {
      this.$http({
        url: this.$http.adornUrl("/it/stock/allList"),
        method: "get",
      }).then(({ data }) => {
        if (data.code === 0) {
          data.allList.forEach((element) => {
            if (element.catLevel === 1) {
              this.types.push({
                catId: element.catId,
                name: element.name,
                catLevel: 1,
              });
            } else if (element.catLevel === 2) {
              this.names.push({
                catId: element.catId,
                name: element.name,
                catLevel: 2,
                parentCid: element.parentCid,
                parcentName: element.parcentName,
              });
            } else {
              this.models.push({
                catId: element.catId,
                name: element.name,
                catLevel: 3,
                parentCid: element.parentCid,
                parcentName: element.parcentName,
                stockCount: element.stockCount,
              });
            }
          });
        }
      });
    }, */

    //================选择框初始化====================

    //初始化type下拉框
    initTypeSelect() {
      this.$http({
        url: this.$http.adornUrl("/it/stock/types"),
        method: "get",
      }).then(({ data }) => {
        if (data.code === 0) {
          data.types.forEach((element) => {
            this.types.push({
              catId: element.catId,
              name: element.name,
              //catLevel: 1,
            });
          });
        }
      });
    },

    //初始化name下拉框
    initNameSelect() {
      this.$http({
        url: this.$http.adornUrl("/it/stock/parentCid/" + this.typeCid),
        method: "get",
      }).then(({ data }) => {
        this.names = [];
        if (data.code === 0) {
          data.listByPC.forEach((element) => {
            this.names.push({
              catId: element.catId,
              name: element.name,
              //catLevel: 2,
            });
          });
        }
      });
    },

    //初始化model下拉框
    initModelSelect() {
      this.$http({
        url: this.$http.adornUrl("/it/stock/parentCid/" + this.nameCid),
        method: "get",
      }).then(({ data }) => {
        this.models = [];
        if (data.code === 0) {
          data.listByPC.forEach((element) => {
            this.models.push({
              catId: element.catId,
              name: element.name,
              stockCount: element.stockCount,
              stockUnit: element.stockUnit,
              //catLevel: 3,
              //stockUnit: element.stockUnit,
            });
          });
        }
      });
    },

    //================选择框监听====================

    //type选择框更改监听
    typeChange() {
      //当types内选择更改时，将其他选择框和表单name和model初始化
      /* this.form.name = "";
      this.form.model = ""; */
      this.nameCid = "";
      this.form.model = "";
      this.initNameSelect();
      this.models = [];
    },

    //name选择框更改监听
    nameChange() {
      //当names内选择更改时，将model选择框和表单model初始化
      this.form.model = "";
      let ref = this.$refs.name;

      this.$nextTick(function () {
        this.form.name = ref.query;
      });

      this.initModelSelect();
    },

    //model选择框更改监听
    modelChange() {
      //当model内选择更改时，表单内更改型号名称、单位
      this.models.forEach((element) => {
        if (element.catId === this.form.model) {
          this.form.unit = element.stockUnit;
          this.form.modelName = element.name;
          this.form.previousStock = element.stockCount;
          return;
        }
      });
    },

    /* getUnit(stockUnit) {
      this.form.unit = stockUnit;
    }, */

    //===============提交=================
    onSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          console.log(this.form);
          this.$confirm(
            `<h3>型号：${this.form.modelName} 数量：${this.form.amount} 确认提交？</h3>`,
            "提示",
            {
              dangerouslyUseHTMLString: true,
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              type: "warning",
            }
          )
            //todo 传输后端
            .then(() => {
              this.$http({
                url: this.$http.adornUrl("/it/stockupload/upload"),
                method: "post",
                data: this.$http.adornData(
                  {
                    name: this.form.name,
                    model: this.form.modelName,
                    unit: this.form.unit,
                    amount: this.form.amount,
                    comment: this.form.comment,
                    uploadName: this.form.uploadName,
                    modelCid: this.form.model,
                    previousStock: this.form.previousStock,
                  },
                  false
                ),
              })
                .then(({ data }) => {
                  if (data.code === 0) {
                    this.$message({
                      type: "success",
                      message: "库存上传成功!",
                    });
                  } else {
                    this.$message({
                      type: "error",
                      message: "库存上传失败!",
                    });
                  }
                })
                .catch(() => {
                  this.$message({
                    type: "error",
                    message: "库存上传失败!",
                  });
                });
            })
            .catch(() => {
              this.$message({
                type: "info",
                message: "已取消删除",
              });
            });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },

    //===============获取cookie的username=================
    showUserName() {
      let username = Cookie.get("username");
      this.form.uploadName = username;
    },
  },
  created() {
    this.initTypeSelect();
    this.showUserName();
  },
  mounted() {},
  beforeCreate() {},
  beforeMount() {},
  beforeUpdate() {},
  updated() {},
  beforeDestroy() {},
  destroyed() {},
  activated() {},
  components: {},
};
</script>

<style lang='scss' scoped>
</style>