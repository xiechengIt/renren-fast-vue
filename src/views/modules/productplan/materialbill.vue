<template>
  <div class="mod-config">
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
        <el-button type="primary" @click="addOrUpdateHandle()">新增</el-button>
        <el-button @click="setExport2Excel" type="primary" class="button"
          >导出</el-button
        ><el-button
          type="danger"
          @click="deleteHandle()"
          :disabled="dataListSelections.length <= 0"
          >批量删除</el-button
        >
        <!-- v-if="isAuth('productionplan:materialBill:save')"
        v-if="isAuth('productionplan:materialBill:delete')" -->
      </el-form-item>
    </el-form>
    <el-table
      :data="dataList"
      border
      v-loading="dataListLoading"
      @selection-change="selectionChangeHandle"
      height="650"
      style="width: 100%"
      stripe
      size="mini"
      id="table"
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
        min-width="60"
      >
      </el-table-column>
      <el-table-column
        prop="date"
        header-align="center"
        align="center"
        label="日期"
        min-width="100"
      >
      </el-table-column>
      <el-table-column
        prop="planNum"
        header-align="center"
        align="center"
        label="计划号"
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
        prop="machineName"
        header-align="center"
        align="center"
        label="机名"
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
        prop="subMaterialCode"
        header-align="center"
        align="center"
        label="子项物料代码"
      >
      </el-table-column>
      <el-table-column
        prop="materialName"
        header-align="center"
        align="center"
        label="物料名称"
      >
      </el-table-column>
      <el-table-column
        prop="model"
        header-align="center"
        align="center"
        label="规格型号"
        width="100"
        :show-overflow-tooltip="true"
      >
      </el-table-column>
      <el-table-column
        prop="unit"
        header-align="center"
        align="center"
        label="单位"
      >
      </el-table-column>
      <el-table-column
        prop="used"
        header-align="center"
        align="center"
        label="用量"
      >
      </el-table-column>
      <el-table-column
        prop="amount"
        header-align="center"
        align="center"
        label="数量"
      >
      </el-table-column>
      <el-table-column
        prop="total"
        header-align="center"
        align="center"
        label="合计"
      >
      </el-table-column>
      <el-table-column
        prop="warehouse"
        header-align="center"
        align="center"
        label="仓库"
      >
      </el-table-column>
      <el-table-column
        prop="combineNum"
        header-align="center"
        align="center"
        label="组合号"
        width="150"
        :show-overflow-tooltip="true"
      >
      </el-table-column>
      <el-table-column
        prop="orderNum"
        header-align="center"
        align="center"
        label="订单号"
        width="150"
        :show-overflow-tooltip="true"
      >
      </el-table-column>
      <el-table-column
        prop="calculateLabeled"
        header-align="center"
        align="center"
        label="计算标示"
      >
      </el-table-column>
      <el-table-column
        prop="successNum"
        header-align="center"
        align="center"
        label="成功数量"
      >
      </el-table-column>
      <el-table-column
        prop="notImportNum"
        header-align="center"
        align="center"
        label="未导入数量"
      >
      </el-table-column>
      <el-table-column
        prop="reasonAnalysis"
        header-align="center"
        align="center"
        label="原因分析"
        width="150"
        :show-overflow-tooltip="true"
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
        prop="workRestNum"
        header-align="center"
        align="center"
        label="工单余量"
      >
      </el-table-column>
      <el-table-column
        prop="materialType"
        header-align="center"
        align="center"
        label="领料类别"
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
import FileSaver from "file-saver";
import XLSX2 from "xlsx";
import AddOrUpdate from "./materialBill-add-or-update";
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
    // 导出excel表格
    setExport2Excel() {
      // 设置当前日期
      let time = new Date();
      let year = time.getFullYear();
      let month = time.getMonth() + 1;
      let day = time.getDate();
      let name = year + "" + month + "" + day;
      // console.log(name)
      // .table要导出的是哪一个表格
      var wb = XLSX2.utils.table_to_book(document.querySelector("#table"));
      var wbout = XLSX2.write(wb, {
        bookType: "xlsx",
        bookSST: true,
        type: "array",
      });
      try {
        // name+'.xlsx'表示导出的excel表格名字
        FileSaver.saveAs(
          new Blob([wbout], { type: "application/octet-stream" }),
          name + ".xlsx"
        );
      } catch (e) {
        if (typeof console !== "undefined") console.log(e, wbout);
      }
      return wbout;
    },

    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/productionplan/materialBill/list"),
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
          url: this.$http.adornUrl("/productionplan/materialBill/delete"),
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

<style>
el-table-column {
  white-space: nowrap;
}
</style>