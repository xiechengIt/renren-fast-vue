<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible"
  >
    <el-form
      :model="dataForm"
      :rules="dataRule"
      ref="dataForm"
      @keyup.enter.native="dataFormSubmit()"
      label-width="80px"
    >
      <el-form-item label="代码" prop="code">
        <el-input v-model="dataForm.code" placeholder="代码"></el-input>
      </el-form-item>
      <el-form-item label="品名" prop="itemName">
        <el-input v-model="dataForm.itemName" placeholder="品名"></el-input>
      </el-form-item>
      <el-form-item label="默认仓库" prop="defaultWarehouse">
        <el-input
          v-model="dataForm.defaultWarehouse"
          placeholder="默认仓库"
        ></el-input>
      </el-form-item>
      <el-form-item label="单位" prop="unit">
        <el-input v-model="dataForm.unit" placeholder="单位"></el-input>
      </el-form-item>
      <el-form-item label="客户" prop="client">
        <el-input v-model="dataForm.client" placeholder="客户"></el-input>
      </el-form-item>
      <el-form-item label="生产部门" prop="productionDepartment">
        <el-input
          v-model="dataForm.productionDepartment"
          placeholder="生产部门"
        ></el-input>
      </el-form-item>
      <el-form-item label="属性" prop="attribute">
        <el-input v-model="dataForm.attribute" placeholder="属性"></el-input>
      </el-form-item>
      <el-form-item label="产品系列" prop="productSeries">
        <el-input
          v-model="dataForm.productSeries"
          placeholder="产品系列"
        ></el-input>
      </el-form-item>
      <el-form-item label="模具编号" prop="modelNo">
        <el-input v-model="dataForm.modelNo" placeholder="模具编号"></el-input>
      </el-form-item>
      <el-form-item label="颜色" prop="color">
        <el-input v-model="dataForm.color" placeholder="颜色"></el-input>
      </el-form-item>
      <el-form-item label="穴数" prop="slotCount">
        <el-input v-model="dataForm.slotCount" placeholder="穴数"></el-input>
      </el-form-item>
      <el-form-item label="吨位" prop="tonnage">
        <el-input v-model="dataForm.tonnage" placeholder="吨位"></el-input>
      </el-form-item>
      <el-form-item label="单重g" prop="pieceWeightg">
        <el-input
          v-model="dataForm.pieceWeightg"
          placeholder="单重g"
        ></el-input>
      </el-form-item>
      <el-form-item label="产能H" prop="capacityh">
        <el-input v-model="dataForm.capacityh" placeholder="产能H"></el-input>
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
      <el-form-item label="材料规格" prop="materialModel">
        <el-input
          v-model="dataForm.materialModel"
          placeholder="材料规格"
        ></el-input>
      </el-form-item>
      <el-form-item label="材料料号" prop="pigmentNo">
        <el-input
          v-model="dataForm.pigmentNo"
          placeholder="材料料号"
        ></el-input>
      </el-form-item>
      <el-form-item label="色料品名" prop="pigmentItemName">
        <el-input
          v-model="dataForm.pigmentItemName"
          placeholder="色料品名"
        ></el-input>
      </el-form-item>
      <el-form-item label="色料规格" prop="pigmentModel">
        <el-input
          v-model="dataForm.pigmentModel"
          placeholder="色料规格"
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
        code: "",
        itemName: "",
        defaultWarehouse: "",
        unit: "",
        client: "",
        productionDepartment: "",
        attribute: "",
        productSeries: "",
        modelNo: "",
        color: "",
        slotCount: "",
        tonnage: "",
        pieceWeightg: "",
        capacityh: "",
        materialNo: "",
        materialItemName: "",
        materialModel: "",
        pigmentNo: "",
        pigmentItemName: "",
        pigmentModel: "",
      },
      dataRule: {
        code: [{ required: true, message: "代码不能为空", trigger: "blur" }],
        itemName: [
          { required: true, message: "品名不能为空", trigger: "blur" },
        ],
        defaultWarehouse: [
          { required: true, message: "默认仓库不能为空", trigger: "blur" },
        ],
        unit: [{ required: true, message: "单位不能为空", trigger: "blur" }],
        client: [{ required: true, message: "客户不能为空", trigger: "blur" }],
        productionDepartment: [
          { required: true, message: "生产部门不能为空", trigger: "blur" },
        ],
        attribute: [
          { required: true, message: "属性不能为空", trigger: "blur" },
        ],
        productSeries: [
          { required: true, message: "产品系列不能为空", trigger: "blur" },
        ],
        modelNo: [
          { required: true, message: "模具编号不能为空", trigger: "blur" },
        ],
        color: [{ required: true, message: "颜色不能为空", trigger: "blur" }],
        slotCount: [
          { required: true, message: "穴数不能为空", trigger: "blur" },
        ],
        tonnage: [{ required: true, message: "吨位不能为空", trigger: "blur" }],
        pieceWeightg: [
          { required: true, message: "单重g不能为空", trigger: "blur" },
        ],
        capacityh: [
          { required: true, message: "产能H不能为空", trigger: "blur" },
        ],
        materialNo: [
          { required: true, message: "材料料号不能为空", trigger: "blur" },
        ],
        materialItemName: [
          { required: true, message: "材料品名不能为空", trigger: "blur" },
        ],
        materialModel: [
          { required: true, message: "材料规格不能为空", trigger: "blur" },
        ],
        pigmentNo: [
          { required: true, message: "材料料号不能为空", trigger: "blur" },
        ],
        pigmentItemName: [
          { required: true, message: "色料品名不能为空", trigger: "blur" },
        ],
        pigmentModel: [
          { required: true, message: "色料规格不能为空", trigger: "blur" },
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
              `/productionplan/tblmaterial/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.code = data.tblmaterial.code;
              this.dataForm.itemName = data.tblmaterial.itemName;
              this.dataForm.defaultWarehouse =
                data.tblmaterial.defaultWarehouse;
              this.dataForm.unit = data.tblmaterial.unit;
              this.dataForm.client = data.tblmaterial.client;
              this.dataForm.productionDepartment =
                data.tblmaterial.productionDepartment;
              this.dataForm.attribute = data.tblmaterial.attribute;
              this.dataForm.productSeries = data.tblmaterial.productSeries;
              this.dataForm.modelNo = data.tblmaterial.modelNo;
              this.dataForm.color = data.tblmaterial.color;
              this.dataForm.slotCount = data.tblmaterial.slotCount;
              this.dataForm.tonnage = data.tblmaterial.tonnage;
              this.dataForm.pieceWeightg = data.tblmaterial.pieceWeightg;
              this.dataForm.capacityh = data.tblmaterial.capacityh;
              this.dataForm.materialNo = data.tblmaterial.materialNo;
              this.dataForm.materialItemName =
                data.tblmaterial.materialItemName;
              this.dataForm.materialModel = data.tblmaterial.materialModel;
              this.dataForm.pigmentNo = data.tblmaterial.pigmentNo;
              this.dataForm.pigmentItemName = data.tblmaterial.pigmentItemName;
              this.dataForm.pigmentModel = data.tblmaterial.pigmentModel;
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
              `/productionplan/tblmaterial/${
                !this.dataForm.id ? "save" : "update"
              }`
            ),
            method: "post",
            data: this.$http.adornData({
              id: this.dataForm.id || undefined,
              code: this.dataForm.code,
              itemName: this.dataForm.itemName,
              defaultWarehouse: this.dataForm.defaultWarehouse,
              unit: this.dataForm.unit,
              client: this.dataForm.client,
              productionDepartment: this.dataForm.productionDepartment,
              attribute: this.dataForm.attribute,
              productSeries: this.dataForm.productSeries,
              modelNo: this.dataForm.modelNo,
              color: this.dataForm.color,
              slotCount: this.dataForm.slotCount,
              tonnage: this.dataForm.tonnage,
              pieceWeightg: this.dataForm.pieceWeightg,
              capacityh: this.dataForm.capacityh,
              materialNo: this.dataForm.materialNo,
              materialItemName: this.dataForm.materialItemName,
              materialModel: this.dataForm.materialModel,
              pigmentNo: this.dataForm.pigmentNo,
              pigmentItemName: this.dataForm.pigmentItemName,
              pigmentModel: this.dataForm.pigmentModel,
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
