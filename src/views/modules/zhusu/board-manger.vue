<template>
  <div class="">
    <div class="test">
      <h2>页面测试</h2>
      <div style="margin-bottom: 15px; width: 28rem">
        <el-input
          placeholder="输入机台号码"
          v-model="testMachineId"
          class="input-with-select"
        >
          <el-select
            v-model="testCount"
            slot="prepend"
            placeholder="选择次数"
            style="width: 7rem"
          >
            <el-option label="10" value="10"></el-option>
            <el-option label="20" value="20"></el-option>
            <el-option label="50" value="50"></el-option>
            <el-option label="100" value="100"></el-option>
            <el-option label="150" value="150"></el-option>
            <el-option label="200" value="200"></el-option>
            <el-option label="250" value="250"></el-option>
          </el-select>
          <el-button slot="append" @click="testByMachineId"
            >测试指定页面</el-button
          >
        </el-input>
      </div>
      <div>
        <el-row :gutter="20">
          <el-col :span="6">
            <el-button id="testJ" type="primary" round @click="testByAreaId(10)"
              >测试J区所有机号</el-button
            >
            <el-button id="testK" type="primary" round
              >测试K区所有机号</el-button
            >
          </el-col>
          <el-col :span="6"
            ><el-button id="testB" type="primary" round
              >测试B区所有机号</el-button
            >
            <el-button id="testC" type="primary" round
              >测试C区所有机号</el-button
            >
          </el-col>
          <el-col :span="6"
            ><el-button id="testF" type="primary" round
              >测试F区所有机号</el-button
            >
            <el-button id="testQ" type="primary" round
              >测试Q区所有机号</el-button
            >
          </el-col>
          <el-col :span="6"
            ><el-button id="testH" type="primary" round
              >测试H区所有机号</el-button
            ></el-col
          >
        </el-row>
      </div>
      <div style="margin-top: 1rem">
        <el-row :gutter="20">
          <el-col :span="6"
            ><el-button id="testS" type="primary" round
              >测试S区所有机号</el-button
            >
            <el-button id="testA" type="primary" round
              >测试A区所有机号</el-button
            ></el-col
          >
          <el-col :span="6"
            ><el-button id="testD" type="primary" round
              >测试D区所有机号</el-button
            >
            <el-button id="testE" type="primary" round
              >测试E区所有机号</el-button
            ></el-col
          >
          <el-col :span="6"
            ><el-button id="testL" type="primary" round
              >测试L区所有机号</el-button
            >
            <el-button id="testG" type="primary" round
              >测试G区所有机号</el-button
            ></el-col
          >
          <el-col :span="6"></el-col>
        </el-row>
      </div>
    </div>

    <div>
      <h2>限制登陆次数重置</h2>
      <!-- 重置指定机号登陆次数 -->
      <div style="margin-top: 15px">
        <el-input
          placeholder="输入机台号码"
          v-model="loginCountMachineId"
          class="input-with-select"
          style="width: 25rem"
        >
          <el-button slot="append" @click="reset(1)"
            >重置机台限制登陆次数</el-button
          >
        </el-input>
      </div>
      <!-- 重置所有机台登陆次数 -->
      <div style="margin-top: 10px">
        <el-button type="danger" @click="open(1)"
          >重置所有机台限制登陆次数</el-button
        >
      </div>
    </div>

    <div>
      <h2>整点数据重置</h2>
      <!-- 重置指定机号整点数据 -->
      <div style="margin-top: 15px">
        <el-input
          placeholder="输入机台号码"
          v-model="hourlyDataMachineId"
          class="input-with-select"
          style="width: 25rem"
        >
          <el-button slot="append" @click="reset(2)"
            >重置机台整点数据</el-button
          >
        </el-input>
      </div>
      <!-- 重置所有机台整点数据 -->
      <div style="margin-top: 10px">
        <el-button type="danger" @click="open(2)"
          >重置所有机台整点数据</el-button
        >
      </div>
    </div>

    <div>
      <h2>指定机号0点到指定整点的数据重新计算（整点不选默认当前时间）</h2>
      <div style="margin-bottom: 15px; width: 28rem">
        <el-input
          placeholder="输入机台号码"
          v-model="resetMachineId"
          class="input-with-select"
        >
          <el-select
            v-model="selectHour"
            slot="prepend"
            placeholder="选择整点"
            style="width: 7rem"
          >
            <el-option
              v-for="hour in hours"
              :key="hour.value"
              :label="hour"
              :value="hour"
            ></el-option>
          </el-select>
          <el-button slot="append" @click="resetHourlyData">重新计算</el-button>
        </el-input>
      </div>
    </div>
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
      loginCountMachineId: "",
      hourlyDataMachineId: "",
      testMachineId: "", //测试机号
      testCount: "", //测试数量
      hours: [], //24小时整点
      selectHour: null, //指定整数点
      resetMachineId: "", //需要重新计算的机号
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    //打开指定区域测试网页
    testByAreaId(areaId) {
      this.$http({
        url: "http://192.168.6.254:8000/board/department/idsByAreaId/" + areaId,
        method: "get",
      })
        .then(({ data }) => {
          let list = Array.from(data);
          list.forEach((item) => {
            window.open("http://192.168.6.254:8000/dechang/board/" + item);
          });
        })
        .catch((error) => {
          this.$message({
            type: "error",
            message: "打开失败!",
          });
        });
    },
    //打开指定机号页面指定次数
    testByMachineId() {
      this.$confirm(
        `确认打开机号${this.testMachineId}页面${this.testCount}次？`,
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        }
      )
        .then(() => {
          let url =
            "http://192.168.6.254:8000/dechang/board/" + this.testMachineId;
          for (let index = 0; index < this.testCount; index++) {
            window.open(url);
          }
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消重置",
          });
        });
    },
    //重置所有按钮按下
    open(num) {
      this.$confirm("确认重置?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          let url = "";
          if (num === 1) {
            url = "http://192.168.6.254:8000/board/department/loginResetAll";
          } else if (num === 2) {
            url = "http://192.168.6.254:8000/board/machinehourlydata/reset";
          }
          this.$http({
            url: url,
            method: "get",
          })
            .then(({ data }) => {
              console.log(data);
              if (data) {
                this.$message({
                  type: "success",
                  message: "重置成功!",
                });
              } else {
                this.$message({
                  type: "error",
                  message: "重置失败!",
                });
              }
            })
            .catch(() => {
              this.$message({
                type: "error",
                message: "重置失败!",
              });
            });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消重置",
          });
        });
    },
    //重置指定机号按钮按下
    reset(num) {
      let url = "";
      if (num === 1) {
        url =
          "http://192.168.6.254:8000/board/department/loginReset/" +
          this.loginCountMachineId;
      } else if (num === 2) {
        url =
          "http://192.168.6.254:8000/board/machinehourlydata/reset/" +
          this.hourlyDataMachineId;
      }
      this.$http({
        url: url,
        method: "get",
      })
        .then(({ data }) => {
          if (data) {
            this.$message({
              type: "success",
              message: "重置成功!",
            });
          } else {
            this.$message({
              type: "error",
              message: "重置失败!",
            });
          }
        })
        .catch((error) => {
          this.$message({
            type: "error",
            message: "重置失败!",
          });
        });
    },
    //设置24小时
    hourSet() {
      for (let i = 1; i <= 24; i++) {
        this.hours.push(i);
      }
    },
    //重置指定机台整点数据
    resetHourlyData() {
      this.$http({
        url:
          "http://192.168.7.199:8000/board/machinehourlydata/getAllHourlyData",
        method: "post",
        data: this.$http.adornData(
          { no: this.resetMachineId, hour: this.selectHour },
          false
        ),
      })
        .then(({ data }) => {
          if (data) {
            this.$confirm(
              "整点数据：" +
                data +
                "\r" +
                `确认重置机号${this.resetMachineId}0点到${
                  this.selectHour == null ? "当前整" : this.selectHour
                }点之前的数据？`,
              "提示",
              {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
              }
            )
              .then(() => {
                this.$http({
                  url:
                    "http://192.168.7.199:8000/board/machinehourlydata/resetHourlyData",
                  method: "post",
                  data: this.$http.adornData(
                    { no: this.resetMachineId, hour: this.selectHour },
                    false
                  ),
                })
                  .then(({ data }) => {
                    if (data) {
                      this.$message({
                        type: "success",
                        message: "重置成功!",
                      });
                    } else {
                      this.$message({
                        type: "error",
                        message: "重置失败!",
                      });
                    }
                  })
                  .catch(() => {
                    this.$message({
                      type: "error",
                      message: "重置失败!",
                    });
                  });
              })
              .catch(() => {
                this.$message({
                  type: "info",
                  message: "已取消重置",
                });
              });
          } else {
            this.$message({
              type: "error",
              message: "计算失败，机号有误",
            });
          }
        })
        .catch(() => {
          this.$message({
            type: "error",
            message: "计算失败，机号有误",
          });
        });
    },
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {
    this.hourSet();
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
<style scoped>
/* @import url(); 引入公共css类 */
</style>