<!--  -->
<template>
  <div class="">
    <el-row :gutter="20">
      <el-col :span="2">
        <el-tree
          :data="menus"
          :props="defaultProps"
          :expand-on-click-node="false"
          :default-expanded-keys="expandedKey"
          node-key="deptId"
          default-expand-all
          ref="menuTree"
          @node-click="openPlan"
        >
        </el-tree
      ></el-col>
      <el-col :span="22">
        <div>
          <span style="margin: 0rem 1rem 0rem 2rem">时间选择</span>
          <el-date-picker
            v-model="datePick"
            type="date"
            align="right"
            unlink-panels
            placeholder="选择日期"
            :picker-options="pickerOptions"
            value-format="yyyy-MM-dd"
            @change="changeDate"
          >
          </el-date-picker>
          <span style="margin: 0rem 1rem 0rem 2rem">计划选择</span>
          <el-select
            style="width: 20rem"
            v-model="planId"
            filterable
            placeholder="请选择"
            @change="getProcesses"
            ><el-option
              v-for="(item, index) in planInfoList"
              :key="'planInfo' + index"
              :label="item.planId"
              :value="item.planId"
            >
              <span style="float: left">{{ item.planId }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px">
                品名：{{
                  item.productName == null ? "无 " : item.productName
                }}
                规格：{{
                  item.specification == null ? "无 " : item.specification
                }}
                料号：{{ item.partNum == null ? "无 " : item.partNum }}
              </span>
              <!--  品名：{{ item.productName == null ? "无" : item.productName }}

                规格：{{
                  item.specification == null ? "无" : item.specification
                }}

                料号：{{
                  item.partNum == null ? "无" : item.partNum
                }}
                订单号：{{ item.orderNum == null ? "无" : item.orderNum }}

                工单号：{{ item.workNum == null ? "无" : item.workNum }} -->
            </el-option>
          </el-select>
          <span style="margin: 0rem 1rem 0rem 2rem">工序选择</span>
          <el-select
            style="width: 20rem"
            v-model="processId"
            filterable
            placeholder="请选择"
            @change="getBadItemReasons"
            ><el-option
              v-for="(item, index) in processList"
              :key="'process' + index"
              :label="
                ' 工序' +
                (index + 1) +
                '：' +
                item.processName +
                ' 不良品数量：' +
                item.badItemCount
              "
              :value="item.id"
            >
            </el-option>
          </el-select>
        </div>
        <!-- 不良品原因 -->
        <div style="margin-top: 1rem">
          <div
            style="
              border: 1px solid #d7dae2;
              width: 10rem;
              height: 6rem;
              line-height: 1rem;
              text-align: center;
              border-radius: 30px;
              margin: 1rem;
              float: left;
            "
            v-for="(item, index) in badItemReasons"
            :key="'badItem' + index"
          >
            <h3>{{ item.badItemReason }}</h3>
            <el-input-number
              v-model="item.badItemCount"
              @change="handleChange(item)"
              :min="0"
              :max="100"
              size="mini"
            ></el-input-number>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import { dateFormat } from "@/utils/dateUtil";
import Cookie from "js-cookie";
export default {
  //import引入的组件需要注入到对象中才能使用
  components: {},
  data() {
    //这里存放数据
    return {
      //操作人
      operator: "",
      //机台树
      menus: [],
      defaultProps: {
        children: "children",
        label: "deptName",
      },
      expandedKey: [],

      //临时产线id
      tempLineId: 15,

      //不良品原因
      badItemReasons: [],

      //计划信息list
      planInfoList: [],
      //计划信息内用于请求不良品数据planId
      planId: null,

      //工序list
      processList: [],
      //工序id
      processId: null,

      //时间选择器
      datePick: dateFormat("yyyy-MM-dd", new Date()),
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
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    //根据planId获取工序list
    getProcesses() {
      this.processId = null;
      this.processList = [];

      this.badItemReasons = [];

      this.$http({
        url: this.$http.adornUrl("/rotor/rotorboarddata/" + this.planId),
        method: "get",
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: "工序获取成功",
            type: "success",
            duration: 1500,
          });
          this.processList = data.rotorDataList;
        } else {
          this.$message.error(data.msg);
        }
      });
    },

    //更改时间后，查询选择框对应时间计划，重置计划工序选择，重置不良品选择
    changeDate() {
      this.processList = [];
      this.processId = null;

      this.badItemReasons = [];

      this.getPlanList();
    },

    //获取当前操作人
    showUserName() {
      this.operator = Cookie.get("username");
    },

    //根据lineId、planId获取该计划的不良品原因记录
    getBadItemReasons() {
      this.$http({
        url: this.$http.adornUrl("/rotor/rotorbaditemrecord/info"),
        method: "get",
        params: this.$http.adornParams({
          lineId: this.tempLineId,
          planId: this.planId,
          date: this.datePick,
        }),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: "工序切换成功",
            type: "success",
            duration: 1500,
          });
          this.badItemReasons = data.badItemReasons;
        } else {
          this.$message.error(data.msg);
        }
      });
    },

    //获取机台数
    getMenus() {
      this.$http({
        url: this.$http.adornUrl("/rotor/tbldepartment/level1list"),
        method: "get",
      }).then(({ data }) => {
        //console.log("成功获取到菜单数据...", data.data);
        this.menus = data.data;
      });
    },
    //根据点击的转子线获取计划
    openPlan(data) {
      this.tempLineId = data.deptId;
      this.processList = [];
      this.processId = null;

      this.badItemReasons = [];
      this.planInfoList = [];
      this.planId = null;

      this.getPlanList();
    },

    // 获取计划列表
    getPlanList() {
      this.$http({
        url: this.$http.adornUrl("/rotor/rotorproductplanmanage/info"),
        method: "get",
        params: this.$http.adornParams({
          lineId: this.tempLineId,
          date: this.datePick,
        }),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: "计划获取成功",
            type: "success",
            duration: 1500,
          });
          this.planInfoList = data.planInfoList;
        } else {
          this.$message.error(data.msg);
        }
      });
    },

    //计数增加或者减少时
    handleChange(item) {
      item.updateTime = dateFormat("yyyy-MM-dd HH:mm:ss", new Date());
      item.createTime = null;
      item.operator = this.operator;
      let date = {
        rotorBadItemRecordEntity: item,
        rotorBoardDataEntity: {
          id: this.processId,
          badItemCount: item.badItemCount,
        },
      };
      this.$http({
        url: this.$http.adornUrl("/rotor/rotorbaditemrecord/update"),
        method: "post",
        data: date,
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: "操作成功",
            type: "success",
            duration: 500,
          });
        } else {
          this.$message.error(data.msg);
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
    this.getMenus();
    this.showUserName();
    this.getPlanList();
  }, //如果页面有keep-alive缓存功能，这个函数会触发
};
</script>
<style scoped>
/*@@import url(); 引入公共css类*/
.focus {
  color: #3af2ff;
}
</style>