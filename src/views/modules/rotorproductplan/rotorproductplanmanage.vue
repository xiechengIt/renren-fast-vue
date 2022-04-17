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
        >
          <!-- <el-form-item>
            <el-input
              v-model="dataForm.key"
              placeholder="参数名"
              clearable
            ></el-input>
          </el-form-item> -->
          <div style="font-size: 20px; font-weight: 400; text-align: center">
            <h3>
              转子车间{{ tempLineId }}线生产日报
              <span style="font-size: 18px; font-weight: 250; float: right">
                日期：{{ datePick }} 表单编号：{{ id.padStart(6, "0") }}</span
              >
            </h3>
          </div>
          <el-form-item>
            <!-- <el-button @click="getDataList()">查询</el-button> -->
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
          height="145"
          row-click="planClickHandle"
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
          <!--  <el-table-column
            fixed="right"
            header-align="center"
            align="center"
            width="150"
            label="操作"
          >
            <template slot-scope="scope">
              <el-button type="text" size="small" @click="getDetail(scope.row)"
                >详情</el-button
              >
            </template>
          </el-table-column> -->
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
        <detail
          v-if="detailVisible"
          ref="detail"
          @refreshDataList="getDataList"
        ></detail>

        <el-row>
          <el-col :span="12">
            <div v-show="humanConfirmationShow">
              <h2 class="confirmTitle">人力分配</h2>
              <el-form
                :inline="true"
                :rules="humanConfirmRules"
                ref="humanConfirmForm"
              >
                <el-form-item
                  v-for="(processInfo, index) in processNames"
                  :key="processInfo.machineId + index"
                  :label="processInfo.processName"
                  label-width="auto"
                  label-position="right"
                  prop="humanConfirm"
                >
                  <el-select
                    v-model="processInfo.operatorName"
                    multiple
                    placeholder="请选择"
                  >
                    <el-option
                      v-for="item in operatorInfo"
                      :key="item.emId"
                      :label="item.emName"
                      :value="item.emId"
                    >
                    </el-option>
                  </el-select>
                </el-form-item>
              </el-form>
              <el-form>
                <el-form-item>
                  <el-button
                    type="primary"
                    @click="humanConfirmationShowChange(false)"
                    >确认分配</el-button
                  >
                </el-form-item></el-form
              >
            </div>
            <div v-show="!humanConfirmationShow">
              <h2 class="confirmTitle">开工确认</h2>
              <el-form
                label-width="70px"
                :inline="true"
                :model="formInline"
                class="demo-form-inline"
              >
                <el-form-item label="计划人力">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.beginScheduleResource"
                    placeholder="计划人力"
                  ></el-input>
                </el-form-item>
                <el-form-item label="实到人力">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.beginTrueResource"
                    placeholder="实到人力"
                  ></el-input>
                </el-form-item>
                <el-form-item label="设备点检">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.equipmentLocating"
                    placeholder="设备点检"
                  ></el-input>
                </el-form-item>
              </el-form>

              <el-form
                label-width="70px"
                :inline="true"
                :model="formInline"
                class="demo-form-inline"
              >
                <el-form-item label="工单发料">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.planIssuanceOfMaterials"
                    placeholder="工单发料"
                  ></el-input>
                </el-form-item>
                <el-form-item label="实际发料">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.trueIssuanceOfMaterials"
                    placeholder="实际发料"
                  ></el-input>
                </el-form-item>
                <el-form-item label="SOP确认">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.equipmentLocating"
                    placeholder="SOP确认"
                  ></el-input>
                </el-form-item>
              </el-form>
              <el-form
                label-width="70px"
                :inline="true"
                :model="formInline"
                class="demo-form-inline"
              >
                <el-form-item label="计划开始">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.planBeginTime"
                    placeholder="计划开始"
                  ></el-input>
                </el-form-item>
                <el-form-item label="实际开始">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.trueBeginTime"
                    placeholder="实际开始"
                  ></el-input>
                </el-form-item>
                <el-form-item label="首件确认">
                  <el-input
                    class="formInlineInput"
                    v-model="formInline.firstItemTime"
                    placeholder="首件确认"
                  ></el-input>
                </el-form-item>
              </el-form>
              <el-form>
                <el-form-item>
                  <el-button
                    type="primary"
                    @click="humanConfirmationShowChange(true)"
                    >人力分配</el-button
                  >
                  <el-button type="primary" @click="planBeginOnSubmit"
                    >确认</el-button
                  >
                </el-form-item></el-form
              >
            </div>
          </el-col>
          <el-col :span="12">
            <h2 class="confirmTitle">完工确认</h2>
            <el-form
              label-width="70px"
              :inline="true"
              :model="formInline"
              class="demo-form-inline"
            >
              <el-form-item label="计划完工">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.planEndTime"
                  placeholder="计划完工"
                ></el-input>
              </el-form-item>
              <el-form-item label="实际完工">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.trueEndTime"
                  placeholder="实际完工"
                ></el-input>
              </el-form-item>
            </el-form>

            <el-form
              label-width="70px"
              :inline="true"
              :model="formInline"
              class="demo-form-inline"
            >
              <el-form-item label="工单量">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.productPlanAmount"
                  placeholder="工单量"
                ></el-input>
              </el-form-item>
              <el-form-item label="现场在制">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.productTrueAmount"
                  placeholder="现场在制"
                ></el-input>
              </el-form-item>
              <el-form-item label="入库量" v-if="rotorTypeValue == 2">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.stockInAmount"
                  placeholder="入库量"
                ></el-input>
              </el-form-item>
            </el-form>
            <el-form
              label-width="70px"
              :inline="true"
              :model="formInline"
              class="demo-form-inline"
            >
              <el-form-item label="报废量">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.scrappedAmount"
                  placeholder="报废量"
                ></el-input>
              </el-form-item>
              <el-form-item label="返修量">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.repairAmount"
                  placeholder="返修量"
                ></el-input>
              </el-form-item>
            </el-form>

            <el-form
              label-width="70px"
              :inline="true"
              :model="formInline"
              class="demo-form-inline"
            >
              <el-form-item label="计划人力">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.endScheduleResource"
                  placeholder="计划人力"
                ></el-input>
              </el-form-item>
              <el-form-item label="实际人力">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.endTrueResource"
                  placeholder="实际人力"
                ></el-input>
              </el-form-item>
            </el-form>
            <el-form
              label-width="70px"
              :inline="true"
              :model="formInline"
              class="demo-form-inline"
            >
              <el-form-item label="设备状态">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.machineStatus"
                  placeholder="设备状态"
                ></el-input>
              </el-form-item>
              <el-form-item label="运行时长">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.machineRunTime"
                  placeholder="运行时长"
                ></el-input>
              </el-form-item>
              <el-form-item label="操作时长">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.machineOperateTime"
                  placeholder="操作时长"
                ></el-input>
              </el-form-item>
              <el-form-item label="故障时长">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.machineBreakDownTime"
                  placeholder="故障时长"
                ></el-input>
              </el-form-item>
              <el-form-item label="停机时长">
                <el-input
                  class="formInlineInput"
                  v-model="formInline.machineOfflineTime"
                  placeholder="停机时长"
                ></el-input>
              </el-form-item>
            </el-form>
            <el-form>
              <el-form-item>
                <el-button type="primary" @click="planCompleteOnSubmit"
                  >确认</el-button
                >
              </el-form-item></el-form
            >
          </el-col>
        </el-row>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { dateFormat } from "@/utils/dateUtil";
