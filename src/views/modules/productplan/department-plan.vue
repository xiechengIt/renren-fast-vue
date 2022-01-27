<template>
  <div>
    <el-row :gutter="10">
      <el-col :span="3">
        <!-- 机台树 -->
        <!-- <el-button type="primary" size="mini" round @click="openPlan(0)"
          >M-plan</el-button
        > -->
        <el-tree
          :data="menus"
          :props="defaultProps"
          :expand-on-click-node="false"
          node-key="deptid"
          :default-expanded-keys="expandedKey"
          @node-drop="handleDrop"
          ref="menuTree"
          @node-click="openPlan"
        >
        </el-tree
      ></el-col>

      <!-- 生产计划 -->
      <el-col :span="21"
        ><el-form
          :inline="true"
          :model="dataForm"
          @keyup.enter.native="getDataList()"
        >
          <el-form-item>
            <el-input
              v-model="dataForm.key"
              placeholder="参数名"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item>
            <el-button @click="getDataList()">查询</el-button>
            <!-- <el-button type="primary">批量新增</el-button> -->
            <el-button type="primary" @click="addOrUpdateHandle()"
              >新增</el-button
            >
            <el-button
              type="danger"
              @click="deleteHandle()"
              :disabled="dataListSelections.length <= 0"
              >批量删除</el-button
            >
            <el-button
              @click="finishHandle()"
              type="primary"
              :disabled="dataListSelections.length <= 0"
              >手工结案</el-button
            >
            <el-button type="primary" :disabled="dataListSelections.length <= 0"
              >审核</el-button
            >
            <el-button type="primary" :disabled="dataListSelections.length <= 0"
              >反审核</el-button
            >
            <el-button
              type="primary"
              :disabled="
                dataListSelections.length <= 0 || dataListSelections.length > 1
              "
              >记录上移</el-button
            >
            <el-button
              type="primary"
              :disabled="
                dataListSelections.length <= 0 || dataListSelections.length > 1
              "
              >记录下移</el-button
            ><!-- 导出按钮 -->
            <el-button @click="setExport2Excel" type="primary" class="button"
              >导出</el-button
            >
          </el-form-item>
        </el-form>
        <el-table
          class="table"
          height="650"
          :data="dataList"
          border
          v-loading="dataListLoading"
          @selection-change="selectionChangeHandle"
          style="width: 100%"
          stripe
          size="mini"
        >
          <el-table-column
            type="selection"
            header-align="center"
            align="center"
            width="50"
          >
          </el-table-column>
          <el-table-column
            prop="machineId"
            header-align="center"
            align="center"
            label="机号"
            sortable
          >
          </el-table-column>
          <el-table-column
            prop="machineName"
            header-align="center"
            align="center"
            label="机名"
          >
          </el-table-column>
          <el-table-column
            prop="cardId"
            header-align="center"
            align="center"
            label="卡号"
          >
          </el-table-column>
          <el-table-column
            prop="code"
            header-align="center"
            align="center"
            label="代码"
          >
          </el-table-column>
          <el-table-column
            prop="itemName"
            header-align="center"
            align="center"
            label="品名"
          >
          </el-table-column>
          <el-table-column
            prop="billNum"
            header-align="center"
            align="center"
            label="单据编号"
          >
          </el-table-column>
          <el-table-column
            prop="specification"
            header-align="center"
            align="center"
            label="规格型号"
          >
          </el-table-column>
          <el-table-column
            prop="capacityH"
            header-align="center"
            align="center"
            label="产能H"
          >
          </el-table-column>
          <el-table-column
            prop="slotCount"
            header-align="center"
            align="center"
            label="穴数"
          >
          </el-table-column>
          <el-table-column
            prop="pieceWeightG"
            header-align="center"
            align="center"
            label="单重g"
          >
          </el-table-column>
          <el-table-column
            prop="workOrderId"
            header-align="center"
            align="center"
            label="工单号"
          >
          </el-table-column>
          <el-table-column
            prop="orderId"
            header-align="center"
            align="center"
            label="订单号"
          >
          </el-table-column>
          <el-table-column
            prop="autoFinish"
            header-align="center"
            align="center"
            label="结案"
          >
          </el-table-column>
          <el-table-column
            prop="productPlanAmount"
            header-align="center"
            align="center"
            label="计划生产数量"
          >
          </el-table-column>
          <el-table-column
            prop="endAmount"
            header-align="center"
            align="center"
            label="实际完成数量"
          >
          </el-table-column>
          <el-table-column
            prop="restAmount"
            header-align="center"
            align="center"
            label="实际剩余数量"
          >
          </el-table-column>
          <el-table-column
            prop="beginTime"
            header-align="center"
            align="center"
            label="实际开始日期"
          >
          </el-table-column>
          <el-table-column
            prop="manualFinish"
            header-align="center"
            align="center"
            label="手工结案"
          >
          </el-table-column>
          <el-table-column
            prop="restTime"
            header-align="center"
            align="center"
            label="实际剩余工时"
          >
          </el-table-column>
          <el-table-column
            prop="endTime"
            header-align="center"
            align="center"
            label="实际结束日期"
          >
          </el-table-column>
          <el-table-column
            prop="updateTime"
            header-align="center"
            align="center"
            label="更新日期"
          >
          </el-table-column>
          <el-table-column
            prop="color"
            header-align="center"
            align="center"
            label="颜色"
          >
          </el-table-column>
          <el-table-column
            prop="materialNo"
            header-align="center"
            align="center"
            label="材料料号"
          >
          </el-table-column>
          <el-table-column
            prop="materialItemName"
            header-align="center"
            align="center"
            label="材料品名"
          >
          </el-table-column>
          <el-table-column
            prop="materialTotalKg"
            header-align="center"
            align="center"
            label="理论材料总量kg"
          >
          </el-table-column>
          <el-table-column
            prop="materialUsedKg"
            header-align="center"
            align="center"
            label="理论材料已用kg"
          >
          </el-table-column>
          <el-table-column
            prop="materialRestKg"
            header-align="center"
            align="center"
            label="理论材料结余kg"
          >
          </el-table-column>
          <el-table-column
            prop="advancedTimeH"
            header-align="center"
            align="center"
            label="提前期H"
          >
          </el-table-column>
          <el-table-column
            prop="makeBillTime"
            header-align="center"
            align="center"
            label="制单日期"
          >
          </el-table-column>
          <el-table-column
            prop="status"
            header-align="center"
            align="center"
            label="状态"
          >
          </el-table-column>
          <el-table-column
            prop="modelNo"
            header-align="center"
            align="center"
            label="模具编号"
          >
          </el-table-column>
          <!-- <el-table-column
                prop="计划开始日期"
                header-align="center"
                align="center"
                label="${column.comments}"
            >
            </el-table-column>
            <el-table-column
                prop="理论材料总量kg"
                header-align="center"
                align="center"
                label="${column.comments}"
            >
            </el-table-column>
            <el-table-column
                prop="modelNo"
                header-align="center"
                align="center"
                label="模具编号"
            >
            </el-table-column> -->
          <el-table-column
            fixed="right"
            header-align="center"
            align="center"
            width="150"
            label="操作"
          >
            <template slot-scope="scope">
              <el-button
                type="text"
                size="small"
                @click="addOrUpdateHandle(scope.row.id)"
                >修改</el-button
              >
              <el-button
                type="text"
                size="small"
                @click="deleteHandle(scope.row.id)"
                >删除</el-button
              >
            </template>
          </el-table-column>
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
        <add-or-update
          v-if="addOrUpdateVisible"
          ref="addOrUpdate"
          @refreshDataList="getDataList"
        ></add-or-update
      ></el-col>
    </el-row>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
