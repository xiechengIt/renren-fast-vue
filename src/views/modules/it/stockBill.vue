<template>
  <div class="mod-config">
    <el-form
      :inline="true"
      :model="dataForm"
      @keyup.enter.native="getDataList()"
    >
      <el-form-item>
        <el-date-picker
          v-model="pickerDate"
          type="datetimerange"
          :picker-options="pickerOptions"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          align="right"
        >
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="dataForm.key"
          placeholder="参数名"
          clearable
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <!-- <el-button type="primary" @click="addOrUpdateHandle()">新增</el-button> -->
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
        prop="no"
        header-align="center"
        align="center"
        label="单号"
      >
      </el-table-column>
      <el-table-column
        prop="date"
        header-align="center"
        align="center"
        label="领料日期"
        min-width="100px"
      >
      </el-table-column>
      <el-table-column
        prop="name"
        header-align="center"
        align="center"
        label="材料名称"
        min-width="100px"
      >
      </el-table-column>
      <el-table-column
        prop="model"
        header-align="center"
        align="center"
        label="型号"
      >
      </el-table-column>
      <!-- <el-table-column
        prop="unit"
        header-align="center"
        align="center"
        label="单位"
      >
      </el-table-column> -->
      <el-table-column
        prop="amount"
        header-align="center"
        align="center"
        label="总数"
      >
      </el-table-column>
      <!-- <el-table-column
        prop="price"
        header-align="center"
        align="center"
        label="单价"
      >
      </el-table-column> -->
      <el-table-column
        prop="totalPrice"
        header-align="center"
        align="center"
        label="总价"
      >
      </el-table-column>
      <el-table-column
        prop="comment"
        header-align="center"
        align="center"
        label="备注"
      >
      </el-table-column>
      <el-table-column
        prop="department"
        header-align="center"
        align="center"
        label="领料部门"
      >
      </el-table-column>
      <el-table-column
        prop="departmentLeader"
        header-align="center"
        align="center"
        label="领料部门负责人"
      >
      </el-table-column>
      <el-table-column
        prop="departmentMember"
        header-align="center"
        align="center"
        label="领料人"
      >
      </el-table-column>
      <el-table-column
        prop="photo"
        header-align="center"
        align="center"
        label="领料人照片"
      >
        <template slot-scope="scope">
          <el-button
            circle
            type="info"
            icon="el-icon-search"
            @click="getPhoto(scope.row.photo)"
          >
          </el-button>
        </template>
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
            @click="getDetailHandle(scope.row.id)"
            >详情</el-button
          >
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
    <!-- 详情 -->
    <get-detail
      v-if="getDetailVisible"
      ref="getDetail"
      @refreshDataList="getDataList"
    ></get-detail>
    <!-- 领料人图片 -->
    <el-dialog :visible.sync="getPhotoVisible" width="30%">
      <img width="100%" :src="photoUrl" />
    </el-dialog>
  </div>
</template>

<script>
import AddOrUpdate from "./stockBill-add-or-update";
import GetDetail from "./stockBill-get-detail";

export default {
  data() {
    return {
      dataForm: {
        key: null,
      },
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      addOrUpdateVisible: false,
      getDetailVisible: false,
      getPhotoVisible: false,
      photoUrl: "",
      //时间快速选择
      pickerDate: [],
      pickerOptions: {
        shortcuts: [
          {
            text: "最近一周",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit("pick", [start, end]);
            },
          },
          {
            text: "最近一个月",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
              picker.$emit("pick", [start, end]);
            },
          },
          {
            text: "最近三个月",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
              picker.$emit("pick", [start, end]);
            },
          },
        ],
      },
    };
  },
  components: {
    AddOrUpdate,
    GetDetail,
  },
  activated() {
    this.getDataList();
  },
  methods: {
    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      let key = this.dataForm.key;
      if (key != null) {
        key += "";
      }
      let pageIndex = this.pageIndex;
      if (pageIndex != null) {
        pageIndex += "";
      }
      let pageSize = this.pageSize;
      if (pageSize != null) {
        pageSize += "";
      }
      this.$http({
        url: this.$http.adornUrl("/it/stockBill/list"),
        method: "post",
        data: this.$http.adornData({
          page: pageIndex,
          limit: pageSize,
          key: key,
          pickerDate: this.pickerDate,
        }),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          let allList = data.page.list;
          allList.forEach((element, index) => {
            //如果材料name有多个值，则取出第一个值，再在后面加上...
            let names = this.doSplit(element.name);
            element.name = names;
            let models = this.doSplit(element.model);
            element.model = models;

            //将数量和单价通过","拆分后计算总数和总价
            let total = this.doPlus(element.amount);
            element.amount = total;
            let total2 = this.doPlus(element.totalPrice);
            element.totalPrice = total2;
          });
          this.dataList = allList;
          this.totalPage = data.page.totalCount;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },

    //分割然后替代原参数方法
    doSplit(str) {
      let strs = str.split(",");
      if (strs.length > 1) {
        str = strs[0];
        return (str += "....");
      }
      return str;
    },

    //将数组的所有字符串转为数字，然后再相加
    doPlus(list) {
      if (list && list.length > 0) {
        let total = 0;
        let list2 = list.split(",");
        list2.forEach((item) => {
          let num = parseInt(item);
          total += num;
        });
        return total;
      }
      return "";
    },

    //获取当前照片
    getPhoto(photo) {
      if (photo == null) {
        this.$message.error("领料人暂无照片");
      } else this.getPhotoVisible = true;
      this.photoUrl = photo;
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
    //
    getDetailHandle(id) {
      this.getDetailVisible = true;
      this.$nextTick(() => {
        this.$refs.getDetail.init(id);
      });
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
          url: this.$http.adornUrl("/it/stockBill/delete"),
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
