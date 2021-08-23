<!-- 查看指定id详情 -->
<template>
  <el-dialog
    :title="dataForm.id"
    :close-on-click-modal="false"
    :visible.sync="visible"
  >
    <el-form
      :model="dataForm"
      ref="dataForm"
      @keyup.enter.native="dataFormSubmit()"
      label-width="110px"
    >
      <el-table
        :data="dataList"
        border
        v-loading="dataListLoading"
        style="width: 100%"
      >
        <el-table-column
          header-align="center"
          align="center"
          label="材料名称"
          prop="name"
        >
        </el-table-column>
        <el-table-column
          header-align="center"
          align="center"
          label="型号"
          prop="model"
        >
        </el-table-column>
        <el-table-column
          header-align="center"
          align="center"
          label="单位"
          prop="unit"
        >
        </el-table-column>
        <el-table-column
          header-align="center"
          align="center"
          label="数量"
          prop="amount"
        >
        </el-table-column>
        <el-table-column
          header-align="center"
          align="center"
          label="单价"
          prop="price"
        >
        </el-table-column>
        <el-table-column
          header-align="center"
          align="center"
          label="总价"
          prop="totalPrice"
        >
        </el-table-column>
        <el-table-column
          header-align="center"
          align="center"
          label="备注"
          prop="comment"
        >
        </el-table-column>
      </el-table>
      <br />
      <el-form-item label="单号" prop="no">
        <el-input v-model="dataForm.no" placeholder="单号"></el-input>
      </el-form-item>
      <el-form-item label="领料日期" prop="date">
        <el-input v-model="dataForm.date" placeholder="领料日期"></el-input>
      </el-form-item>
      <el-form-item label="领料人" prop="departmentMember">
        <el-input
          v-model="dataForm.departmentMember"
          placeholder="领料人"
        ></el-input>
      </el-form-item>

      <el-form-item label="领料部门" prop="department">
        <el-input
          v-model="dataForm.department"
          placeholder="领料部门"
        ></el-input>
      </el-form-item>
      <el-form-item label="领料部门负责人" prop="departmentLeader">
        <el-input
          style="border: auto"
          v-model="dataForm.departmentLeader"
          placeholder="领料部门负责人"
        ></el-input>
      </el-form-item>

      <el-form-item label="领料人照片" prop="photo">
        <el-input v-model="dataForm.photo" placeholder="领料人照片"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">关闭</el-button>
    </span>
  </el-dialog>
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
        id: "0",
        no: "",
        date: "",
        name: "",
        model: "",
        unit: "",
        amount: "",
        price: "",
        totalPrice: "",
        comment: "",
        department: "",
        departmentLeader: "",
        departmentMember: "",
        photo: "",
      },
      dataList: [],
      dataListLoading: false,
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    doSplit(str) {
      if (str && str.length > 0) {
        let strs = str.split(",");
        return strs;
      }
      return null;
    },
    init(id) {
      let _this = this;
      this.dataListLoading = true;
      this.dataForm.id = id + "";
      this.visible = true;
      this.$nextTick(() => {
        this.$refs["dataForm"].resetFields();
        if (this.dataForm.id) {
          this.$http({
            url: this.$http.adornUrl(
              `/it/stockBill/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.no = data.stockBill.no;
              this.dataForm.date = data.stockBill.date;
              this.dataForm.department = data.stockBill.department;
              this.dataForm.departmentLeader = data.stockBill.departmentLeader;
              this.dataForm.departmentMember = data.stockBill.departmentMember;
              this.dataForm.photo = data.stockBill.photo;

              //将材料名称、材料型号、单位、数量、单价、金额、备注根据","进行分割，组成数组写入到dataList中
              let names = _this.doSplit(data.stockBill.name);
              let models = _this.doSplit(data.stockBill.model);
              let units = _this.doSplit(data.stockBill.unit);
              let amounts = _this.doSplit(data.stockBill.amount);
              let prices = _this.doSplit(data.stockBill.price);
              let totalPrices = _this.doSplit(data.stockBill.totalPrice);
              let comments = _this.doSplit(data.stockBill.comment);

              let dataList1 = [];
              for (let index = 0; index < names.length; index++) {
                let data = {};
                //如果数据为null，则不能获取索引，需要处理
                if (names != null) {
                  data.name = names[index] == undefined ? null : names[index];
                }
                if (models != null) {
                  data.model =
                    models[index] == undefined ? null : models[index];
                }
                if (units != null) {
                  data.unit = units[index] == undefined ? null : units[index];
                }
                if (amounts != null) {
                  data.amount =
                    amounts[index] == undefined ? null : amounts[index];
                }
                if (prices != null) {
                  data.price =
                    prices[index] == undefined ? null : prices[index];
                }
                if (totalPrices != null) {
                  data.totalPrice =
                    totalPrices[index] == undefined ? null : totalPrices[index];
                }
                if (comments != null) {
                  data.comment =
                    comments[index] == undefined ? null : comments[index];
                }
                dataList1.push(data);
              }
              console.log("-------已拆分data数据-------");
              console.log(dataList1);
              console.log("---------------------------");
              this.dataList = dataList1;
            }
          });
        }
      });
      this.dataListLoading = false;
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