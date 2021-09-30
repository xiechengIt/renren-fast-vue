<template>
  <div class="mod-config">
    <!-- <el-input placeholder="输入关键字进行过滤" v-model="filterText"> </el-input> -->
    <el-button type="primary" :disabled="ruleForm.parentid == ''"
      >添加同级</el-button
    >
    <el-button type="primary" :disabled="ruleForm.parentid != null"
      >添加子级</el-button
    >
    <el-button
      type="danger"
      :disabled="ruleForm.parentid == '' || ruleForm.parentid == null"
      >删除节点</el-button
    >
    <el-row :gutter="20">
      <el-col :span="6">
        <!-- 机台树 -->
        <el-tree
          :data="menus"
          :props="defaultProps"
          :expand-on-click-node="false"
          node-key="deptid"
          :default-expanded-keys="expandedKey"
          ref="menuTree"
          @node-click="openDetail"
        >
        </el-tree
      ></el-col>
      <el-col :span="10">
        <el-form
          :model="ruleForm"
          :rules="rules"
          ref="ruleForm"
          label-width="100px"
        >
          <el-form-item label="编号" prop="deptid">
            <el-input
              disabled
              v-model="ruleForm.deptid"
            ></el-input> </el-form-item
          ><el-form-item label="上级编号" prop="parentid">
            <el-input
              disabled
              v-model="ruleForm.parentid"
            ></el-input> </el-form-item
          ><el-form-item label="名称" prop="deptname">
            <el-input v-model="ruleForm.deptname"></el-input> </el-form-item
          ><el-form-item label="备注" prop="remark">
            <el-input type="textarea" v-model="ruleForm.remark"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')"
              >保存</el-button
            >
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  data() {
    return {
      //filterText: "",
      //机号树
      menus: [],
      expandedKey: [],
      defaultProps: {
        children: "children",
        label: "deptname",
      },

      //更改表单
      ruleForm: {
        deptid: "",
        parentid: "",
        deptname: "",
        remark: "",
      },

      //表单规则
      rules: {
        deptname: [{ required: true, message: "请输入名称", trigger: "blur" }],
      },
    };
  },
  components: {},
  created() {
    this.getMenus();
  },
  watch: {
    /* filterText(val) {
      console.log(val);
      this.$refs.menuTree.filter(val);
    }, */
  },
  methods: {
    //获取数据列表
    getMenus() {
      this.$http({
        url: this.$http.adornUrl("/productionplan/department/list/tree"),
        method: "get",
      }).then(({ data }) => {
        //console.log("成功获取到菜单数据...", data.data);
        this.menus = data.data;
      });
    },

    //点击获取详细信息
    openDetail(data) {
      //console.log(data);
      this.ruleForm.deptid = data.deptid;
      this.ruleForm.parentid = data.parentid;
      this.ruleForm.deptname = data.deptname;
      this.ruleForm.remark = data.remark;
    },
    /*  // 筛选
    filterNode(value, data) {
      if (!value) return true;
      return data.label.indexOf(value) !== -1;
    }, */

    /* // 每页数
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
            return item.percentage;
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
          url: this.$http.adornUrl("/productionplan/department/delete"),
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
    }, */
  },
};
</script>
