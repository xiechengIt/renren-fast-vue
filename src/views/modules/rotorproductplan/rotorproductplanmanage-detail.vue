<!--  -->
<template>
  <div class="">
    <el-dialog
      :title="'转子车间' + this.lineId + '线' + '生产日报'"
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
          <el-input
            v-model="dataForm.productName"
            placeholder="品名"
          ></el-input>
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
      visible: false,
      dataForm: {
        planId: 0,
        lineId: "",
        productName: "",
        specification: "",
        partNum: "",
        productPlanAmount: "",
        date: "",
        rotorType: "",
      },
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    init(row) {
      console.log(row);
      this.dataForm.planId = row.planId;
      this.dataForm.lineId = row.lineId;
      this.dataForm.orderNumber = row.orderNumber;
      this.dataForm.partNumber = row.partNumber;
      this.dataForm.productName = row.productName;
      this.dataForm.specification = row.specification;
      this.dataForm.workNum = row.workNum;

      this.visible = true;
      this.$nextTick(() => {
        this.$refs["dataForm"].resetFields();
        if (this.dataForm.id) {
          this.$http({
            url: this.$http.adornUrl(
              `/rotor/rotorproductiondailyrecord/infoByPlanId/${this.dataForm.planId}`
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
<style scoped>
/*@@import url(); 引入公共css类*/
</style>