<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
    top="10px"
  >
    <el-form
      :model="dataForm"
      :rules="dataRule"
      ref="dataForm"
      @keyup.enter.native="dataFormSubmit()"
      label-width="125px"
      class="dataForm"
    >
      <el-row :gutter="50">
        <el-col :span="12">
          <!-- <el-form-item label="机号" prop="machineId">
            <el-input
              v-model="dataForm.machineId"
              placeholder="机号"
            ></el-input>
          </el-form-item> -->
          <el-form-item label="单据编号" prop="billNum">
            <el-input
              disabled
              v-model="dataForm.billNum"
              placeholder="单据编号"
            ></el-input>
          </el-form-item>
          <el-form-item label="机名" prop="machineName">
            <el-select
              v-model="dataForm.machineName"
              filterable
              placeholder="输入关键词查询"
            >
              <el-option
                v-for="item in machineNames"
                :key="item"
                :label="item"
                :value="item"
              >
              </el-option>
            </el-select>
            <!-- <el-input
              v-model="dataForm.machineName"
              placeholder="机名"
            ></el-input> -->
          </el-form-item>
          <el-form-item label="代码" prop="code">
            <el-input v-model="dataForm.code" placeholder="代码"></el-input>
          </el-form-item>
          <el-form-item label="卡号" prop="cardId">
            <el-input v-model="dataForm.cardId" placeholder="卡号"></el-input>
          </el-form-item>

          <el-form-item label="品名" prop="itemName">
            <el-input v-model="dataForm.itemName" placeholder="品名"></el-input>
          </el-form-item>

          <el-form-item label="规格型号" prop="specification">
            <el-input
              v-model="dataForm.specification"
              placeholder="规格型号"
            ></el-input>
          </el-form-item>
          <el-form-item label="产能H" prop="capacityH">
            <el-input
              v-model="dataForm.capacityH"
              placeholder="产能H"
            ></el-input>
          </el-form-item>
          <el-form-item label="穴数" prop="slotCount">
            <el-input
              v-model="dataForm.slotCount"
              placeholder="穴数"
            ></el-input>
          </el-form-item>
          <el-form-item label="单重g" prop="pieceWeightG">
            <el-input
              v-model="dataForm.pieceWeightG"
              placeholder="单重g"
            ></el-input>
          </el-form-item>
          <el-form-item label="工单号" prop="workOrderId">
            <el-input
              v-model="dataForm.workOrderId"
              placeholder="工单号"
            ></el-input>
          </el-form-item>
          <el-form-item label="订单号" prop="orderId">
            <el-input
              v-model="dataForm.orderId"
              placeholder="订单号"
            ></el-input>
          </el-form-item>
          <el-form-item label="结案" prop="autoFinish">
            <el-input
              v-model="dataForm.autoFinish"
              placeholder="结案"
            ></el-input>
          </el-form-item>
          <el-form-item label="计划生产数量" prop="productPlanAmount">
            <el-input
              v-model="dataForm.productPlanAmount"
              placeholder="计划生产数量"
            ></el-input>
          </el-form-item>
          <el-form-item label="实际完成数量" prop="endAmount">
            <el-input
              v-model="dataForm.endAmount"
              placeholder="实际完成数量"
            ></el-input>
          </el-form-item>
          <el-form-item label="实际剩余数量" prop="restAmount">
            <el-input
              v-model="dataForm.restAmount"
              placeholder="实际剩余数量"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12"
          ><el-form-item label="实际开始日期" prop="beginTime">
            <el-input
              v-model="dataForm.beginTime"
              placeholder="实际开始日期"
            ></el-input>
          </el-form-item>
          <el-form-item label="实际剩余工时" prop="restTime">
            <el-input
              v-model="dataForm.restTime"
              placeholder="实际剩余工时"
            ></el-input>
          </el-form-item>
          <el-form-item label="实际结束日期" prop="endTime">
            <el-input
              v-model="dataForm.endTime"
              placeholder="实际结束日期"
            ></el-input>
          </el-form-item>
          <el-form-item label="更新日期" prop="updateTime">
            <el-input
              v-model="dataForm.updateTime"
              placeholder="更新日期"
            ></el-input>
          </el-form-item>
          <el-form-item label="颜色" prop="color">
            <el-input v-model="dataForm.color" placeholder="颜色"></el-input>
          </el-form-item>
          <el-form-item label="材料料号" prop="materialNo">
            <el-input
              v-model="dataForm.materialNo"
              placeholder="材料料号"
            ></el-input>
          </el-form-item>
          <el-form-item label="材料品名" prop="materialItemName">
            <el-input
              v-model="dataForm.materialItemName"
              placeholder="材料品名"
            ></el-input>
          </el-form-item>
          <el-form-item label="理论材料总量kg" prop="materialTotalKg">
            <el-input
              v-model="dataForm.materialTotalKg"
              placeholder="理论材料总量kg"
            ></el-input>
          </el-form-item>
          <el-form-item label="理论材料已用kg" prop="materialUsedKg">
            <el-input
              v-model="dataForm.materialUsedKg"
              placeholder="理论材料已用kg"
            ></el-input>
          </el-form-item>
          <el-form-item label="理论材料结余kg" prop="materialRestKg">
            <el-input
              v-model="dataForm.materialRestKg"
              placeholder="理论材料结余kg"
            ></el-input>
          </el-form-item>
          <el-form-item label="提前期H" prop="advancedTimeH">
            <el-input
              v-model="dataForm.advancedTimeH"
              placeholder="提前期H"
            ></el-input>
          </el-form-item>
          <el-form-item label="制单日期" prop="makeBillTime">
            <el-input
              v-model="dataForm.makeBillTime"
              placeholder="制单日期"
            ></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-input v-model="dataForm.status" placeholder="状态"></el-input>
          </el-form-item>
          <el-form-item label="模具编号" prop="modelNo">
            <el-input
              v-model="dataForm.modelNo"
              placeholder="模具编号"
            ></el-input>
          </el-form-item>
          <el-form-item label="手工结案" prop="manualFinish">
            <!-- <el-input
              v-model="dataForm.manualFinish"
              placeholder="手工结案"
            ></el-input> -->
            <el-checkbox v-model="dataForm.manualFinish"></el-checkbox>
          </el-form-item>
          <!-- <el-form-item label="实际完成数量" prop="理论材料总量kg">
      <el-input v-model="dataForm.理论材料总量kg" placeholder="实际完成数量"></el-input>
    </el-form-item>
    <el-form-item label="实际完成数量" prop="手工结案">
      <el-input v-model="dataForm.手工结案" placeholder="实际完成数量"></el-input>
    </el-form-item> -->
        </el-col>
      </el-row>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  data() {
    return {
      visible: false,
      //基础数据
      dataForm: {
        machineId: "",
        machineName: "",
        cardId: "",
        code: "",
        itemName: "",
        billNum: "",
        specification: "",
        capacityH: "",
        slotCount: "",
        pieceWeightG: "",
        workOrderId: "",
        orderId: "",
        autoFinish: "",
        productPlanAmount: "",
        endAmount: "",
        restAmount: "",
        beginTime: "",
        manualFinish: "",
        restTime: "",
        endTime: "",
        updateTime: "",
        color: "",
        materialNo: "",
        materialItemName: "",
        materialTotalKg: "",
        materialUsedKg: "",
        materialRestKg: "",
        advancedTimeH: "",
        makeBillTime: "",
        status: "",
        modelNo: "",
        //理论材料总量kg: '',
        id: 0,
        //手工结案: ''
      },
      //机名列表
      machineNames: [],
      //代码列表
      codes: [],
      dataRule: {
       /*  machineId: [
          { required: true, message: "机号不能为空", trigger: "blur" },
        ],
        machineName: [
          { required: true, message: "机名不能为空", trigger: "blur" },
        ],
        cardId: [{ required: true, message: "卡号不能为空", trigger: "blur" }],
        code: [{ required: true, message: "代码不能为空", trigger: "blur" }],
        itemName: [
          { required: true, message: "品名不能为空", trigger: "blur" },
        ],
        billNum: [
          { required: true, message: "单据编号不能为空", trigger: "blur" },
        ],
        specification: [
          { required: true, message: "规格型号不能为空", trigger: "blur" },
        ],
        capacityH: [
          { required: true, message: "产能H不能为空", trigger: "blur" },
        ],
        slotCount: [
          { required: true, message: "穴数不能为空", trigger: "blur" },
        ],
        pieceWeightG: [
          { required: true, message: "单重g不能为空", trigger: "blur" },
        ],
        workOrderId: [
          { required: true, message: "工单号不能为空", trigger: "blur" },
        ],
        orderId: [
          { required: true, message: "订单号不能为空", trigger: "blur" },
        ],
        autoFinish: [
          { required: true, message: "结案不能为空", trigger: "blur" },
        ],
        productPlanAmount: [
          { required: true, message: "计划生产数量不能为空", trigger: "blur" },
        ],
        endAmount: [
          { required: true, message: "实际完成数量不能为空", trigger: "blur" },
        ],
        restAmount: [
          { required: true, message: "实际剩余数量不能为空", trigger: "blur" },
        ],
        beginTime: [
          { required: true, message: "实际开始日期不能为空", trigger: "blur" },
        ],
        manualFinish: [
          { required: true, message: "手工结案不能为空", trigger: "blur" },
        ],
        restTime: [
          { required: true, message: "实际剩余工时不能为空", trigger: "blur" },
        ],
        endTime: [
          { required: true, message: "实际结束日期不能为空", trigger: "blur" },
        ],
        updateTime: [
          { required: true, message: "更新日期不能为空", trigger: "blur" },
        ],
        color: [{ required: true, message: "颜色不能为空", trigger: "blur" }],
        materialNo: [
          { required: true, message: "材料料号不能为空", trigger: "blur" },
        ],
        materialItemName: [
          { required: true, message: "材料品名不能为空", trigger: "blur" },
        ],
        materialTotalKg: [
          {
            required: true,
            message: "理论材料总量kg不能为空",
            trigger: "blur",
          },
        ],
        materialUsedKg: [
          {
            required: true,
            message: "理论材料已用kg不能为空",
            trigger: "blur",
          },
        ],
        materialRestKg: [
          {
            required: true,
            message: "理论材料结余kg不能为空",
            trigger: "blur",
          },
        ],
        advancedTimeH: [
          { required: true, message: "提前期H不能为空", trigger: "blur" },
        ],
        makeBillTime: [
          { required: true, message: "制单日期不能为空", trigger: "blur" },
        ],
        status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
        modelNo: [
          { required: true, message: "模具编号不能为空", trigger: "blur" },
        ], */
        // 理论材料总量kg: [
        //   { required: true, message: '实际完成数量不能为空', trigger: 'blur' }
        // ],
        // 手工结案: [
        //   { required: true, message: '实际完成数量不能为空', trigger: 'blur' }
        // ]
      },
    };
  },
  methods: {
    init(id) {
      this.dataForm.id = id || 0;
      this.visible = true;
      this.$nextTick(() => {
        this.$refs["dataForm"].resetFields();
        if (this.dataForm.id) {
          this.$http({
            url: this.$http.adornUrl(
              `/productionplan/qutblmplan/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.machineId = data.quTblmplanEntity.machineId;
              this.dataForm.machineName = data.quTblmplanEntity.machineName;
              this.dataForm.cardId = data.quTblmplanEntity.cardId;
              this.dataForm.code = data.quTblmplanEntity.code;
              this.dataForm.itemName = data.quTblmplanEntity.itemName;
              this.dataForm.billNum = data.quTblmplanEntity.billNum;
              this.dataForm.specification = data.quTblmplanEntity.specification;
              this.dataForm.capacityH = data.quTblmplanEntity.capacityH;
              this.dataForm.slotCount = data.quTblmplanEntity.slotCount;
              this.dataForm.pieceWeightG = data.quTblmplanEntity.pieceWeightG;
              this.dataForm.workOrderId = data.quTblmplanEntity.workOrderId;
              this.dataForm.orderId = data.quTblmplanEntity.orderId;
              this.dataForm.autoFinish = data.quTblmplanEntity.autoFinish;
              this.dataForm.productPlanAmount =
                data.quTblmplanEntity.productPlanAmount;
              this.dataForm.endAmount = data.quTblmplanEntity.endAmount;
              this.dataForm.restAmount = data.quTblmplanEntity.restAmount;
              this.dataForm.beginTime = data.quTblmplanEntity.beginTime;
              this.dataForm.manualFinish = data.quTblmplanEntity.manualFinish;
              this.dataForm.restTime = data.quTblmplanEntity.restTime;
              this.dataForm.endTime = data.quTblmplanEntity.endTime;
              this.dataForm.updateTime = data.quTblmplanEntity.updateTime;
              this.dataForm.color = data.quTblmplanEntity.color;
              this.dataForm.materialNo = data.quTblmplanEntity.materialNo;
              this.dataForm.materialItemName =
                data.quTblmplanEntity.materialItemName;
              this.dataForm.materialTotalKg =
                data.quTblmplanEntity.materialTotalKg;
              this.dataForm.materialUsedKg =
                data.quTblmplanEntity.materialUsedKg;
              this.dataForm.materialRestKg =
                data.quTblmplanEntity.materialRestKg;
              this.dataForm.advancedTimeH = data.quTblmplanEntity.advancedTimeH;
              this.dataForm.makeBillTime = data.quTblmplanEntity.makeBillTime;
              this.dataForm.status = data.quTblmplanEntity.status;
              this.dataForm.modelNo = data.quTblmplanEntity.modelNo;
            }
          });
        }
      });
    },
    // 表单提交
    dataFormSubmit() {
      this.$refs["dataForm"].validate((valid) => {
        if (valid) {
          this.$http({
            url: this.$http.adornUrl(
              `/productionplan/qutblmplan/${
                !this.dataForm.id ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              machineId: this.dataForm.machineId,
              cardId: this.dataForm.cardId,
              code: this.dataForm.code,
              itemName: this.dataForm.itemName,
              billNum: this.dataForm.billNum,
              specification: this.dataForm.specification,
              capacityH: this.dataForm.capacityH,
              slotCount: this.dataForm.slotCount,
              pieceWeightG: this.dataForm.pieceWeightG,
              workOrderId: this.dataForm.workOrderId,
              orderId: this.dataForm.orderId,
              autoFinish: this.dataForm.autoFinish,
              productPlanAmount: this.dataForm.productPlanAmount,
              endAmount: this.dataForm.endAmount,
              restAmount: this.dataForm.restAmount,
              beginTime: this.dataForm.beginTime,
              manualFinish: this.dataForm.manualFinish,
              restTime: this.dataForm.restTime,
              endTime: this.dataForm.endTime,
              updateTime: this.dataForm.updateTime,
              color: this.dataForm.color,
              materialNo: this.dataForm.materialNo,
              materialItemName: this.dataForm.materialItemName,
              materialTotalKg: this.dataForm.materialTotalKg,
              materialUsedKg: this.dataForm.materialUsedKg,
              materialRestKg: this.dataForm.materialRestKg,
              advancedTimeH: this.dataForm.advancedTimeH,
              makeBillTime: this.dataForm.makeBillTime,
              status: this.dataForm.status,
              modelNo: this.dataForm.modelNo,
              id: this.dataForm.id || undefined,
              // '计划开始日期': this.dataForm.计划开始日期,
              // '理论材料总量kg': this.dataForm.理论材料总量kg,
              //'手工结案': this.dataForm.手工结案
            }),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "操作成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  this.visible = false;
                  this.$emit("refreshDataList");
                },
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    //获取机名
    getMachineNames() {
      this.$http({
        url: this.$http.adornUrl(`/productionplan/department/machineNames`),
        method: "get",
        params: this.$http.adornParams(),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.machineNames = data.data;
        }
      });
    }, //获取代码
    getCodes() {
      this.$http({
        url: this.$http.adornUrl(`/productionplan/department/codes`),
        method: "get",
        params: this.$http.adornParams(),
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.codes = data.data;
        }
      });
    },
  },

  mounted() {
    //使用updated生命周期会导致循环获取数据
    this.getMachineNames();
  },
};
</script>

<style scoped>
</style>