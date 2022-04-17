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
      <el-col :span="22"
        ><el-form
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
            <el-button @click="getDataList">查询</el-button>
            <el-button type="primary" @click="upload()">提交</el-button>
            <el-form-item style="margin-left: 10px" label="线段选择">
              <el-select
                style="width: 6rem"
                v-model="rotorTypeValue"
                placeholder="请选择线段"
                @change="getDataList"
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
                @change="getDataList"
              >
              </el-date-picker>
            </el-form-item>
            <el-form-item
              ><upload-excel
                :on-success="handleSuccess"
                :before-upload="beforeUpload"
            /></el-form-item>

            <!-- <el-button type="primary" @click="addOrUpdateHandle()"
              >新增</el-button
            >

            <el-button
              type="danger"
              @click="deleteHandle()"
              :disabled="dataListSelections.length <= 0"
              >批量删除</el-button
            > -->
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
            prop="planId"
            header-align="center"
            align="center"
            label="计划id"
            min-width="58px"
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
          >
          </el-table-column>
          <el-table-column
            prop="date"
            header-align="center"
            align="center"
            label="开始时间"
            min-width="140px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">{{ scope.row.date }}</div>
              <div v-else>
                <el-date-picker
                  v-model="scope.row.date"
                  align="right"
                  type="datetime"
                  placeholder="选择日期"
                  :picker-options="pickerOptions"
                  format="HH:mm:ss"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  style="width: 120px"
                >
                </el-date-picker>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="endDate"
            header-align="center"
            align="center"
            label="结束时间"
            min-width="140px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">{{ scope.row.endDate }}</div>
              <div v-else>
                <el-date-picker
                  v-model="scope.row.endDate"
                  align="right"
                  type="datetime"
                  placeholder="选择日期"
                  :picker-options="pickerOptions"
                  format="HH:mm:ss"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  style="width: 120px"
                >
                </el-date-picker>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="partNum"
            header-align="center"
            align="center"
            label="料号"
            min-width="170px"
          >
            <template slot-scope="scope">
              <div v-if="scope.row.isEdit">{{ scope.row.partNum }}</div>
              <div v-else>
                <el-input v-model="scope.row.partNum"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productName"
            header-align="center"
            align="center"
            label="品名"
            min-width="170px"
          >
            <template slot-scope="scope">
              <div v-if="scope.row.isEdit">{{ scope.row.productName }}</div>
              <div v-else>
                <el-input v-model="scope.row.productName"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="specification"
            header-align="center"
            align="center"
            label="规格"
            min-width="170px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">{{ scope.row.specification }}</div>
              <div v-else>
                <el-input v-model="scope.row.specification"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="orderNum"
            header-align="center"
            align="center"
            label="订单号"
            min-width="170px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">{{ scope.row.orderNum }}</div>
              <div v-else>
                <el-input v-model="scope.row.orderNum"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="workNum"
            header-align="center"
            align="center"
            label="工单号"
            min-width="170px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">{{ scope.row.workNum }}</div>
              <div v-else>
                <el-input v-model="scope.row.workNum"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            label="工单量"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount }}
              </div>
              <div v-else>
                <el-input
                  v-model="scope.row.productPlanAmount"
                  @change="productPlanAmountChange(scope.row)"
                ></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[0]"
            v-if="this.processNames[0]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount1 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount1"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[1]"
            v-if="this.processNames[1]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount2 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount2"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[2]"
            v-if="this.processNames[2]"
            min-width="100px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount3 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount3"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[3]"
            v-if="this.processNames[3]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount4 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount4"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[4]"
            v-if="this.processNames[4]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount5 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount5"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[5]"
            v-if="this.processNames[5]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount6 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount6"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[6]"
            v-if="this.processNames[6]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount7 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount7"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[7]"
            v-if="this.processNames[7]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount8 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount8"></el-input>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            :label="this.processNames[8]"
            v-if="this.processNames[8]"
            min-width="110px"
            ><template slot-scope="scope">
              <div v-if="scope.row.isEdit">
                {{ scope.row.productPlanAmount9 }}
              </div>
              <div v-else>
                <el-input v-model="scope.row.productPlanAmount9"></el-input>
              </div>
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
              <el-button @click="handleClick(scope.row)">{{
                !scope.row.isEdit ? "完成" : "编辑"
              }}</el-button>
            </template>
            <!-- <template slot-scope="scope">
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
            </template> -->
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
import uploadExcel from "@/components/uploadExcel";
import { dateFormat } from "@/utils/dateUtil";
import AddOrUpdate from "./rotorproductplanmanage-add-or-update";
export default {
  components: { uploadExcel, AddOrUpdate },
  data() {
    return {
      //工序名称list
      processNames: [
        "工序一",
        "工序二",
        "工序三",
        "工序四",
        "工序五",
        "工序六",
        "工序七",
        "工序八",
        "工序九",
      ],

      //临时lineId
      tempLineId: "",

      //线段选择
      rotorTypeValue: 1,

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
      dataList: [],
      pageIndex: 1,
      pageSize: 50,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      addOrUpdateVisible: false,

      //计划编写提交
      ruleForm: {
        productName: "",
        specification: "",
        partNum: "",
        productPlanAmount: "",
        lineId: "",
        orderNum: "",
        workNum: "",
      },
      rules: {
        lineId: [
          { required: true, message: "请选择产线id", trigger: "change" },
        ],
        productName: [
          { required: true, message: "请输入品名", trigger: "blur" },
          ,
        ],
        specification: [
          { required: true, message: "请输入规格", trigger: "blur" },
          ,
        ],
        partNum: [
          { required: true, message: "请输入料号", trigger: "blur" },
          ,
        ],
        productPlanAmount: [
          { required: true, message: "请输入生产计划量", trigger: "blur" },
          ,
        ],
        orderNum: [
          { required: true, message: "请输入订单号", trigger: "blur" },
          ,
        ],
        workNum: [
          { required: true, message: "请输入工单号", trigger: "blur" },
          ,
        ],
      },
      options: [],
    };
  },
  activated() {
    this.getMenus();
  },
  methods: {
    beforeUpload(file) {
      const isLt1M = file.size / 1024 / 1024 < 1;

      if (isLt1M) {
        return true;
      }

      this.$message({
        message: "Please do not upload files larger than 1m in size.",
        type: "warning",
      });
      return false;
    },
    handleSuccess({ header, results }) {
      console.log(header, results);
      this.tableData = results;
      this.tableHeader = header;
    },
    //更改工序计划量时，同时更改工序计划量
    productPlanAmountChange(row) {
      console.log(row);
      let productPlanAmount = row.productPlanAmount;
      row.productPlanAmount1 = productPlanAmount;
      row.productPlanAmount2 = productPlanAmount;
      row.productPlanAmount3 = productPlanAmount;
      row.productPlanAmount4 = productPlanAmount;
      row.productPlanAmount5 = productPlanAmount;
      row.productPlanAmount6 = productPlanAmount;
      row.productPlanAmount7 = productPlanAmount;
      row.productPlanAmount8 = productPlanAmount;
      row.productPlanAmount9 = productPlanAmount;
    },
    //获取工序名称list
    getProcessNames() {
      this.$http({
        url: this.$http.adornUrl("/rotor/tbldepartment/getProcessNames"),
        method: "get",
        params: this.$http.adornParams({
          lineId: this.tempLineId,
          rotorType: this.rotorTypeValue,
        }),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.processNames = data.processNames;
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    // 动态设置数据并通过这个数据判断显示方式,如果是完成则提交更新计划
    handleClick(row) {
      if (row.isEdit) {
        this.$delete(row, "isEdit");
      } else {
        this.$set(row, "isEdit", true);
        console.log(row);
        this.$http({
          url: this.$http.adornUrl("/rotor/rotorproductplanmanage/update"),
          method: "post",
          data: this.$http.adornData(row, false),
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      }
    },
    handle(row, column, cell, event) {},
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

    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/rotor/rotorproductplanmanage/list"),
        method: "get",
        params: this.$http.adornParams({
          page: this.pageIndex,
          limit: this.pageSize,
          key: this.dataForm.key,
          deptId: this.tempLineId,
          rotorType: this.rotorTypeValue,
          date: this.datePick,
        }),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          if (data.page.list[0].planId == null) {
            this.getDataList();
            return;
          }
          this.dataList = data.page.list;
          this.totalPage = data.page.totalCount;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
      });
      this.getProcessNames();
      this.dataListLoading = false;
    },
    //根据点击的转子线获取计划
    openPlanByRowData(data) {
      this.tempLineId = data.deptId;
      this.getDataList();
    },
    //提交编辑好的计划数据
    upload() {
      let url =
        "http://localhost:9500/tableRotorline/?lineId=" + this.tempLineId;
      if (process.env.NODE_ENV == "production") {
        url =
          "http://36.137.115.125:9500/tableRotorline/?lineId=" +
          this.tempLineId;
      }

      window.open(url);
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
          url: this.$http.adornUrl("/rotor/productplanmanage/delete"),
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

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$http({
            url: this.$http.adornUrl("/rotor/rotorproductplanmanage/save"),
            method: "post",
            data: this.$http.adornData({
              lineId: this.ruleForm.lineId,
              productName: this.ruleForm.productName,
              specification: this.ruleForm.specification,
              partNum: this.ruleForm.partNum,
              productPlanAmount: this.ruleForm.productPlanAmount,
              orderNum: this.ruleForm.orderNum,
              workNum: this.ruleForm.workNum,
              date: "",
            }),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              let url =
                "http://192.168.1.50:9500/?lineId=" + this.ruleForm.lineId;
              window.open(url);
            } else {
              this.$message.error(data.msg);
            }
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    getLineIds() {
      this.$http({
        url: this.$http.adornUrl("/rotor/tbldepartment/getLineIds"),
        method: "get",
      }).then(({ data }) => {
        console.log(data);
        if (data && data.code === 0) {
          this.options = data.lineIds;
        }
      });
    },
  },
};
</script>