import AddOrUpdate from "./qutblmplan-add-or-update";
import FileSaver from "file-saver";
import XLSX2 from "xlsx";
//import XLSX from "xlsx-style";
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
      menus: [],
      expandedKey: [],
      defaultProps: {
        children: "children",
        label: "deptname",
      },
      dataForm: {
        key: "",
      },
      tempDeptids: [],
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      addOrUpdateVisible: false,
    };
  },
  components: {
    AddOrUpdate,
  },
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

    // setExport2Excel() {
    //   /* generate workbook object from table */
    //   var xlsxParam = { raw: true }; //这个保证表格只进行解析 不做运算
    //   var wb = XLSX2.utils.table_to_book(
    //     document.querySelector(".table"),
    //     xlsxParam
    //   );
    //   //mytable为表格的id名
    //   if (!wb["!merges"]) {
    //     this.$message.warning("无法导出：报表无数据");
    //     return;
    //   }
    //   for (var i = 0; i < 11; i++) {
    //     wb["!cols"][i] = { wpx: 130 };
    //   }
    //   // 样式的文档地址
    //   // https://www.npmjs.com/package/xlsx-style
    //   for (const key in wb) {
    //     if (key.indexOf("!") === -1 && wb[key].v) {
    //       wb[key].s = {
    //         font: {
    //           //字体设置
    //           sz: 13,
    //           bold: false,
    //           color: {
    //             rgb: "000000", //十六进制，不带#
    //           },
    //         },
    //         alignment: {
    //           //文字居中
    //           horizontal: "center",
    //           vertical: "center",
    //           wrap_text: true,
    //         },
    //         border: {
    //           // 设置边框
    //           top: { style: "thin" },
    //           bottom: { style: "thin" },
    //           left: { style: "thin" },
    //           right: { style: "thin" },
    //         },
    //       };
    //     }
    //   }
    //   var data = this.addRangeBorder(wb["!merges"], wb); //合并项添加边框
    //   var filedata = this.sheet2blob(data);
    //   this.openDownloadDialog(filedata, this.todayTimeString + "-xxx报表.xlsx");
    // },
    // //为合并项添加边框
    // addRangeBorder(range, ws) {
    //   let arr = [
    //     "A",
    //     "B",
    //     "C",
    //     "D",
    //     "E",
    //     "F",
    //     "G",
    //     "H",
    //     "I",
    //     "J",
    //     "K",
    //     "L",
    //     "M",
    //     "N",
    //     "O",
    //     "P",
    //     "Q",
    //     "R",
    //     "S",
    //     "T",
    //     "U",
    //     "V",
    //     "W",
    //     "X",
    //     "Y",
    //     "Z",
    //   ];

    //   range.forEach((item) => {
    //     let startColNumber = Number(item.s.r),
    //       endColNumber = Number(item.e.r);
    //     let startRowNumber = Number(item.s.c),
    //       endRowNumber = Number(item.e.c);
    //     const test = ws[arr[startRowNumber] + (startColNumber + 1)];
    //     for (let col = startColNumber; col <= endColNumber; col++) {
    //       for (let row = startRowNumber; row <= endRowNumber; row++) {
    //         ws[arr[row] + (col + 1)] = test;
    //       }
    //     }
    //   });
    //   return ws;
    // },
    // //将一个sheet转成最终的excel文件的blob对象，然后利用URL.createObjectURL下载
    // sheet2blob(sheet, sheetName) {
    //   sheetName = sheetName || "sheet1";
    //   var workbook = {
    //     SheetNames: [sheetName],
    //     Sheets: {},
    //   };
    //   workbook.Sheets[sheetName] = sheet; // 生成excel的配置项

    //   var wopts = {
    //     bookType: "xlsx", // 要生成的文件类型
    //     bookSST: false, // 是否生成Shared String Table，官方解释是，如果开启生成速度会下降，但在低版本IOS设备上有更好的兼容性
    //     type: "binary",
    //   };
    //   var wbout = XLSX.write(workbook, wopts);
    //   var blob = new Blob([s2ab(wbout)], {
    //     type: "application/octet-stream",
    //   }); // 字符串转ArrayBuffer
    //   function s2ab(s) {
    //     var buf = new ArrayBuffer(s.length);
    //     var view = new Uint8Array(buf);
    //     for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xff;
    //     return buf;
    //   }
    //   return blob;
    // },
    // openDownloadDialog(url, saveName) {
    //   if (typeof url == "object" && url instanceof Blob) {
    //     url = URL.createObjectURL(url); // 创建blob地址
    //   }
    //   var aLink = document.createElement("a");
    //   aLink.href = url;
    //   aLink.download = saveName || ""; // HTML5新增的属性，指定保存文件名，可以不要后缀，注意，file:///模式下不会生效
    //   var event;
    //   if (window.MouseEvent) event = new MouseEvent("click");
    //   else {
    //     event = document.createEvent("MouseEvents");
    //     event.initMouseEvent(
    //       "click",
    //       true,
    //       false,
    //       window,
    //       0,
    //       0,
    //       0,
    //       0,
    //       0,
    //       false,
    //       false,
    //       false,
    //       false,
    //       0,
    //       null
    //     );
    //   }
    //   aLink.dispatchEvent(event);
    // },

    //获取菜单
    getMenus() {
      this.$http({
        url: this.$http.adornUrl("/productionplan/department/list/tree"),
        method: "get",
      }).then(({ data }) => {
        //console.log("成功获取到菜单数据...", data.data);
        this.menus = data.data;
      });
    },

    //根据机台获取计划
    openPlan(data) {
      //console.log(data);
      let deptid = [data.deptid];
      //点击的是区号，则将children的所有deptid加入到deptid数组
      if (data.parentid == null) {
        deptid = [];
        data.children.forEach((element) => {
          deptid.push(element.deptid);
        });
      }
      console.log(deptid);
      //将数据放入全局参数tempDeptids
      this.tempDeptids = deptid;
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/productionplan/qutblmplan/list"),
        method: "post",
        data: this.$http.adornParams({
          deptid: deptid,
          page: JSON.stringify(this.pageIndex),
          limit: JSON.stringify(this.pageSize),
          key: this.dataForm.key,
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

    // 获取数据列表
    getDataList() {
      //将全局参数初始化
      this.tempDeptids = [];
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/productionplan/qutblmplan/list"),
        method: "post",
        data: this.$http.adornParams({
          page: JSON.stringify(this.pageIndex),
          limit: JSON.stringify(this.pageSize),
          key: this.dataForm.key,
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
    //全局参数this.tempDeptids长度大于0请求有参数list，无则getDataList
    getTempList() {
      if (this.tempDeptids.length > 0) {
        this.dataListLoading = true;
        this.$http({
          url: this.$http.adornUrl("/productionplan/qutblmplan/list"),
          method: "post",
          data: this.$http.adornParams({
            deptid: this.tempDeptids,
            page: JSON.stringify(this.pageIndex),
            limit: JSON.stringify(this.pageSize),
            key: this.dataForm.key,
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
      } else {
        this.getDataList();
      }
    },
    // 每页数
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;

      this.getTempList();
    },
    // 当前页
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getTempList();
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
          url: this.$http.adornUrl("/productionplan/qutblmplan/delete"),
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
    //结案处理
    finishHandle(id) {
      var ids = id
        ? [id]
        : this.dataListSelections.map((item) => {
            return item.id;
          });

      this.$confirm(
        `确定对[id=${ids.join(",")}]进行[${id ? "结案" : "批量结案"}]操作?`,
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        }
      ).then(() => {
        this.$http({
          url: this.$http.adornUrl("/productionplan/qutblmplan/finish"),
          method: "post",
          data: this.$http.adornData(ids, false),
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.getTempList();
              },
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },

    //批量删除
    batchDelete() {
      let deptids = [];
      let checkedNodes = this.$refs.menuTree.getCheckedNodes();
      console.log("被选中的元素", checkedNodes);
      for (let i = 0; i < checkedNodes.length; i++) {
        deptids.push(checkedNodes[i].deptid);
      }
      this.$confirm(`是否批量删除【${deptids}】菜单?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$http({
            url: this.$http.adornUrl("/product/category/delete"),
            method: "post",
            data: this.$http.adornData(deptids, false),
          }).then(({ data }) => {
            this.$message({
              message: "菜单批量删除成功",
              type: "success",
            });
            this.getMenus();
          });
        })
        .catch(() => {});
    },

    //批量保存
    batchSave() {
      this.$http({
        url: this.$http.adornUrl("/product/category/update/iorder"),
        method: "post",
        data: this.$http.adornData(this.updateNodes, false),
      }).then(({ data }) => {
        this.$message({
          message: "菜单顺序等修改成功",
          type: "success",
        });
        //刷新出新的菜单
        this.getMenus();
        //设置需要默认展开的菜单
        this.expandedKey = this.pCid;
        this.updateNodes = [];
        this.maxLevel = 0;
        // this.pCid = 0;
      });
    },

    //拖拽处理
    handleDrop(draggingNode, dropNode, dropType, ev) {
      console.log("handleDrop: ", draggingNode, dropNode, dropType);
      //1、当前节点最新的父节点id
      let pCid = 0;
      let siblings = null;
      if (dropType == "before" || dropType == "after") {
        pCid =
          dropNode.parent.data.deptid == undefined
            ? 0
            : dropNode.parent.data.deptid;
        siblings = dropNode.parent.childNodes;
      } else {
        pCid = dropNode.data.deptid;
        siblings = dropNode.childNodes;
      }
      this.pCid.push(pCid);

      //2、当前拖拽节点的最新顺序，
      for (let i = 0; i < siblings.length; i++) {
        if (siblings[i].data.deptid == draggingNode.data.deptid) {
          //如果遍历的是当前正在拖拽的节点
          let ilevel = draggingNode.level;
          if (siblings[i].level != draggingNode.level) {
            //当前节点的层级发生变化
            ilevel = siblings[i].level;
            //修改他子节点的层级
            this.updateChildNodeLevel(siblings[i]);
          }
          this.updateNodes.push({
            deptid: siblings[i].data.deptid,
            iorder: i,
            parentid: pCid,
            ilevel: ilevel,
          });
        } else {
          this.updateNodes.push({ deptid: siblings[i].data.deptid, iorder: i });
        }
      }

      //3、当前拖拽节点的最新层级
      console.log("updateNodes", this.updateNodes);
    },

    //更新子节点等级
    updateChildNodeLevel(node) {
      if (node.childNodes.length > 0) {
        for (let i = 0; i < node.childNodes.length; i++) {
          var cNode = node.childNodes[i].data;
          this.updateNodes.push({
            deptid: cNode.deptid,
            ilevel: node.childNodes[i].level,
          });
          this.updateChildNodeLevel(node.childNodes[i]);
        }
      }
    },

    allowDrop(draggingNode, dropNode, type) {
      //1、被拖动的当前节点以及所在的父节点总层数不能大于3

      //1）、被拖动的当前节点总层数
      console.log("allowDrop:", draggingNode, dropNode, type);
      //
      this.countNodeLevel(draggingNode);
      //当前正在拖动的节点+父节点所在的深度不大于3即可
      let deep = Math.abs(this.maxLevel - draggingNode.level) + 1;
      console.log("深度：", deep);

      //   this.maxLevel
      if (type == "inner") {
        // console.log(
        //   `this.maxLevel：${this.maxLevel}；draggingNode.data.ilevel：${draggingNode.data.ilevel}；dropNode.level：${dropNode.level}`
        // );
        return deep + dropNode.level <= 3;
      } else {
        return deep + dropNode.parent.level <= 3;
      }
    },

    countNodeLevel(node) {
      //找到所有子节点，求出最大深度
      if (node.childNodes != null && node.childNodes.length > 0) {
        for (let i = 0; i < node.childNodes.length; i++) {
          if (node.childNodes[i].level > this.maxLevel) {
            this.maxLevel = node.childNodes[i].level;
          }
          this.countNodeLevel(node.childNodes[i]);
        }
      }
    },

    edit(data) {
      console.log("要修改的数据", data);
      this.dialogType = "edit";
      this.title = "修改分类";
      this.dialogVisible = true;

      //发送请求获取当前节点最新的数据
      this.$http({
        url: this.$http.adornUrl(`/product/category/info/${data.deptid}`),
        method: "get",
      }).then(({ data }) => {
        //请求成功
        console.log("要回显的数据", data);
        this.category.deptname = data.data.deptname;
        this.category.deptid = data.data.deptid;
        //this.category.icon = data.data.icon;
        //this.category.productUnit = data.data.productUnit;
        this.category.parentid = data.data.parentid;
        this.category.ilevel = data.data.ilevel;
        this.category.iorder = data.data.iorder;
        this.category.showStatus = data.data.showStatus;
        /**
         *         parentid: 0,
        ilevel: 0,
        showStatus: 1,
        iorder: 0,
         */
      });
    },

    append(data) {
      console.log("append", data);
      this.dialogType = "add";
      this.title = "添加分类";
      this.dialogVisible = true;
      this.category.parentid = data.deptid;
      this.category.ilevel = data.ilevel * 1 + 1;
      this.category.deptid = null;
      this.category.deptname = "";
      //this.category.icon = "";
      //this.category.productUnit = "";
      this.category.iorder = 0;
      this.category.showStatus = 1;
    },

    submitData() {
      if (this.dialogType == "add") {
        this.addCategory();
      }
      if (this.dialogType == "edit") {
        this.editCategory();
      }
    },

    //修改三级分类数据
    editCategory() {
      var { deptid, deptname, icon, productUnit } = this.category;
      this.$http({
        url: this.$http.adornUrl("/product/category/update"),
        method: "post",
        data: this.$http.adornData(
          { deptid, deptname, icon, productUnit },
          false
        ),
      }).then(({ data }) => {
        this.$message({
          message: "菜单修改成功",
          type: "success",
        });
        //关闭对话框
        this.dialogVisible = false;
        //刷新出新的菜单
        this.getMenus();
        //设置需要默认展开的菜单
        this.expandedKey = [this.category.parentid];
      });
    },

    //添加三级分类
    addCategory() {
      console.log("提交的三级分类数据", this.category);
      this.$http({
        url: this.$http.adornUrl("/product/category/save"),
        method: "post",
        data: this.$http.adornData(this.category, false),
      }).then(({ data }) => {
        this.$message({
          message: "菜单保存成功",
          type: "success",
        });
        //关闭对话框
        this.dialogVisible = false;
        //刷新出新的菜单
        this.getMenus();
        //设置需要默认展开的菜单
        this.expandedKey = [this.category.parentid];
      });
    },

    remove(node, data) {
      var ids = [data.deptid];
      this.$confirm(`是否删除【${data.deptname}】菜单?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$http({
            url: this.$http.adornUrl("/product/category/delete"),
            method: "post",
            data: this.$http.adornData(ids, false),
          }).then(({ data }) => {
            this.$message({
              message: "菜单删除成功",
              type: "success",
            });
            //刷新出新的菜单
            this.getMenus();
            //设置需要默认展开的菜单
            this.expandedKey = [node.parent.data.deptid];
          });
        })
        .catch(() => {});

      console.log("remove", node, data);
    },
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {
    this.getMenus();
    this.getDataList();
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