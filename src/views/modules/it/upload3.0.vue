<!--  -->
<template>
  <div class="">
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="12">
        <table width="750" stripe style="margin: 20px; text-align: center">
          <tr>
            <th>类型</th>
            <th>名称</th>
            <th>型号</th>
            <th>数量</th>
            <th>单位</th>
            <th>操作</th>
          </tr>
          <tr v-for="(f, index) in form" :key="f.id">
            <td>
              <el-select
                v-model="f.type"
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
              <!-- {{ f.name }} -->
            </td>
            <td>
              <el-select
                v-model="f.name"
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
            </td>
            <td>
              <el-select
                v-model="f.model"
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
                    >库存：{{
                      item.stockCount == null ? 0 : item.stockCount
                    }}</span
                  >
                </el-option>
              </el-select>
            </td>
            <td style="width: 95px">
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
            <td style="width: 85px">{{ f.unit }}</td>
            <td style="width: 85px">
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

      <!-- 提交数据 -->
      <el-col :xs="12" :sm="12" :md="12" :lg="8" :xl="8" style="margin: 10px">
        <el-form
          :model="uploadForm"
          :rules="rules"
          ref="uploadForm"
          label-width="100px"
          class="it-uploadForm"
          style="margin-top: 20px"
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
      //单选框
      types: [], //类型
      names: [], //名字
      models: [], //型号

      form: [{}], //用于提交

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
      //时间筛选
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
    /* submitForm(formName) {
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
    removeDomain(item) {
      var index = this.dynamicValidateForm.domains.indexOf(item);
      if (index !== -1) {
        this.dynamicValidateForm.domains.splice(index, 1);
      }
    },
    addDomain() {
      this.dynamicValidateForm.domains.push({
        value: "",
        key: Date.now(),
      });
    }, */

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
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {
    this.initTypeSelect();
    this.uploadForm.date = this.dateFormat("yyyy-MM-dd HH:mm:ss", new Date());
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
<style lang='scss' scoped>
</style>