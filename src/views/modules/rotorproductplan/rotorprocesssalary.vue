<template>
  <div class="mod-config">
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
          @node-click="openPlanByRowData"
        >
        </el-tree
      ></el-col>
      <el-col :span="22">
        <el-form :inline="true">
          <el-form-item>
            <!-- <el-button @click="getDataList()">查询</el-button> -->
            <el-form-item style="margin-left: 10px" label="线段选择">
              <el-select
                style="width: 6rem"
                v-model="rotorTypeValue"
                placeholder="请选择线段"
                @change="getPlanList"
              >
                <el-option key="1" label="A段" value="1"> </el-option>
                <el-option key="2" label="B段" value="2"> </el-option>
              </el-select>
            </el-form-item>

            <el-form-item style="margin-left: 10px" label="日期选择">
              <el-date-picker
                v-model="datePick"
                align="right"
                type="date"
                placeholder="选择日期"
                :picker-options="pickerOptions"
                value-format="yyyy-MM-dd"
                @change="getPlanList"
              >
              </el-date-picker>
            </el-form-item>
          </el-form-item>
        </el-form>

        <el-table
          :data="planList"
          border
          v-loading="planListLoading"
          style="width: 100%"
          size="mini"
          stripe
          height="200"
          @row-click="planClickHandle"
        >
          <el-table-column
            prop="planId"
            header-align="center"
            align="center"
            label="计划id"
            min-width="50px"
          >
          </el-table-column>

          <el-table-column
            prop="lineId"
            header-align="center"
            align="center"
            label="线号"
            min-width="50px"
          >
          </el-table-column>
          <el-table-column
            prop="rotorType"
            header-align="center"
            align="center"
            label="线段"
            min-width="50px"
            :formatter="rotorTypeForma"
          >
          </el-table-column>

          <el-table-column
            prop="productName"
            header-align="center"
            align="center"
            label="品名"
          >
          </el-table-column>
          <el-table-column
            prop="specification"
            header-align="center"
            align="center"
            label="规格"
          >
          </el-table-column>
          <el-table-column
            prop="partNum"
            header-align="center"
            align="center"
            label="料号"
          >
          </el-table-column>
          <el-table-column
            prop="orderNum"
            header-align="center"
            align="center"
            label="订单号"
          >
          </el-table-column>
          <el-table-column
            prop="workNum"
            header-align="center"
            align="center"
            label="工单号"
          >
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            label="工单量"
          >
          </el-table-column>
          <el-table-column
            prop="date"
            header-align="center"
            align="center"
            label="A段结束时间"
            :formatter="dateForma"
            >,
          </el-table-column>
          <el-table-column
            prop="endDate"
            header-align="center"
            align="center"
            label="B段结束时间"
            :formatter="dateForma"
          >
          </el-table-column>
        </el-table>

        <el-pagination
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="pageIndex"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pageSize"
          :total="totalPage"
          layout="total, sizes, prev, pager, next, jumper"
        >
        </el-pagination>
        <!-- 弹窗, 新增 / 修改 -->

        <!-- <el-form
          :inline="true"
          :model="dataForm"
          @keyup.enter.native="getDataList()"
          @submit.native.prevent
        >
          <el-form-item>
            <el-input
              v-model="dataForm.key"
              placeholder="参数名"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item>
            <el-button @click="getDataList()">查询</el-button>
          </el-form-item>
        </el-form> -->
        <el-table
          :data="dataList"
          border
          stripe
          size="mini"
          height="400"
          v-loading="dataListLoading"
          style="width: 100%; margin-top: 1rem"
        >
          <el-table-column
            prop="planId"
            header-align="center"
            align="center"
            label="计划id"
          >
          </el-table-column>
          <el-table-column
            prop="processName"
            header-align="center"
            align="center"
            label="工序名称"
          >
          </el-table-column>
          <el-table-column
            prop="operatorName"
            header-align="center"
            align="center"
            label="操作员姓名"
          >
          </el-table-column>
          <el-table-column
            prop="processUnitPrice"
            header-align="center"
            align="center"
            label="工序产品单价"
          >
          </el-table-column>
          <el-table-column
            prop="processFinishCount"
            header-align="center"
            align="center"
            label="工序完成量"
          >
          </el-table-column>
          <el-table-column
            prop="processSalary"
            header-align="center"
            align="center"
            label="操作员工序薪资"
          >
          </el-table-column>
        </el-table>
        <el-pagination
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="pageIndex"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pageSize"
          :total="totalPage"
          layout="total, sizes, prev, pager, next, jumper"
        >
        </el-pagination>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { dateFormat } from "@/utils/dateUtil";
export default {
  data() {
    return {
      //临时产线id
      tempLineId: 15,
      //线段选择
      rotorTypeValue: 1,
      //计划list
      planList: [],

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

      //机台树
      menus: [],
      defaultProps: {
        children: "children",
        label: "deptName",
      },
      expandedKey: [],
      dataForm: {
        key: "",
      },

      // 工序薪资
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,

      // 计划相关
      planPageIndex: 1,
      planPageSize: 10,
      planTotalPage: 0,
      planListLoading: false,
    };
  },
  components: {},
  mounted() {},
  activated() {
    this.getPlanList();
    this.getMenus();
  },
  methods: {
    //计划点击后查询该计划工序工资结算
    planClickHandle(row) {
      this.getDataList(row);
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
    openPlanByRowData(data) {
      this.tempLineId = data.deptId;
      this.getPlanList();
    },
    // 获取计划数据列表
    getPlanList() {
      this.planListLoading = true;
      this.$http({
        url: this.$http.adornUrl(
          "/rotor/rotorproductplanmanage/listWithoutInit"
        ),
        method: "get",
        params: this.$http.adornParams({
          page: this.planPageIndex,
          limit: this.planPageSize,
          deptId: this.tempLineId,
          rotorType: this.rotorTypeValue,
          date: this.datePick,
        }),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.planList = data.page.list;
          this.planTotalPage = data.page.totalCount;
        } else {
          this.planList = [];
          this.planTotalPage = 0;
        }
        this.planListLoading = false;
      });
    },
    // 获取薪资数据列表
    getDataList(row) {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/rotor/rotorprocesssalary/list"),
        method: "get",
        params: this.$http.adornParams({
          partNum: row.partNum,
          planId: row.planId,
          page: this.pageIndex,
          rotorType: this.rotorTypeValue,
          limit: this.pageSize,
          key: this.dataForm.key,
        }),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.page.list;
          this.totalPage = data.page.totalCount;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },
    //表格内线段格式化
    rotorTypeForma(row, column, cellValue, index) {
      const rotorTypeValue = row[column.property];
      return rotorTypeValue == 1 ? "A段" : "B段";
    },
    //表格内时间格式化
    dateForma(row, column, cellValue, index) {
      const date = row[column.property];
      if (date) {
        const list = date.split(" ");

        return list[1];
      }
    },
    // plan每页数
    planSizeChangeHandle(val) {
      this.planPageSize = val;
      this.planPageIndex = 1;
      this.getPlanList();
    },
    // plan当前页
    planCurrentChangeHandle(val) {
      this.planPageIndex = val;
      this.getPlanList();
    },
    // 薪资每页数
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    // 薪资当前页
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
  },
};
</script>
