<!--  -->
<template>
  <div class="">
    <!-- 查询条件 -->
    <el-form :inline="true" :model="formInline" class="demo-form-inline">
      <el-form-item>
        <el-select v-model="formInline.condition" filterable>
          <el-option label="姓名" value="em_name"></el-option>
          <el-option label="工号" value="em_code"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-input v-model="formInline.cvalue" placeholder="参数"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="onSubmit">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 查询出的人员信息 -->

    <el-table
      :data="emData"
      style="width: 100%"
      height="350"
      v-loading="dataListLoading"
    >
      <el-table-column fixed prop="emName" label="员工姓名" width="220">
      </el-table-column>
      <el-table-column prop="emcode" label="员工工号" width="220">
      </el-table-column>
      <el-table-column prop="emDeptid" label="部门名称" width="220">
      </el-table-column>
      <el-table-column prop="emZw" label="职位" width="220"> </el-table-column>
      <el-table-column prop="emMobile" label="员工电话" width="220">
      </el-table-column>
      <el-table-column prop="emPhoto" label="员工照片" width="220">
        <template slot-scope="scope">
          <el-button
            circle
            type="info"
            icon="el-icon-search"
            @click="getPhoto(scope.row.emPhoto)"
          >
          </el-button>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="220">
        <template slot-scope="scope">
          <el-button
            @click.native.prevent="deleteRow(scope.$index, emData)"
            type="text"
            size="small"
          >
            添加
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- ====================弹窗区==================== -->
    <!-- 领料人图片 -->
    <el-dialog :visible.sync="getPhotoVisible" width="30%">
      <img width="100%" :src="photoUrl" />
    </el-dialog>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';

export default {
  //import引入的组件需要注入到对象中才能使用
  components: {},
  data() {
    //这里存放数据
    return {
      //查询人员信息条件
      formInline: {
        condition: "em_name",
        cvalue: "",
      },
      //查询出的人员信息表格
      emData: [],
      //人员信息表格加载
      dataListLoading: false,
      //人员信息个人图片弹窗状态，照片地址
      getPhotoVisible: false,
      photoUrl: "",
    };
  },
  //监听属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    // 获取数据列表
    onSubmit() {
      if (this.formInline.cvalue == null || this.formInline.cvalue == "") {
        this.$message.error("请填写参数");
        return;
      }
      this.dataListLoading = true;
      this.$http({
        url:
          this.formInline.condition == "em_name"
            ? this.$http.adornUrl(
                "/warehouse/tblem/name/" + this.formInline.cvalue
              )
            : this.$http.adornUrl(
                "/warehouse/tblem/code/" + this.formInline.cvalue
              ),
        method: "get",
        /* params: this.$http.adornParams({
          page: this.pageIndex,
          limit: this.pageSize,
          key: this.dataForm.key,
        }), */
      }).then(({ data }) => {
        if (data && data.code === 0) {
          //console.log(data.tblEm);
          this.emData = data.tblEm;
        } else {
          this.emData = [];
        }
        this.dataListLoading = false;
      });
    },

    //获取当前人员信息照片
    getPhoto(photo) {
      console.log(photo);
      if (photo == null || photo == "") {
        this.$message.error("领料人暂无照片");
      } else this.getPhotoVisible = true;
      this.photoUrl = photo;
    },
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {},
  //生命周期 - 挂载完成（可以访问DOM元素）
  mounted() {},
  beforeCreate() {}, //生命周期 - 创建之前
  beforeMount() {}, //生命周期 - 挂载之前
  beforeUpdate() {}, //生命周期 - 更新之前
  updated() {}, //生命周期 - 更新之后
  beforeDestroy() {}, //生命周期 - 销毁之前
  destroyed() {}, //生命周期 - 销毁完成
  activated() {}, //如果页面有keep-alive缓存功能，这个函数会触发
};
</script>
<style scoped>
/* @import url(); 引入公共css类 */
</style>