import detail from "./rotorproductplanmanage-detail";
export default {
  data() {
    return {
      //表单规则
      humanConfirmRules: {
        humanConfirm: [
          { required: true, message: "请选择人力", trigger: "blur" },
        ],
      },
      //计划对应可分配工位
      processNames: [
        {
          machineId: "1503",
          processName: "压扎片，压换向器，插纸",
          operatorName: "",
        },
        { machineId: "1504", processName: "绕线1", operatorName: "" },
        { machineId: "1505", processName: "绕线2", operatorName: "" },
        { machineId: "1506", processName: "塞槽楔", operatorName: "" },
        { machineId: "1507", processName: "点焊1", operatorName: "" },
        { machineId: "1508", processName: "点焊2", operatorName: "" },
        { machineId: "1509", processName: "测试", operatorName: "" },
      ],
      //已签到人员
      operatorInfo: ["张三", "李四", "王五"],

      //开工和完工确认表单
      formInline: {
        beginScheduleResource: "",
        beginTrueResource: "",
        equipmentLocating: "",
        planIssuanceOfMaterials: "",
        trueIssuanceOfMaterials: "",
        equipmentLocating: "",
        planBeginTime: "",
        trueBeginTime: "",
        firstItemTime: "",
        planEndTime: "",
        trueEndTime: "",
        productPlanAmount: "",
        productTrueAmount: "",
        stockInAmount: "",
        scrappedAmount: "",
        repairAmount: "",
        endScheduleResource: "",
        endTrueResource: "",
        machineStatus: "",
        machineRunTime: "",
        machineOperateTime: "",
        machineBreakDownTime: "",
        machineOfflineTime: "",
      },

      // 更改人力显示
      humanConfirmationShow: true,

      //表单编号
      id: "1",

      //临时lineId
      tempLineId: 15,

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
      pageSize: 20,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      detailVisible: false,

      options: [],
    };
  },
  components: {
    detail,
  },
  activated() {
    this.getDataList();

    this.getMenus();

    this.getCheckedInOperators();
  },
  methods: {
    //获取已签到人员
    getCheckedInOperators() {
      this.$http({
        url: this.$http.adornUrl(
          "/rotor/checkinemployeeinfo/info/" + this.tempLineId
        ),
        method: "get",
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.operatorInfo = data.emInfos;
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    //开工确认按钮
    planBeginOnSubmit() {},
    //完工确认按钮
    planCompleteOnSubmit() {},
    //切换人力分配和开工确认
    humanConfirmationShowChange(flag) {
      //人力分配确认时清点实到人力
      if (!flag) {
        let beginTrueResource = 0;
        this.processNames.forEach((value) => {
          beginTrueResource += value.operatorName.length;
        });
        this.formInline.beginTrueResource = beginTrueResource;
      }
      this.humanConfirmationShow = flag;
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

      this.getDataList();
    },
    // 获取计划数据列表
    getDataList() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl(
          "/rotor/rotorproductplanmanage/listWithoutInit"
        ),
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
    getDetail(row) {
      this.detailVisible = true;
      this.$nextTick(() => {
        this.$refs.detail.init(row);
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
  },
};
</script>

<style>
/* 开工完工标题 */
.confirmTitle {
  text-align: center;
  font-weight: 300;
}

/* 开工、完工确认输入框 */
.formInlineInput {
  width: 9rem;
}
</style>