<template>
  <div class="mod-config">
    <el-row :gutter="10">
      <el-col :span="3">
        <!-- 机台树 -->

        <el-tree
          :data="menus"
          :props="defaultProps"
          :expand-on-click-node="false"
          node-key="deptid"
          :default-expanded-keys="expandedKey"
          ref="menuTree"
          @node-click="openStatus"
        >
        </el-tree
      ></el-col>
      <el-col :span="21">
        <el-form
          :inline="true"
          :model="dataForm"
          @keyup.enter.native="getDataList()"
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
            <el-button type="primary" @click="addOrUpdateHandle()"
              >新增</el-button
            >
            <el-button
              type="danger"
              @click="deleteHandle()"
              :disabled="dataListSelections.length <= 0"
              >批量删除</el-button
            >
            <!-- v-if="isAuth('productionplan:qucarddata:save')"
        v-if="isAuth('productionplan:qucarddata:delete')" -->
          </el-form-item>
        </el-form>
        <el-table
          :data="dataList"
          border
          v-loading="dataListLoading"
          @selection-change="selectionChangeHandle"
          style="width: 100%"
          stripe
          size="mini"
          height="650"
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
            prop="receiptTime"
            header-align="center"
            align="center"
            label="接收时间"
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
            prop="ip"
            header-align="center"
            align="center"
            label="IP地址"
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
            prop="need"
            header-align="center"
            align="center"
            label="是否需要"
          >
          </el-table-column>
          <el-table-column
            prop="planId"
            header-align="center"
            align="center"
            label="计划ID"
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
            prop="itemName"
            header-align="center"
            align="center"
            label="品名"
          >
          </el-table-column>
          <el-table-column
            prop="specifications"
            header-align="center"
            align="center"
            label="规格型号"
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
            prop="productPlanAmount"
            header-align="center"
            align="center"
            label="计划生产数量"
          >
          </el-table-column>
          <el-table-column
            prop="intervalSecond"
            header-align="center"
            align="center"
            label="间隔秒"
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
            prop="endAmount"
            header-align="center"
            align="center"
            label="实际完成数量"
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
            prop="restAmount"
            header-align="center"
            align="center"
            label="实际剩余数量"
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
            prop="slotCount"
            header-align="center"
            align="center"
            label="穴数"
          >
          </el-table-column>
          <el-table-column
            prop="remark"
            header-align="center"
            align="center"
            label="备注"
          >
          </el-table-column>
          <el-table-column
            prop="deptname"
            header-align="center"
            align="center"
            label="机名"
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
      </el-col>
    </el-row>
  </div>
</template>

<script>
import AddOrUpdate from "./qucarddata-add-or-update";
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
    this.getMenus();
  },
  methods: {
    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/productionplan/qucarddata/list"),
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
    //获取数据列表
    getMenus() {
      this.$http({
        url: this.$http.adornUrl("/productionplan/department/list/tree"),
        method: "get",
      }).then(({ data }) => {
        //console.log("成功获取到菜单数据...", data.data);
        this.menus = data.data;
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
          url: this.$http.adornUrl("/productionplan/qucarddata/delete"),
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
