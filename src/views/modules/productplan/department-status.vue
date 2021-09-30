<template>
  <div>
    <el-row :gutter="10">
      <el-col :span="3">
        <!-- 机台树 -->

        <el-tree
          :data="menus"
          :props="defaultProps"
          :expand-on-click-node="false"
          node-key="deptid"
          :default-expanded-keys="expandedKey"
          ref="menuTree"
          @node-click="openStatus"
        >
        </el-tree
      ></el-col>

      <!-- 生产计划 -->
      <el-col :span="21"
        ><el-form :inline="true" :model="dataForm">
          <el-form-item>
            <el-input v-model="search" placeholder="输入机名搜索" />
          </el-form-item>
          <el-form-item>
            <!-- 查询所有机台 -->
            <el-button type="primary" @click="getDataList"
              >查询所有机台</el-button
            >
            <!-- 刷新 -->
            <el-button type="primary" @click="refresh">刷新</el-button>
            <!-- 导出按钮 -->
            <el-button @click="setExport2Excel" type="primary" class="button"
              >导出</el-button
            >
          </el-form-item>
        </el-form>
        <el-table
          class="table"
          height="650"
          :data="
            dataList.filter(
              (data) =>
                !search ||
                data.deptname.toLowerCase().includes(search.toLowerCase())
            )
          "
          border
          v-loading="dataListLoading"
          style="width: 100%"
          stripe
          size="mini"
        >
          <el-table-column
            prop="deptname"
            header-align="center"
            align="center"
            label="机名"
          >
          </el-table-column>
          <el-table-column
            prop="status"
            header-align="center"
            align="center"
            label="机台状态（0停机，1开机）"
            sortable
          >
          </el-table-column>
          <!--  <el-table-column
            align="right"
          >
           <template slot="header" slot-scope="scope">
              <el-input
                v-model="search"
                size="mini"
                placeholder="输入关键字搜索"
              />
            </template>
          </el-table-column> -->
        </el-table>
        <!-- <el-pagination
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="pageIndex"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pageSize"
          :total="totalPage"
          layout="total, sizes, prev, pager, next, jumper"
        >
        </el-pagination> -->
      </el-col>
    </el-row>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import FileSaver from "file-saver";
import XLSX2 from "xlsx";
export default {
  //import引入的组件需要注入到对象中才能使用
  props: {},
  data() {
    return {
      pCid: [],
      draggable: false,
      updateNodes: [],
      maxLevel: 0,
      title: "",
      dialogType: "", //edit,add
      category: {
        deptname: "",
        parentid: 0,
        ilevel: 0,
        showStatus: 1,
        iorder: 0,
        //productUnit: "",
        //icon: "",
        deptid: null,
      },
      dialogVisible: false,
      menus: [], //机台树
      expandedKey: [],
      defaultProps: {
        children: "children",
        label: "deptname",
      },
      dataForm: {
        key: "",
      },
      dataList: [], //机台数据列表
      tempDeptid: "0", //临时机台id，负数为区，整数
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      addOrUpdateVisible: false,
      search: "", //筛序
    };
  },
  components: {},
  //计算属性 类似于data概念
  computed: {},

  //获取数据
  activated() {},

  //监控data中的数据变化
  watch: {},
  //方法集合
  methods: {
    // 导出excel表格
    setExport2Excel() {
      // 设置当前日期
      let time = new Date();
      let year = time.getFullYear();
      let month = time.getMonth() + 1;
      let day = time.getDate();
      let name = year + "" + month + "" + day;
      // console.log(name)
      // .table要导出的是哪一个表格
      var wb = XLSX2.utils.table_to_book(document.querySelector(".table"));
      var wbout = XLSX2.write(wb, {
        bookType: "xlsx",
        bookSST: true,
        type: "array",
      });
      try {
        // name+'.xlsx'表示导出的excel表格名字
        FileSaver.saveAs(
          new Blob([wbout], { type: "application/octet-stream" }),
          name + ".xlsx"
        );
      } catch (e) {
        if (typeof console !== "undefined") console.log(e, wbout);
      }
      return wbout;
    },

    //获取菜单
    getMenus() {
      this.$http({
        url: this.$http.adornUrl("/productionplan/department/list/tree"),
        method: "get",
      }).then(({ data }) => {
        //console.log("成功获取到菜单数据...", data.data);
        this.menus = data.data;
        this.getDataList();
      });
    },

    //获取所有机台展示到页面
    getDataList() {
      //console.log(this.menus);
      this.dataList = [];
      this.menus.forEach((element) => {
        element.children.forEach((element1) => {
          this.dataList.push(element1);
        });
      });
      //console.log(this.dataList);
    },

    //刷新页面
    refresh() {
      console.log("当前临时id");
      console.log(this.tempDeptid);
      this.$http({
        url: this.$http.adornUrl(
          "/productionplan/department/list/" + this.tempDeptid
        ),
        method: "get",
      }).then(({ data }) => {
        console.log("成功获取到菜单数据...", data.data);
        this.dataList = data.data;
      });
    },

    //根据机台获取机台状态
    openStatus(data) {
      //console.log(data);
      //如果parentid为null，传子项到表中，不为null，传本身到表中
      this.tempDeptid = data.deptid;
      if (data.parentid == null) {
        this.tempDeptid = "-" + data.deptid;
        this.dataList = data.children;
      } else this.dataList = [data];
    },
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {
    this.getMenus();
  },
  //生命周期 - 挂载完成（可以访问DOM元素）
  mounted() {},
  beforeCreate() {}, //生命周期 - 创建之前
  beforeMount() {}, //生命周期 - 挂载之前
  beforeUpdate() {}, //生命周期 - 更新之前
  updated() {}, //生命周期 - 更新之后
  beforeDestroy() {}, //生命周期 - 销毁之前
  destroyed() {}, //生命周期 - 销毁完成
  activated() {}, //如果页面有keep-alive缓存功能，这个函数会触发
};
</script>
<style scoped>
</style>