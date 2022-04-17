<template>
  <div class="mod-config">
    <el-row :gutter="20">
      <el-col :span="2">
        <!-- 机台树 -->
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
        <el-form
          :inline="true"
          :model="dataForm"
          @keyup.enter.native="getDataList()"
          @submit.native.prevent
          @cell-dblclick="handle"
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
          </el-form-item>
        </el-form>
        <el-table
          :data="dataList"
          border
          v-loading="dataListLoading"
          @selection-change="selectionChangeHandle"
          style="width: 100%"
          size="mini"
          stripe
        >
          <el-table-column
            prop="id"
            header-align="center"
            align="center"
            label="id"
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
            label="点位id"
          >
          </el-table-column>
          <el-table-column
            prop="lineId"
            header-align="center"
            align="center"
            label="线别"
          >
          </el-table-column>
          <el-table-column
            prop="planId"
            header-align="center"
            align="center"
            label="计划id"
          >
          </el-table-column>
          <el-table-column
            prop="dataA"
            header-align="center"
            align="center"
            label="投入量"
          >
          </el-table-column>
          <el-table-column
            prop="dataB"
            header-align="center"
            align="center"
            label="产出量"
          >
          </el-table-column>
          <el-table-column
            prop="dataC"
            header-align="center"
            align="center"
            label="待传递"
          >
          </el-table-column>
          <el-table-column
            prop="dataCount"
            header-align="center"
            align="center"
            label="数据采集量"
          >
          </el-table-column>
          <el-table-column
            prop="planCount"
            header-align="center"
            align="center"
            label="计划产量"
          >
          </el-table-column>
          <el-table-column
            prop="date"
            header-align="center"
            align="center"
            label="更新时间"
          >
          </el-table-column>
          <el-table-column
            prop="rotorType"
            header-align="center"
            align="center"
            label="转子段"
          >
          </el-table-column>
          <el-table-column
            prop="badItemCount"
            header-align="center"
            align="center"
            label="不良品数量"
          >
          </el-table-column>
          <el-table-column
            prop="productYield"
            header-align="center"
            align="center"
            label="完成率"
          >
          </el-table-column>
          <el-table-column
            prop="finish"
            header-align="center"
            align="center"
            label="结案"
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
import AddOrUpdate from "./rotorboarddata-add-or-update";
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

      menus:[0] //机台数
    };
  },
  components: {
    AddOrUpdate,
  },
  activated() {
    this.getDataList();this.getMenus();
  },
  methods: {
    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/rotor/rotorboarddata/list"),
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
        url: this.$http.adornUrl("/rotor/tbldepartment/list/tree"),
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
          url: this.$http.adornUrl("/rotor/rotorboarddata/delete"),
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
