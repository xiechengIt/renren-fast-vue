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
      <el-form-item label="接收时间" prop="receiptTime">
        <el-input
          v-model="dataForm.receiptTime"
          placeholder="接收时间"
        ></el-input>
      </el-form-item>
      <el-form-item label="卡号" prop="cardId">
        <el-input v-model="dataForm.cardId" placeholder="卡号"></el-input>
      </el-form-item>
      <el-form-item label="IP地址" prop="ip">
        <el-input v-model="dataForm.ip" placeholder="IP地址"></el-input>
      </el-form-item>
      <el-form-item label="机号" prop="machineId">
        <el-input v-model="dataForm.machineId" placeholder="机号"></el-input>
      </el-form-item>
      <el-form-item label="是否需要" prop="need">
        <el-input v-model="dataForm.need" placeholder="是否需要"></el-input>
      </el-form-item>
      <el-form-item label="计划ID" prop="planId">
        <el-input v-model="dataForm.planId" placeholder="计划ID"></el-input>
      </el-form-item>
      <el-form-item label="代码" prop="code">
        <el-input v-model="dataForm.code" placeholder="代码"></el-input>
      </el-form-item>
      <el-form-item label="品名" prop="itemName">
        <el-input v-model="dataForm.itemName" placeholder="品名"></el-input>
      </el-form-item>
      <el-form-item label="规格型号" prop="specifications">
        <el-input
          v-model="dataForm.specifications"
          placeholder="规格型号"
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
      <el-form-item label="计划生产数量" prop="productPlanAmount">
        <el-input
          v-model="dataForm.productPlanAmount"
          placeholder="计划生产数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="间隔秒" prop="intervalSecond">
        <el-input
          v-model="dataForm.intervalSecond"
          placeholder="间隔秒"
        ></el-input>
      </el-form-item>
      <el-form-item label="实际开始日期" prop="beginTime">
        <el-input
          v-model="dataForm.beginTime"
          placeholder="实际开始日期"
        ></el-input>
      </el-form-item>
      <el-form-item label="实际完成数量" prop="endAmount">
        <el-input
          v-model="dataForm.endAmount"
          placeholder="实际完成数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="实际剩余工时" prop="restTime">
        <el-input
          v-model="dataForm.restTime"
          placeholder="实际剩余工时"
        ></el-input>
      </el-form-item>
      <el-form-item label="实际剩余数量" prop="restAmount">
        <el-input
          v-model="dataForm.restAmount"
          placeholder="实际剩余数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="实际结束日期" prop="endTime">
        <el-input
          v-model="dataForm.endTime"
          placeholder="实际结束日期"
        ></el-input>
      </el-form-item>
      <el-form-item label="穴数" prop="slotCount">
        <el-input v-model="dataForm.slotCount" placeholder="穴数"></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="dataForm.remark" placeholder="备注"></el-input>
      </el-form-item>
      <el-form-item label="机名" prop="deptname">
        <el-input v-model="dataForm.deptname" placeholder="机名"></el-input>
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
        receiptTime: "",
        cardId: "",
        ip: "",
        machineId: "",
        need: "",
        planId: "",
        code: "",
        itemName: "",
        specifications: "",
        workOrderId: "",
        billAmount: "",
        orderId: "",
        orderAmount: "",
        productPlanAmount: "",
        intervalSecond: "",
        beginTime: "",
        endAmount: "",
        restTime: "",
        restAmount: "",
        endTime: "",
        slotCount: "",
        remark: "",
        deptname: "",
      },
      dataRule: {
        receiptTime: [
          { required: true, message: "接收时间不能为空", trigger: "blur" },
        ],
        cardId: [{ required: true, message: "卡号不能为空", trigger: "blur" }],
        ip: [{ required: true, message: "IP地址不能为空", trigger: "blur" }],
        machineId: [
          { required: true, message: "机号不能为空", trigger: "blur" },
        ],
        need: [
          { required: true, message: "是否需要不能为空", trigger: "blur" },
        ],
        planId: [
          { required: true, message: "计划ID不能为空", trigger: "blur" },
        ],
        code: [{ required: true, message: "代码不能为空", trigger: "blur" }],
        itemName: [
          { required: true, message: "品名不能为空", trigger: "blur" },
        ],
        specifications: [
          { required: true, message: "规格型号不能为空", trigger: "blur" },
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
        productPlanAmount: [
          { required: true, message: "计划生产数量不能为空", trigger: "blur" },
        ],
        intervalSecond: [
          { required: true, message: "间隔秒不能为空", trigger: "blur" },
        ],
        beginTime: [
          { required: true, message: "实际开始日期不能为空", trigger: "blur" },
        ],
        endAmount: [
          { required: true, message: "实际完成数量不能为空", trigger: "blur" },
        ],
        restTime: [
          { required: true, message: "实际剩余工时不能为空", trigger: "blur" },
        ],
        restAmount: [
          { required: true, message: "实际剩余数量不能为空", trigger: "blur" },
        ],
        endTime: [
          { required: true, message: "实际结束日期不能为空", trigger: "blur" },
        ],
        slotCount: [
          { required: true, message: "穴数不能为空", trigger: "blur" },
        ],
        remark: [{ required: true, message: "备注不能为空", trigger: "blur" }],
        deptname: [
          { required: true, message: "机名不能为空", trigger: "blur" },
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
              `/productionplan/qucarddata/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.receiptTime = data.quCarddata.receiptTime;
              this.dataForm.cardId = data.quCarddata.cardId;
              this.dataForm.ip = data.quCarddata.ip;
              this.dataForm.machineId = data.quCarddata.machineId;
              this.dataForm.need = data.quCarddata.need;
              this.dataForm.planId = data.quCarddata.planId;
              this.dataForm.code = data.quCarddata.code;
              this.dataForm.itemName = data.quCarddata.itemName;
              this.dataForm.specifications = data.quCarddata.specifications;
              this.dataForm.workOrderId = data.quCarddata.workOrderId;
              this.dataForm.billAmount = data.quCarddata.billAmount;
              this.dataForm.orderId = data.quCarddata.orderId;
              this.dataForm.orderAmount = data.quCarddata.orderAmount;
              this.dataForm.productPlanAmount =
                data.quCarddata.productPlanAmount;
              this.dataForm.intervalSecond = data.quCarddata.intervalSecond;
              this.dataForm.beginTime = data.quCarddata.beginTime;
              this.dataForm.endAmount = data.quCarddata.endAmount;
              this.dataForm.restTime = data.quCarddata.restTime;
              this.dataForm.restAmount = data.quCarddata.restAmount;
              this.dataForm.endTime = data.quCarddata.endTime;
              this.dataForm.slotCount = data.quCarddata.slotCount;
              this.dataForm.remark = data.quCarddata.remark;
              this.dataForm.deptname = data.quCarddata.deptname;
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
              `/productionplan/qucarddata/${
                !this.dataForm.id ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              id: this.dataForm.id || undefined,
              receiptTime: this.dataForm.receiptTime,
              cardId: this.dataForm.cardId,
              ip: this.dataForm.ip,
              machineId: this.dataForm.machineId,
              need: this.dataForm.need,
              planId: this.dataForm.planId,
              code: this.dataForm.code,
              itemName: this.dataForm.itemName,
              specifications: this.dataForm.specifications,
              workOrderId: this.dataForm.workOrderId,
              billAmount: this.dataForm.billAmount,
              orderId: this.dataForm.orderId,
              orderAmount: this.dataForm.orderAmount,
              productPlanAmount: this.dataForm.productPlanAmount,
              intervalSecond: this.dataForm.intervalSecond,
              beginTime: this.dataForm.beginTime,
              endAmount: this.dataForm.endAmount,
              restTime: this.dataForm.restTime,
              restAmount: this.dataForm.restAmount,
              endTime: this.dataForm.endTime,
              slotCount: this.dataForm.slotCount,
              remark: this.dataForm.remark,
              deptname: this.dataForm.deptname,
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
