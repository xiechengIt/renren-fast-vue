<!--  -->
<template>
  <div>
    <el-steps :active="step" finish-status="success">
      <el-step title="类型"></el-step>
      <el-step title="名称"></el-step>
      <el-step title="型号"></el-step>
      <!-- <el-step title="数量"></el-step> -->
      <el-step title="提交"></el-step>
    </el-steps>
    <el-button v-show="formCount > 0 && step == 0" @click="backList"
      >返回清单页面</el-button
    >
    <!-- 选择类型 -->
    <div v-show="step == 0" v-for="typeList in types">
      <el-row :gutter="20" style="margin: 35px">
        <div v-for="type in typeList">
          <el-col :span="8" v-if="type">
            <el-button type="primary" @click="getNames(type)">{{
              type
            }}</el-button>
          </el-col>
        </div>
      </el-row>
    </div>

    <!-- 选择名称 -->
    <el-button v-show="step == 1" @click="last">上一步</el-button>
    <div v-show="step == 1" v-for="nameList in names">
      <el-row :gutter="20" style="margin: 35px">
        <div v-for="name in nameList">
          <el-col :span="6" v-if="name">
            <el-button type="primary" @click="getModels(name)">{{
              name
            }}</el-button>
          </el-col>
        </div>
      </el-row>
    </div>

    <!-- 选择型号 -->
    <el-button v-show="step == 2" @click="last1">上一步</el-button>
    <div v-show="step == 2" v-for="modelList in models">
      <el-row :gutter="20" style="margin: 35px">
        <div v-for="model in modelList">
          <el-col :span="6" v-if="model">
            <el-button
              type="primary"
              :disabled="model.amount == 0"
              @click="getAmount(model.model, model.amount, model.unit)"
              >{{ model.model }}</el-button
            >
          </el-col>
        </div>
      </el-row>
    </div>

    <!-- 选择数量 -->
    <!-- <el-button v-show="step == 3" @click="last2">上一步</el-button>
    <el-button v-show="step == 3" @click="next">下一步</el-button>
    <div v-show="step == 3">
      <el-row :gutter="20" style="margin: 35px">
        <el-col :span="5">
          <el-button style="margin: 25px" type="primary">{{
            tempModel
          }}</el-button>
          <div style="margin: 15px">
            当前库存：{{ modelCount }}{{ tempUnit }}
          </div>
        </el-col>
        <el-col :span="10">
          <div v-for="num in numList" style="margin: 10px">
            <span v-for="n in num" style="margin: 10px">
              <el-button
                @click="getNum(n)"
                style="font-size: 20px"
                type="primary"
                >{{ n }}</el-button
              >
            </span>
          </div>
          <div style="margin: 10px">
            <span style="margin-left: 51px">
              <el-button
                @click="getNum(0)"
                style="font-size: 20px"
                type="primary"
                >0</el-button
              >
            </span>
            <el-button
              @click="cutNum()"
              class="el-icon-back"
              style="font-size: 20px"
              type="primary"
            ></el-button>
          </div>
          <el-input
            @blur="checkAmount"
            style="width: 250px"
            v-model="tempAmount"
            placeholder="请输入数量"
          ></el-input>
        </el-col>
      </el-row>
    </div> -->

    <!-- 展示form，上传照片 -->
    <div v-show="step == 3">
      <el-row :gutter="20">
        <!-- form -->
        <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="12">
          <table
            width="600"
            style="border: 1px solid #17b3a3; margin: 20px; text-align: center"
          >
            <tr>
              <th>名称</th>
              <th>型号</th>
              <th>数量</th>
              <th>单位</th>
              <th>操作</th>
            </tr>
            <tr v-for="(f, index) in form" :key="f.id">
              <td>{{ f.name }}</td>
              <td>{{ f.model }}</td>
              <td>
                <!-- <el-button
                  size="mini"
                  @click="minus(f.amount, f.formCount)"
                  icon="el-icon-minus"
                  circle
                ></el-button>
                <el-input style="width: 48px" v-model="f.amount"></el-input>
                <el-button
                  size="mini"
                  @click="plus(f.amount, f.modelCount, f.formCount)"
                  icon="el-icon-plus"
                  circle
                ></el-button> -->
                <el-input-number
                  style="width: 85px"
                  size="mini"
                  v-model="f.amount"
                  :min="1"
                  :max="f.modelCount"
                  label="数量"
                  >0</el-input-number
                >
              </td>
              <td>{{ f.unit }}</td>
              <td>
                <el-button
                  type="text"
                  size="small"
                  @click="deleteHandle(index, form)"
                  >删除</el-button
                >
              </td>
            </tr>
          </table>

          <div style="margin: 20px">
            <el-button size="small" type="primary" @click="add">添加</el-button>
          </div>
        </el-col>

        <!-- 提交 -->
        <el-col :xs="12" :sm="12" :md="12" :lg="8" :xl="8" style="margin: 10px">
          <el-form
            :model="uploadForm"
            :rules="rules"
            ref="uploadForm"
            label-width="100px"
            class="it-uploadForm"
          >
            <el-form-item label="部门名称" prop="department">
              <el-input v-model="uploadForm.department"></el-input>
            </el-form-item>
            <el-form-item label="领料人" prop="departmentMember">
              <el-input v-model="uploadForm.departmentMember"></el-input>
            </el-form-item>
            <el-form-item label="领料时间" prop="date">
              <el-date-picker
                v-model="uploadForm.date"
                type="datetime"
                placeholder="领料日期"
                align="right"
                :picker-options="pickerOptions"
                value-format="yyyy-MM-dd HH:mm:ss"
              >
              </el-date-picker>
            </el-form-item>
            <el-form-item label="备注" prop="comment">
              <el-input v-model="uploadForm.comment"></el-input>
            </el-form-item>
            <!-- <el-form-item label="领料人照片" prop="photo">
              <single-upload v-model="uploadForm.photo"></single-upload>
            </el-form-item> -->

            <el-form-item>
              <el-button type="primary" @click="submitForm('uploadForm')"
                >提交</el-button
              >
              <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import SingleUpload from "@/components/upload/singleUpload";
