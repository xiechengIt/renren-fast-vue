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
      label-width="80px"
    >
      <el-form-item label="单据编号" prop="billNum">
        <el-input v-model="dataForm.billNum" placeholder="单据编号"></el-input>
      </el-form-item>
      <el-form-item label="工序名称" prop="processName">
        <el-input
          v-model="dataForm.processName"
          placeholder="工序名称"
        ></el-input>
      </el-form-item>
      <el-form-item label="机号" prop="machineId">
        <el-input v-model="dataForm.machineId" placeholder="机号"></el-input>
      </el-form-item>
      <el-form-item label="代码" prop="code">
        <el-input v-model="dataForm.code" placeholder="代码"></el-input>
      </el-form-item>
      <el-form-item label="生产顺序" prop="planId">
        <el-input v-model="dataForm.planId" placeholder="生产顺序"></el-input>
      </el-form-item>
      <el-form-item label="卡号" prop="cardId">
        <el-input v-model="dataForm.cardId" placeholder="卡号"></el-input>
      </el-form-item>
      <el-form-item label="等待时间" prop="waitingTime">
        <el-input
          v-model="dataForm.waitingTime"
          placeholder="等待时间"
        ></el-input>
      </el-form-item>
      <el-form-item label="工单号" prop="workOrderId">
        <el-input
          v-model="dataForm.workOrderId"
          placeholder="工单号"
        ></el-input>
      </el-form-item>
      <el-form-item label="工单数量" prop="billAmount">
        <el-input
          v-model="dataForm.billAmount"
          placeholder="工单数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="订单号" prop="orderId">
        <el-input v-model="dataForm.orderId" placeholder="订单号"></el-input>
      </el-form-item>
      <el-form-item label="订单数量" prop="orderAmount">
        <el-input
          v-model="dataForm.orderAmount"
          placeholder="订单数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="结案" prop="autoFinish">
        <el-input v-model="dataForm.autoFinish" placeholder="结案"></el-input>
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
      <el-form-item label="计划开始日期" prop="planBeginTime">
        <el-input
          v-model="dataForm.planBeginTime"
          placeholder="计划开始日期"
        ></el-input>
      </el-form-item>
      <el-form-item label="计划结束日期" prop="planEndTime">
        <el-input
          v-model="dataForm.planEndTime"
          placeholder="计划结束日期"
        ></el-input>
      </el-form-item>
      <el-form-item label="实际开始日期" prop="beginTime">
        <el-input
          v-model="dataForm.beginTime"
          placeholder="实际开始日期"
        ></el-input>
      </el-form-item>
      <el-form-item label="手工结案" prop="manualFinish">
        <el-input
          v-model="dataForm.manualFinish"
          placeholder="手工结案"
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
      <el-form-item label="产能H" prop="advancedTimeh">
        <el-input
          v-model="dataForm.advancedTimeh"
          placeholder="产能H"
        ></el-input>
      </el-form-item>
      <el-form-item label="制单日期" prop="makeBillTime">
        <el-input
          v-model="dataForm.makeBillTime"
          placeholder="制单日期"
        ></el-input>
      </el-form-item>
      <el-form-item label="标志" prop="symbol">
        <el-input v-model="dataForm.symbol" placeholder="标志"></el-input>
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-input
          v-model="dataForm.updateTime"
          placeholder="更新时间"
        ></el-input>
      </el-form-item>
      <el-form-item label="是否生产" prop="ifProduct">
        <el-input
          v-model="dataForm.ifProduct"
          placeholder="是否生产"
        ></el-input>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-input v-model="dataForm.status" placeholder="状态"></el-input>
      </el-form-item>
      <el-form-item label="品名" prop="itemName">
        <el-input v-model="dataForm.itemName" placeholder="品名"></el-input>
      </el-form-item>
      <el-form-item label="规格" prop="model">
        <el-input v-model="dataForm.model" placeholder="规格"></el-input>
      </el-form-item>
      <el-form-item label="警报数量" prop="warningAmount">
        <el-input
          v-model="dataForm.warningAmount"
          placeholder="警报数量"
        ></el-input>
      </el-form-item>
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
      dataForm: {
        id: 0,
        billNum: "",
        processName: "",
        machineId: "",
        code: "",
        planId: "",
        cardId: "",
        waitingTime: "",
        workOrderId: "",
        billAmount: "",
        orderId: "",
        orderAmount: "",
        autoFinish: "",
        productPlanAmount: "",
        endAmount: "",
        restAmount: "",
        planBeginTime: "",
        planEndTime: "",
        beginTime: "",
        manualFinish: "",
        restTime: "",
        endTime: "",
        materialTotalKg: "",
        materialUsedKg: "",
        materialRestKg: "",
        advancedTimeh: "",
        makeBillTime: "",
        symbol: "",
        updateTime: "",
        ifProduct: "",
        status: "",
        itemName: "",
        model: "",
        warningAmount: "",
      },
      dataRule: {
        billNum: [
          { required: true, message: "单据编号不能为空", trigger: "blur" },
        ],
        processName: [
          { required: true, message: "工序名称不能为空", trigger: "blur" },
        ],
        machineId: [
          { required: true, message: "机号不能为空", trigger: "blur" },
        ],
        code: [{ required: true, message: "代码不能为空", trigger: "blur" }],
        planId: [
          { required: true, message: "生产顺序不能为空", trigger: "blur" },
        ],
        cardId: [{ required: true, message: "卡号不能为空", trigger: "blur" }],
        waitingTime: [
          { required: true, message: "等待时间不能为空", trigger: "blur" },
        ],
        workOrderId: [
          { required: true, message: "工单号不能为空", trigger: "blur" },
        ],
        billAmount: [
          { required: true, message: "工单数量不能为空", trigger: "blur" },
        ],
        orderId: [
          { required: true, message: "订单号不能为空", trigger: "blur" },
        ],
        orderAmount: [
          { required: true, message: "订单数量不能为空", trigger: "blur" },
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
        planBeginTime: [
          { required: true, message: "计划开始日期不能为空", trigger: "blur" },
        ],
        planEndTime: [
          { required: true, message: "计划结束日期不能为空", trigger: "blur" },
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
        advancedTimeh: [
          { required: true, message: "产能H不能为空", trigger: "blur" },
        ],
        makeBillTime: [
          { required: true, message: "制单日期不能为空", trigger: "blur" },
        ],
        symbol: [{ required: true, message: "标志不能为空", trigger: "blur" }],
        updateTime: [
          { required: true, message: "更新时间不能为空", trigger: "blur" },
        ],
        ifProduct: [
          { required: true, message: "是否生产不能为空", trigger: "blur" },
        ],
        status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
        itemName: [
          { required: true, message: "品名不能为空", trigger: "blur" },
        ],
        model: [{ required: true, message: "规格不能为空", trigger: "blur" }],
        warningAmount: [
          { required: true, message: "警报数量不能为空", trigger: "blur" },
        ],
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
              `/productionplan/tblmplan/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.billNum = data.tblmplan.billNum;
              this.dataForm.processName = data.tblmplan.processName;
              this.dataForm.machineId = data.tblmplan.machineId;
              this.dataForm.code = data.tblmplan.code;
              this.dataForm.planId = data.tblmplan.planId;
              this.dataForm.cardId = data.tblmplan.cardId;
              this.dataForm.waitingTime = data.tblmplan.waitingTime;
              this.dataForm.workOrderId = data.tblmplan.workOrderId;
              this.dataForm.billAmount = data.tblmplan.billAmount;
              this.dataForm.orderId = data.tblmplan.orderId;
              this.dataForm.orderAmount = data.tblmplan.orderAmount;
              this.dataForm.autoFinish = data.tblmplan.autoFinish;
              this.dataForm.productPlanAmount = data.tblmplan.productPlanAmount;
              this.dataForm.endAmount = data.tblmplan.endAmount;
              this.dataForm.restAmount = data.tblmplan.restAmount;
              this.dataForm.planBeginTime = data.tblmplan.planBeginTime;
              this.dataForm.planEndTime = data.tblmplan.planEndTime;
              this.dataForm.beginTime = data.tblmplan.beginTime;
              this.dataForm.manualFinish = data.tblmplan.manualFinish;
              this.dataForm.restTime = data.tblmplan.restTime;
              this.dataForm.endTime = data.tblmplan.endTime;
              this.dataForm.materialTotalKg = data.tblmplan.materialTotalKg;
              this.dataForm.materialUsedKg = data.tblmplan.materialUsedKg;
              this.dataForm.materialRestKg = data.tblmplan.materialRestKg;
              this.dataForm.advancedTimeh = data.tblmplan.advancedTimeh;
              this.dataForm.makeBillTime = data.tblmplan.makeBillTime;
              this.dataForm.symbol = data.tblmplan.symbol;
              this.dataForm.updateTime = data.tblmplan.updateTime;
              this.dataForm.ifProduct = data.tblmplan.ifProduct;
              this.dataForm.status = data.tblmplan.status;
              this.dataForm.itemName = data.tblmplan.itemName;
              this.dataForm.model = data.tblmplan.model;
              this.dataForm.warningAmount = data.tblmplan.warningAmount;
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
              `/productionplan/tblmplan/${
                !this.dataForm.id ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              id: this.dataForm.id || undefined,
              billNum: this.dataForm.billNum,
              processName: this.dataForm.processName,
              machineId: this.dataForm.machineId,
              code: this.dataForm.code,
              planId: this.dataForm.planId,
              cardId: this.dataForm.cardId,
              waitingTime: this.dataForm.waitingTime,
              workOrderId: this.dataForm.workOrderId,
              billAmount: this.dataForm.billAmount,
              orderId: this.dataForm.orderId,
              orderAmount: this.dataForm.orderAmount,
              autoFinish: this.dataForm.autoFinish,
              productPlanAmount: this.dataForm.productPlanAmount,
              endAmount: this.dataForm.endAmount,
              restAmount: this.dataForm.restAmount,
              planBeginTime: this.dataForm.planBeginTime,
              planEndTime: this.dataForm.planEndTime,
              beginTime: this.dataForm.beginTime,
              manualFinish: this.dataForm.manualFinish,
              restTime: this.dataForm.restTime,
              endTime: this.dataForm.endTime,
              materialTotalKg: this.dataForm.materialTotalKg,
              materialUsedKg: this.dataForm.materialUsedKg,
              materialRestKg: this.dataForm.materialRestKg,
              advancedTimeh: this.dataForm.advancedTimeh,
              makeBillTime: this.dataForm.makeBillTime,
              symbol: this.dataForm.symbol,
              updateTime: this.dataForm.updateTime,
              ifProduct: this.dataForm.ifProduct,
              status: this.dataForm.status,
              itemName: this.dataForm.itemName,
              model: this.dataForm.model,
              warningAmount: this.dataForm.warningAmount,
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
  },
};
</script>
