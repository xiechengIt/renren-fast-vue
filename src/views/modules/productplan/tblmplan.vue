<template>
  <div class="mod-config">
    <el-form
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
        <el-button type="primary" @click="addOrUpdateHandle()">新增</el-button>
        <el-button
          type="danger"
          @click="deleteHandle()"
          :disabled="dataListSelections.length <= 0"
          >批量删除</el-button
        >
        <!-- v-if="isAuth('productionplan:tblmplan:save')"
        v-if="isAuth('productionplan:tblmplan:delete')" -->
      </el-form-item>
    </el-form>
    <el-table
      :data="dataList"
      border
      v-loading="dataListLoading"
      @selection-change="selectionChangeHandle"
      style="width: 100%"
    >
      <el-table-column
        type="selection"
        header-align="center"
        align="center"
        width="50"
      >
      </el-table-column>
      <el-table-column
        prop="id"
        header-align="center"
        align="center"
        label="id"
      >
      </el-table-column>
      <el-table-column
        prop="billNum"
        header-align="center"
        align="center"
        label="单据编号"
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
        prop="machineId"
        header-align="center"
        align="center"
        label="机号"
      >
      </el-table-column>
      <el-table-column
        prop="code"
        header-align="center"
        align="center"
        label="代码"
      >
      </el-table-column>
      <el-table-column
        prop="planId"
        header-align="center"
        align="center"
        label="生产顺序"
      >
      </el-table-column>
      <el-table-column
        prop="cardId"
        header-align="center"
        align="center"
        label="卡号"
      >
      </el-table-column>
      <el-table-column
        prop="waitingTime"
        header-align="center"
        align="center"
        label="等待时间"
      >
      </el-table-column>
      <el-table-column
        prop="workOrderId"
        header-align="center"
        align="center"
        label="工单号"
      >
      </el-table-column>
      <el-table-column
        prop="billAmount"
        header-align="center"
        align="center"
        label="工单数量"
      >
      </el-table-column>
      <el-table-column
        prop="orderId"
        header-align="center"
        align="center"
        label="订单号"
      >
      </el-table-column>
      <el-table-column
        prop="orderAmount"
        header-align="center"
        align="center"
        label="订单数量"
      >
      </el-table-column>
      <el-table-column
        prop="autoFinish"
        header-align="center"
        align="center"
        label="结案"
      >
      </el-table-column>
      <el-table-column
        prop="productPlanAmount"
        header-align="center"
        align="center"
        label="计划生产数量"
      >
      </el-table-column>
      <el-table-column
        prop="endAmount"
        header-align="center"
        align="center"
        label="实际完成数量"
      >
      </el-table-column>
      <el-table-column
        prop="restAmount"
        header-align="center"
        align="center"
        label="实际剩余数量"
      >
      </el-table-column>
      <el-table-column
        prop="planBeginTime"
        header-align="center"
        align="center"
        label="计划开始日期"
      >
      </el-table-column>
      <el-table-column
        prop="planEndTime"
        header-align="center"
        align="center"
        label="计划结束日期"
      >
      </el-table-column>
      <el-table-column
        prop="beginTime"
        header-align="center"
        align="center"
        label="实际开始日期"
      >
      </el-table-column>
      <el-table-column
        prop="manualFinish"
        header-align="center"
        align="center"
        label="手工结案"
      >
      </el-table-column>
      <el-table-column
        prop="restTime"
        header-align="center"
        align="center"
        label="实际剩余工时"
      >
      </el-table-column>
      <el-table-column
        prop="endTime"
        header-align="center"
        align="center"
        label="实际结束日期"
      >
      </el-table-column>
      <el-table-column
        prop="materialTotalKg"
        header-align="center"
        align="center"
        label="理论材料总量kg"
      >
      </el-table-column>
      <el-table-column
        prop="materialUsedKg"
        header-align="center"
        align="center"
        label="理论材料已用kg"
      >
      </el-table-column>
      <el-table-column
        prop="materialRestKg"
        header-align="center"
        align="center"
        label="理论材料结余kg"
      >
      </el-table-column>
      <el-table-column
        prop="advancedTimeh"
        header-align="center"
        align="center"
        label="产能H"
      >
      </el-table-column>
      <el-table-column
        prop="makeBillTime"
        header-align="center"
        align="center"
        label="制单日期"
      >
      </el-table-column>
      <el-table-column
        prop="symbol"
        header-align="center"
        align="center"
        label="标志"
      >
      </el-table-column>
      <el-table-column
        prop="updateTime"
        header-align="center"
        align="center"
        label="更新时间"
      >
      </el-table-column>
      <el-table-column
        prop="ifProduct"
        header-align="center"
        align="center"
        label="是否生产"
      >
      </el-table-column>
      <el-table-column
        prop="status"
        header-align="center"
        align="center"
        label="状态"
      >
      </el-table-column>
      <el-table-column
        prop="itemName"
        header-align="center"
        align="center"
        label="品名"
      >
      </el-table-column>
      <el-table-column
        prop="model"
        header-align="center"
        align="center"
        label="规格"
      >
      </el-table-column>
      <el-table-column
        prop="warningAmount"
        header-align="center"
        align="center"
        label="警报数量"
      >
      </el-table-column>
      <el-table-column
        fixed="right"
        header-align="center"
        align="center"
        width="150"
        label="操作"
      >
        <template slot-scope="scope">
          <el-button
            type="text"
            size="small"
            @click="addOrUpdateHandle(scope.row.id)"
            >修改</el-button
          >
          <el-button
            type="text"
            size="small"
            @click="deleteHandle(scope.row.id)"
            >删除</el-button
          >
        </template>
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
    <add-or-update
      v-if="addOrUpdateVisible"
      ref="addOrUpdate"
      @refreshDataList="getDataList"
    ></add-or-update>
  </div>
</template>

<script>
import AddOrUpdate from "./tblmplan-add-or-update";
export default {
  data() {
    return {
      dataForm: {
        key: "",
      },
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      addOrUpdateVisible: false,
    };
  },
  components: {
    AddOrUpdate,
  },
  activated() {
    this.getDataList();
  },
  methods: {
    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/productionplan/tblmplan/list"),
        method: "get",
        params: this.$http.adornParams({
          page: this.pageIndex,
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
    // 每页数
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    // 当前页
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
    // 多选
    selectionChangeHandle(val) {
      this.dataListSelections = val;
    },
    // 新增 / 修改
    addOrUpdateHandle(id) {
      this.addOrUpdateVisible = true;
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(id);
      });
    },
    // 删除
    deleteHandle(id) {
      var ids = id
        ? [id]
        : this.dataListSelections.map((item) => {
            return item.id;
          });
      this.$confirm(
        `确定对[id=${ids.join(",")}]进行[${id ? "删除" : "批量删除"}]操作?`,
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        }
      ).then(() => {
        this.$http({
          url: this.$http.adornUrl("/productionplan/tblmplan/delete"),
          method: "post",
          data: this.$http.adornData(ids, false),
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.getDataList();
              },
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
  },
};
</script>
