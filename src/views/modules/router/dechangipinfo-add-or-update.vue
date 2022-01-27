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
      label-width="120px"
    >
      <el-form-item label="办公室" prop="office">
        <el-input v-model="dataForm.office" placeholder="办公室"></el-input>
      </el-form-item>
      <el-form-item label="部门" prop="department">
        <el-input v-model="dataForm.department" placeholder="部门"></el-input>
      </el-form-item>
      <el-form-item label="姓名" prop="name">
        <el-input v-model="dataForm.name" placeholder="姓名"></el-input>
      </el-form-item>
      <el-form-item label="账号" prop="username">
        <el-input v-model="dataForm.username" placeholder="账号"></el-input>
      </el-form-item>
      <el-form-item label="ip地址" prop="ip">
        <el-input v-model="dataForm.ip" placeholder="ip地址"></el-input>
      </el-form-item>
      <el-form-item label="mac地址" prop="mac">
        <el-input v-model="dataForm.mac" placeholder="mac地址"></el-input>
      </el-form-item>
      <el-form-item label="笔记本账号" prop="laptopUsername">
        <el-input
          v-model="dataForm.laptopUsername"
          placeholder="笔记本账号"
        ></el-input>
      </el-form-item>
      <el-form-item label="笔记本ip地址" prop="laptopIp">
        <el-input v-model="dataForm.laptopIp" placeholder="笔记本ip"></el-input>
      </el-form-item>
      <el-form-item label="笔记本mac地址" prop="laptopMac">
        <el-input
          v-model="dataForm.laptopMac"
          placeholder="笔记本mac地址"
        ></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="comment">
        <el-input v-model="dataForm.comment" placeholder="备注"></el-input>
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-input
          disabled
          v-model="dataForm.updateTime"
          placeholder="更新时间"
        ></el-input>
      </el-form-item>
      <!-- <el-form-item label="限速值" prop="speedLimit">
        <el-select v-model="dataForm.speedLimit" placeholder="请选择">
          <el-option
            v-for="item in sloptions"
            :key="item"
            :label="item"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item> -->
      <el-form-item label="telnet已绑定ip" prop="ifBind">
        <el-radio v-model="dataForm.ifBind" label="1">是</el-radio>
        <el-radio v-model="dataForm.ifBind" label="2">否</el-radio>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { dateFormat } from "@/utils/dateUtil";
export default {
  data() {
    return {
      visible: false,
      dataForm: {
        id: 0,
        office: "",
        department: "",
        name: "",
        username: "",
        ip: "",
        mac: "",
        laptopUsername: "",
        laptopIp: "",
        laptopMac: "",
        comment: "",
        updateTime: dateFormat("YYYY-mm-dd HH:MM:SS", new Date()),
        speedLimit: "",
        ifBind: "1",
      },
      sloptions: [null, 500, 1000, 2000],
      dataRule: {
        ifBind: [
          {
            required: true,
            message: "telnet已绑定ip不能为空",
            trigger: "blur",
          },
        ],
        office: [
          { required: true, message: "办公室不能为空", trigger: "blur" },
        ],
        department: [
          { required: true, message: "部门不能为空", trigger: "blur" },
        ],
        name: [{ required: true, message: "姓名不能为空", trigger: "blur" }],
        username: [
          { required: false, message: "账号不能为空", trigger: "blur" },
        ],
        ip: [
          { required: false, message: "ip地址不能为空", trigger: "blur" },
          {
            pattern:
              "^192.168.(0|[1-9]\\d{0,1}|1\\d\\d|2[0-4]\\d|25[0-5]).(0|[1-9]\\d{0,1}|1\\d\\d|2[0-4]\\d|25[0-4])$",
            message: "格式为 192.168.x.x ( x 的范围为 0 - 255 )",
          },
        ],
        mac: [
          { required: false, message: "mac地址不能为空", trigger: "blur" },
          {
            pattern: "^[a-f0-9]{4}(-[a-f0-9]{4}){2}$",
            message: "格式需为 xxxx-xxxx-xxxx",
          },
        ],
        laptopUsername: [
          { required: false, message: "笔记本账号不能为空", trigger: "blur" },
        ],
        laptopIp: [
          { required: false, message: "笔记本ip不能为空", trigger: "blur" },
          {
            pattern:
              "^192.168.(0|[1-9]\\d{0,1}|1\\d\\d|2[0-4]\\d|25[0-5]).(0|[1-9]\\d{0,1}|1\\d\\d|2[0-4]\\d|25[0-4])$",
            message: "格式为 192.168.x.x ( x 的范围为 0 - 255 )",
          },
        ],
        laptopMac: [
          { required: false, message: "笔记本mac不能为空", trigger: "blur" },
          {
            pattern: "^[a-f0-9]{4}(-[a-f0-9]{4}){2}$",
            message: "格式需为 xxxx-xxxx-xxxx",
          },
        ],
        comment: [
          { required: false, message: "备注不能为空", trigger: "blur" },
        ],
        updateTime: [
          { required: false, message: "更新时间不能为空", trigger: "blur" },
        ],
        speedLimit: [
          { required: false, message: "限速值不能为空", trigger: "blur" },
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
              `/router/dechangipinfo/info/${this.dataForm.id}`
            ),
            method: "get",
            params: this.$http.adornParams(),
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.dataForm.office = data.dechangIpInfo.office;
              this.dataForm.department = data.dechangIpInfo.department;
              this.dataForm.name = data.dechangIpInfo.name;
              this.dataForm.username = data.dechangIpInfo.username;
              this.dataForm.ip = data.dechangIpInfo.ip;
              this.dataForm.mac = data.dechangIpInfo.mac;
              this.dataForm.laptopUsername = data.dechangIpInfo.laptopUsername;
              this.dataForm.laptopIp = data.dechangIpInfo.laptopIp;
              this.dataForm.laptopMac = data.dechangIpInfo.laptopMac;
              this.dataForm.comment = data.dechangIpInfo.comment;
              this.dataForm.updateTime = data.dechangIpInfo.updateTime;
              this.dataForm.speedLimit = data.dechangIpInfo.speedLimit;
            }
          });
        }
      });
    },

    // 表单提交
    dataFormSubmit() {
      this.$refs["dataForm"].validate((valid) => {
        if (valid) {
          let url;
          if (this.dataForm.ifBind == 2) {
            url = `/router/dechangipinfo/${
              !this.dataForm.id ? "ipMacBinding" : "update"
            }`;
          } else {
            url = `/router/dechangipinfo/${
              !this.dataForm.id ? "save" : "update"
            }`;
          }
          this.$http({
            url: this.$http.adornUrl(url),
            method: "post",
            data: this.$http.adornData({
              id: this.dataForm.id || undefined,
              office: this.dataForm.office,
              department: this.dataForm.department,
              name: this.dataForm.name,
              username: this.dataForm.username,
              ip: this.dataForm.ip,
              mac: this.dataForm.mac,
              laptopUsername: this.dataForm.laptopUsername,
              laptopIp: this.dataForm.laptopIp,
              laptopMac: this.dataForm.laptopMac,
              comment: this.dataForm.comment,
              updateTime: this.dataForm.updateTime,
              speedLimit: this.dataForm.speedLimit,
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
  /* watch: {
    ifBind : {
      handler(newData) {
        console.log(newData);
        if (newData == "2") {
          this.dataRule.ip.required = true;
        }
      }
    }
  }, */
};
</script>
