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
      label-width="110px"
    >
      <el-form-item label="单号" prop="no">
        <el-input v-model="dataForm.no" placeholder="单号"></el-input>
      </el-form-item>
      <el-form-item label="领料日期" prop="date">
        <div class="block">
          <el-date-picker
            v-model="dataForm.date"
            align="right"
            type="datetime"
            placeholder="领料日期"
            :picker-options="pickerOptions"
            value-format="yyyy-MM-dd HH:mm:ss"
          >
          </el-date-picker>
        </div>
      </el-form-item>
      <el-form-item label="材料名称" prop="name">
        <el-input v-model="dataForm.name" placeholder="材料名称" disabled></el-input>
      </el-form-item>
      <el-form-item label="型号" prop="model">
        <el-input v-model="dataForm.model" placeholder="型号" disabled></el-input>
      </el-form-item>
      <el-form-item label="单位" prop="unit">
        <el-input v-model="dataForm.unit" placeholder="单位" disabled></el-input>
      </el-form-item>
      <el-form-item label="数量" prop="amount">
        <el-input v-model="dataForm.amount" placeholder="数量" disabled></el-input>
      </el-form-item>
      <el-form-item label="单价" prop="price">
        <el-input v-model="dataForm.price" placeholder="单价" disabled></el-input>
      </el-form-item>
      <el-form-item label="总价" prop="totalPrice">
        <el-input v-model="dataForm.totalPrice" placeholder="总价" disabled></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="comment">
        <el-input v-model="dataForm.comment" placeholder="备注"></el-input>
      </el-form-item>
      <el-form-item label="领料部门" prop="department">
        <el-input
          v-model="dataForm.department"
          placeholder="领料部门"
        ></el-input>
      </el-form-item>
      <el-form-item label="领料部门负责人" prop="departmentLeader">
        <el-input
          v-model="dataForm.departmentLeader"
          placeholder="领料部门负责人"
        ></el-input>
      </el-form-item>
      <el-form-item label="领料人" prop="departmentMember">
        <el-input
          v-model="dataForm.departmentMember"
          placeholder="领料人"
        ></el-input>
      </el-form-item>
      <el-form-item label="领料人照片" prop="photo">
        <el-input v-model="dataForm.photo" placeholder="领料人照片"></el-input>
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
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
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
      visible: false,
      dataForm: {
        id: 0,
        no: "",
        date: "",
        name: "",
        model: "",
        unit: "",
        amount: "",
        price: "",
        totalPrice: "",
        comment: "",
        department: "",
        departmentLeader: "",
        departmentMember: "",
        photo: "",
      },
      dataRule: {
        /* no: [
            { required: true, message: '单号不能为空', trigger: 'blur' }
          ],*/
        date: [
          { required: true, message: "领料日期不能为空", trigger: "blur" },
        ]/*,
        name: [
          { required: true, message: "材料名称不能为空", trigger: "blur" },
        ] 
          model: [
            { required: true, message: '型号不能为空', trigger: 'blur' }
          ],
          unit: [
            { required: true, message: '单位不能为空', trigger: 'blur' }
          ],
          amount: [
            { required: true, message: '数量不能为空', trigger: 'blur' }
          ],
          price: [
            { required: true, message: '单价不能为空', trigger: 'blur' }
          ],
          totalPrice: [
            { required: true, message: '总价不能为空', trigger: 'blur' }
          ],
          comment: [
            { required: true, message: '备注不能为空', trigger: 'blur' }
          ],
          department: [
            { required: true, message: '领料部门不能为空', trigger: 'blur' }
          ],
          departmentLeader: [
            { required: true, message: '领料部门负责人不能为空', trigger: 'blur' }
          ],,
        departmentMember: [
          { required: true, message: "领料人不能为空", trigger: "blur" },
        ] 
          photo: [
            { required: true, message: '领料人照片不能为空', trigger: 'blur' }
          ] */,
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
            url: this.$http.adornUrl(`/it/stockBill/info/${this.dataForm.id}`),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.no = data.stockBill.no;
              this.dataForm.date = data.stockBill.date;
              this.dataForm.name = data.stockBill.name;
              this.dataForm.model = data.stockBill.model;
              this.dataForm.unit = data.stockBill.unit;
              this.dataForm.amount = data.stockBill.amount;
              this.dataForm.price = data.stockBill.price;
              this.dataForm.totalPrice = data.stockBill.totalPrice;
              this.dataForm.comment = data.stockBill.comment;
              this.dataForm.department = data.stockBill.department;
              this.dataForm.departmentLeader = data.stockBill.departmentLeader;
              this.dataForm.departmentMember = data.stockBill.departmentMember;
              this.dataForm.photo = data.stockBill.photo;
            }
          });
        }
      });
    },
    // 表单提交
    dataFormSubmit() {
      console.log(this.dataForm.date);
      this.$refs["dataForm"].validate((valid) => {
        if (valid) {
          this.$http({
            url: this.$http.adornUrl(
              `/it/stockBill/${!this.dataForm.id ? "save" : "update"}`
            ),
            method: "post",
            data: this.$http.adornData({
              id: this.dataForm.id || undefined,
              no: this.dataForm.no,
              date: this.dataForm.date,
              name: this.dataForm.name,
              model: this.dataForm.model,
              unit: this.dataForm.unit,
              amount: this.dataForm.amount,
              price: this.dataForm.price,
              totalPrice: this.dataForm.totalPrice,
              comment: this.dataForm.comment,
              department: this.dataForm.department,
              departmentLeader: this.dataForm.departmentLeader,
              departmentMember: this.dataForm.departmentMember,
              photo: this.dataForm.photo,
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
