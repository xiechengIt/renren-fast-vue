<!--  -->
<template>
  <div class="">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-form
          :model="ruleForm"
          :rules="rules"
          ref="ruleForm"
          label-width="100px"
          class="demo-ruleForm"
        >
          <el-form-item label="产线id" prop="lineId">
            <el-select v-model="ruleForm.lineId" placeholder="请选择产线id">
              <el-option
                v-for="item in options"
                :key="item"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="品名" prop="productName">
            <el-input v-model="ruleForm.productName"></el-input>
          </el-form-item>
          <el-form-item label="规格" prop="specification">
            <el-input v-model="ruleForm.specification"></el-input>
          </el-form-item>
          <el-form-item label="料号" prop="partNum">
            <el-input v-model="ruleForm.partNum"></el-input>
          </el-form-item>
          <el-form-item label="订单号" prop="orderNum">
            <el-input v-model="ruleForm.orderNum"></el-input>
          </el-form-item>
          <el-form-item label="工单号" prop="workNum">
            <el-input v-model="ruleForm.workNum"></el-input>
          </el-form-item>
          <el-form-item label="生产计划量" prop="productPlanAmount">
            <el-input v-model="ruleForm.productPlanAmount"></el-input>
          </el-form-item>

          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')"
              >立即填写</el-button
            >
            <el-button @click="resetForm('ruleForm')">重置</el-button>
          </el-form-item>
        </el-form></el-col
      >
      <el-col :span="6"><div class="grid-content bg-purple"></div></el-col>
      <el-col :span="6"><div class="grid-content bg-purple"></div></el-col>
      <el-col :span="6"><div class="grid-content bg-purple"></div></el-col>
    </el-row>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';

export default {
  //import引入的组件需要注入到对象中才能使用
  components: {},
  data() {
    //这里存放数据
    return {
      ruleForm: {
        productName: "",
        specification: "",
        partNum: "",
        productPlanAmount: "",
        lineId: "",
        orderNum: "",
        workNum: "",
      },
      rules: {
        lineId: [
          { required: true, message: "请选择产线id", trigger: "change" },
        ],
        productName: [
          { required: true, message: "请输入品名", trigger: "blur" },
          ,
        ],
        specification: [
          { required: true, message: "请输入规格", trigger: "blur" },
          ,
        ],
        partNum: [
          { required: true, message: "请输入料号", trigger: "blur" },
          ,
        ],
        productPlanAmount: [
          { required: true, message: "请输入生产计划量", trigger: "blur" },
          ,
        ],
        orderNum: [
          { required: true, message: "请输入订单号", trigger: "blur" },
          ,
        ],
        workNum: [
          { required: true, message: "请输入工单号", trigger: "blur" },
          ,
        ],
      },
      options: [],
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          alert("submit!");
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    getLineIds() {
      this.$http({
        url: this.$http.adornUrl("/productionplan/department/getLineIds"),
        method: "get",
      }).then(({ data }) => {
        console.log(data);
        if (data && data.code === 0) {
          this.options = data.data;
        }
      });
    },
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {},
  //生命周期 - 挂载完成（可以访问DOM元素）
  mounted() {},
  beforeCreate() {}, //生命周期 - 创建之前
  beforeMount() {}, //生命周期 - 挂载之前
  beforeUpdate() {}, //生命周期 - 更新之前
  updated() {}, //生命周期 - 更新之后
  beforeDestroy() {}, //生命周期 - 销毁之前
  destroyed() {}, //生命周期 - 销毁完成
  activated() {
    this.getLineIds();
  }, //如果页面有keep-alive缓存功能，这个函数会触发
};
</script>
<style lang='scss' scoped>
//@import url(); 引入公共css类
</style>