export default {
  inject: ["reload"], //注入App里的reload方法
  //import引入的组件需要注入到对象中才能使用
  components: {
    SingleUpload,
  },
  data() {
    //这里存放数据
    return {
      step: 0, //当前步骤

      types: [], //类型
      names: [], //名字
      models: [], //型号

      form: [], //用于提交
      formCount: 0, //用于计数当前form索引

      //选择数量时的临时model、amount、unit和当前物料的库存
      tempModel: "",
      tempAmount: "",
      tempUnit: "",
      modelCount: 0,

      numList: [], //用于数量数字拼接

      //提交表单
      uploadForm: {
        date: "",
        /* name: "",
        model: "",
        unit: "",
        amount: "", */
        comment: "",
        department: "",
        departmentMember: "",
        photo: "",
        comment: "",
        form: [],
      },
      pickerOptions: {
        shortcuts: [
          {
            text: "今天",
            onClick(picker) {
              picker.$emit("pick", new Date());
            },
          },
          {
            text: "昨天",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24);
              picker.$emit("pick", date);
            },
          },
          {
            text: "一周前",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit("pick", date);
            },
          },
        ],
      },
      //规则
      rules: {
        department: [
          {
            required: "true",
            message: "请输入部门名称",
            trigger: "blur",
          },
        ],
        departmentMember: [
          {
            required: "true",
            message: "请输入部门名称",
            trigger: "blur",
          },
        ],
        date: [
          {
            required: "true",
            message: "请输入领料时间",
            trigger: "blur",
          },
        ],
        /* photo: [
          {
            required: "true",
            message: "请传入照片",
            trigger: "blur",
          },
        ], */
      },
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    init() {
      let tempList = [];
      for (let i = 1; i < 10; i++) {
        tempList.push(i);
        if (i / 3 == 1 || i / 3 == 2 || i / 3 == 3) {
          this.numList.push(tempList);
          tempList = [];
        }
      }

      //this.numList.push([0, 0, 0]);
      this.$http({
        url: this.$http.adornUrl("/it/stock/types"),
        method: "get",
      }).then(({ data }) => {
        if (data.code === 0) {
          //将后端得到的types传入到this.types中，循环types.length/3次
          let types = Array.from(data.types);
          let result = parseInt(types.length / 3);
          let tempTypes = [];
          for (let i = 1; i <= result; i++) {
            for (let y = (i - 1) * 3; y < i * 3; y++) {
              tempTypes.push(types[y].name);
            }
            this.types.push(tempTypes);
            tempTypes = [];
          }
          //然后将剩余types.length%3的放入到this.types中
          let rest = types.length % 3;
          if (rest != 0) {
            for (let i = types.length - rest; i < types.length; i++) {
              tempTypes.push(types[i].name);
            }
            this.types.push(tempTypes);
          }
        }
      });
    },

    //获取type对应的name
    getNames(type) {
      this.$set(this.form, this.formCount, {
        id: Date.now(),
        type: type,
        name: "",
        model: "",
        unit: "",
        amount: 0,
        modelCount: 0,
        formCount: 0,
      });

      this.$http({
        url: this.$http.adornUrl("/it/stock/parentName/" + type),
        method: "get",
      }).then(({ data }) => {
        if (data.code === 0) {
          //将后端得到的names传入到this.names中，循环names.length/4次
          let names = Array.from(data.listByPN);
          let result = parseInt(names.length / 4);
          let rest = names.length % 4;
          let tempNames = [];
          if (result == 0 && rest == 0) {
            this.form[this.formCount].type = "";
            this.$message.error("暂无名称选择");
          } else {
            for (let i = 1; i <= result; i++) {
              for (let y = (i - 1) * 4; y < i * 4; y++) {
                tempNames.push(names[y].name);
              }
              this.names.push(tempNames);
              tempNames = [];
            }
          }
          //然后将剩余names.length%4的放入到this.names中
          if (rest != 0) {
            for (let i = names.length - rest; i < names.length; i++) {
              tempNames.push(names[i].name);
            }
            this.names.push(tempNames);
          }
        }
      });
      this.step++;
    },

    //上一步选择类型
    last() {
      //初始化当前form、获取的names、formId
      this.form[this.formCount] = {};
      this.names = [];
      this.formId--;
      this.step--;
    },

    //获取name对应的model
    getModels(name) {
      this.form[this.formCount].name = name;
      this.$http({
        url: this.$http.adornUrl("/it/stock/parentName/" + name),
        method: "get",
      }).then(({ data }) => {
        if (data.code === 0) {
          //将后端得到的models的传入到this.models中，循环models.length/4次
          let models = Array.from(data.listByPN);
          let result = parseInt(models.length / 4);
          let rest = models.length % 4;
          let tempModels = [];
          if (result == 0 && rest == 0) {
            this.form[this.formCount].name = "";
            this.$message.error("暂无类型选择");
          } else {
            for (let i = 1; i <= result; i++) {
              for (let y = (i - 1) * 4; y < i * 4; y++) {
                tempModels.push({
                  model: models[y].name,
                  amount:
                    models[y].stockCount == null ? 0 : models[y].stockCount,
                  unit: models[y].stockUnit,
                });
              }
              this.models.push(tempModels);
              tempModels = [];
            }
          }
          //然后将剩余names.length%4的放入到this.names中
          if (rest != 0) {
            for (let i = models.length - rest; i < models.length; i++) {
              tempModels.push({
                model: models[i].name,
                amount: models[i].stockCount == null ? 0 : models[i].stockCount,
                unit: models[i].stockUnit,
              });
            }
            this.models.push(tempModels);
          }
        }
      });
      this.step++;
    },

    //上一步选择名称
    last1() {
      //初始化当前form的name、获取的model
      this.form[this.formCount].name = "";
      this.models = [];
      this.step--;
    },

    //选择需要的数量
    getAmount(model, amount, unit) {
      this.tempModel = model;
      this.tempAmount = 1;
      this.tempUnit = unit;
      this.modelCount = amount;
      //判断form内是否有与当前选择的model相同的model，有则需要进行库存相加减
      this.form.forEach((item) => {
        if (item.model === model) {
          this.modelCount = amount - item.amount;
        }
      });

      //this.step++;
      this.next();
    },

    //上一步选择型号
    last2() {
      this.form[this.formCount].model = "";
      this.form[this.formCount].amount = "";
      this.form[this.formCount].unit = "";
      this.step--;
    },

    //对数字进行拼接
    getNum(num) {
      this.tempAmount += "" + num;
    },
    cutNum() {
      this.tempAmount += "";
      if (this.tempAmount && this.tempAmount.length > 0) {
        this.tempAmount = this.tempAmount.slice(0, this.tempAmount.length - 1);
      }
    },

    //检查当前输入的值是否在库存内
    checkAmount() {
      let tempCount = parseInt(this.tempAmount);
      if (this.modelCount == 0) {
        this.$message.error("您的领料单内已经有该货物的全部库存");
        return false;
      } else if (
        !Number.isInteger(tempCount) ||
        tempCount > this.modelCount ||
        tempCount <= 0
      ) {
        this.$message.error("请在库存范围内填写数量");
        return false;
      }
      return true;
    },

    //下一步到拍照提交页面
    next() {
      this.uploadForm.date = this.dateFormat("yyyy-MM-dd HH:mm:ss", new Date());
      if (!this.checkAmount()) {
        return;
      }
      //加入判断选择好的model是否已经在form中，在的就直接加库存
      let flag = 0;
      this.form.forEach((item) => {
        if (item.model == this.tempModel) {
          item.amount += parseInt(this.tempAmount);
          this.form.splice(this.formCount, 1);
          console.log("增加数量后的form");
          console.log(this.form);

          //还需要将添加的多余$set form删除
          this.formCount--;
          this.formId--;
          this.step++;
          flag++;
          return;
        }
      });
      if (flag == 0) {
        this.form[this.formCount].model = this.tempModel;
        this.form[this.formCount].unit = this.tempUnit;
        this.form[this.formCount].amount = parseInt(this.tempAmount);
        this.form[this.formCount].modelCount = parseInt(this.modelCount);
        this.form[this.formCount].formCount = this.formCount;

        console.log("2放入数据后的form");
        console.log(this.form);
        this.step++;
      }
    },

    //返回清单
    backList() {
      this.uploadForm.date = this.dateFormat("yyyy-MM-dd HH:mm:ss", new Date());
      //如form内有当前formCount的值，则需要删除
      if (this.form[this.formCount]) {
        this.form.splice(this.formCount, 1);
      }
      this.formCount--;
      this.step = 3;
    },

    //删除当前行
    deleteHandle(index, form) {
      //先将index之后的form表单的index项-1再删除
      /* for (let i = index + 1; i < this.tempForm.length; i++) {
        this.tempForm[i].index--;
      } */
      /* if (index == 0 && tempForm.length == 1) {
        tempForm = new Array();
        console.log("1删除后的tempForm");
        console.log(tempForm);
        console.log("1还未赋值的form");
        console.log(this.form);
        this.tempForm = tempForm;
        this.formCount--;
        this.form = tempForm;
      } else { }*/
      form.splice(index, 1);

      console.log("删除后的form");
      console.log(form);
      this.formCount--;
    },

    //新增行
    add() {
      this.names = [];
      this.models = [];
      this.formCount++;
      this.step = 0;
    },

    //表单提交
    submitForm(formName) {
      console.log(this.uploadForm.date);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$confirm("确认提交?", "提示", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
          })
            .then(() => {
              this.uploadForm.form = this.form;
              console.log(this.uploadForm);
              //post上传
              this.$http({
                url: this.$http.adornUrl("/it/stockBill/upload"),
                method: "post",
                data: this.$http.adornData(this.uploadForm, false),
              }).then(({ data }) => {
                if (data && data.code === 0) {
                  this.$message({
                    message: "上传成功",
                    type: "success",
                  });
                  this.reload(); //刷新页面
                } else this.$message.error("上传失败，原因：" + data.msg);
              });
            })
            .catch(() => {
              this.$message({
                type: "info",
                message: "已取消",
              });
            });
        } else {
          this.$message.error("请检查表单");
          return false;
        }
      });
    },

    //重置表单
    resetForm() {
      this.$refs.uploadForm.resetFields();
    },

    //时间格式化
    dateFormat(fmt, date) {
      var o = {
        "M+": date.getMonth() + 1, //月份
        "d+": date.getDate(), //日
        "H+": date.getHours(), //小时
        "m+": date.getMinutes(), //分
        "s+": date.getSeconds(), //秒
        "q+": Math.floor((date.getMonth() + 3) / 3), //季度
        S: date.getMilliseconds(), //毫秒
      };
      if (/(y+)/.test(fmt))
        fmt = fmt.replace(
          RegExp.$1,
          (date.getFullYear() + "").substr(4 - RegExp.$1.length)
        );
      for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
          fmt = fmt.replace(
            RegExp.$1,
            RegExp.$1.length == 1
              ? o[k]
              : ("00" + o[k]).substr(("" + o[k]).length)
          );
      return fmt;
    },

    //验证是否是正整数
    /* verification(amount) {
      let tempAmount = parseInt(amount);
      console.log("正在验证的值：");
      console.log(tempAmount);
      if (!/^[1-9]\d*$/.test(tempAmount)) {
        this.$message.error("请输入正确的数字");
        return false;
      }

      return true;
    }, */

    //减少
    /* minus(amount, formCount) {
      let flag = this.verification(amount);
      if (flag) {
        if (amount > 1) {
          this.form[formCount].amount--;
          console.log("减去后amount为：");
          console.log(this.form[formCount].amount);
        }
      }
    }, */

    //增加
    /* plus(amount, modelCount, formCount) {
      let flag = this.verification(amount);
      if (flag) {
        if (amount >= modelCount) {
          this.$message.error("超出了库存范围");
          return;
        }
        this.form[formCount].amount++;
        console.log("加上后amount为：");
        console.log(this.form[formCount].amount);
      }
    }, */
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {
    this.init();
  },
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
<style>
</style>