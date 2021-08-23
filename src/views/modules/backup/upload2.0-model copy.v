<template>
  <el-form :model="environmentForm" ref="environmentForm">
    <el-row :gutter="24" v-for="item in environmentForm.items" :key="item.key">
      <el-col :span="8">
        <el-form-item label="型号">
          <template slot-scope="scope">
            <el-select @change="modelChange(scope.row.value)" v-model="value">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
                :disabled="item.disabled"
              >
              </el-option>
            </el-select>
          </template>
        </el-form-item>
      </el-col>
      <el-col :span="6">
        <el-form-item label="数量">
          <el-input-number
            style="width: 100px"
            :min="min"
            size="mini"
            v-model="num"
          ></el-input-number>
        </el-form-item>
      </el-col>
      <el-col :span="6">
        <el-form-item label="单位">
          <el-input
            style="width: 50px"
            v-model="unit"
            :disabled="true"
          ></el-input>
        </el-form-item>
      </el-col>
      <el-col :span="2" v-if="environmentForm.items.length !== 1">
        <el-button
          @click="removeEnvironmentForm(item)"
          size="mini"
          class="el-icon-minus"
        ></el-button>
      </el-col>
      <el-col :span="2">
        <el-button
          @click="addEnvironmentForm"
          size="mini"
          class="el-icon-plus"
        ></el-button>
      </el-col>
    </el-row>
  </el-form>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';

export default {
  //import引入的组件需要注入到对象中才能使用
  components: {},
  props: ["parentName", "key", "index", "item"],
  data() {
    //这里存放数据
    return {
      environmentForm: {
        items: [
          {
            model: "",
            amount: "",
            unit: "",
          },
        ],
      },
      name: this.parentName,

      //打印机型号单选框
      options: [{}],
      value: "",

      //型号数量
      num: 0,
      min: 1,

      //型号单位
      unit: "",
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    //初始化方法
    init() {
      this.$http({
        url: this.$http.adornUrl("/it/stock/parentName"),
        method: "post",
        data: this.$http.adornData(this.name),
      }).then(({ data }) => {
        if (data.code === 0) {
          data.listByPN.forEach((element) => {
            this.options.push({
              value: element.name,
              label: element.name,
              disabled: element.stockCount < 1,
              num: element.stockCount,
              unit: element.stockUnit,
            });
          });
        }
      });
    },
    //属性数量选择表单
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    removeEnvironmentForm(item) {
      var index = this.environmentForm.items.indexOf(item);
      if (index !== -1) {
        this.environmentForm.items.splice(index, 1);
      }
    },
    addEnvironmentForm() {
      this.environmentForm.items.push({
        model: "",
        amount: "",
        unit: "",
        key: Date.now(),
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
  activated() {}, //如果页面有keep-alive缓存功能，这个函数会触发
};
</script>
<style lang='scss' scoped>
//@import url(); 引入公共css类
</style>