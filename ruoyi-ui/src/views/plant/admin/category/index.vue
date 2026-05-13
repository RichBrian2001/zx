<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch" label-width="82px">
      <el-form-item label="分类名称" prop="categoryName">
        <el-input
          v-model="queryParams.categoryName"
          placeholder="请输入分类名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="分类编码" prop="categoryCode">
        <el-input
          v-model="queryParams.categoryCode"
          placeholder="请输入分类编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option
            v-for="dict in dict.type.sys_normal_disable"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['plant:category:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="el-icon-sort"
          size="mini"
          @click="toggleExpandAll"
        >展开/折叠</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
      v-if="refreshTable"
      v-loading="loading"
      :data="categoryList"
      row-key="categoryId"
      :default-expand-all="isExpandAll"
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column prop="categoryId" label="分类ID" width="100" align="center" />
      <el-table-column prop="parentId" label="父级ID" width="100" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.parentId === 0 ? '0' : scope.row.parentId || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="ancestors" label="祖级链路" min-width="180" show-overflow-tooltip>
        <template slot-scope="scope">
          <span>{{ scope.row.ancestors || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="categoryName" label="分类名称" min-width="220" show-overflow-tooltip />
      <el-table-column prop="categoryCode" label="分类编码" min-width="180" show-overflow-tooltip />
      <el-table-column prop="orderNum" label="排序" width="90" align="center" />
      <el-table-column prop="status" label="状态" width="100" align="center">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column prop="parentName" label="上级分类" min-width="160" show-overflow-tooltip>
        <template slot-scope="scope">
          <span>{{ scope.row.parentId === 0 ? '顶级分类' : scope.row.parentName || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="remark" label="备注" min-width="180" show-overflow-tooltip>
        <template slot-scope="scope">
          <span>{{ scope.row.remark || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="260">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['plant:category:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-plus"
            @click="handleAdd(scope.row)"
            v-hasPermi="['plant:category:add']"
          >新增</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['plant:category:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="title" :visible.sync="open" width="620px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="92px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="上级分类" prop="parentId">
              <treeselect
                v-model="form.parentId"
                :options="categoryOptions"
                :normalizer="normalizer"
                placeholder="请选择上级分类"
                no-results-text="暂无分类"
                no-options-text="暂无分类"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="分类名称" prop="categoryName">
              <el-input v-model="form.categoryName" placeholder="请输入分类名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="分类编码" prop="categoryCode">
              <el-input v-model="form.categoryCode" placeholder="请输入分类编码" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="orderNum">
              <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in dict.type.sys_normal_disable"
                  :key="dict.value"
                  :label="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import {
  addCategory,
  categoryTreeSelect,
  delCategory,
  getCategory,
  listCategory,
  listCategoryExcludeChild,
  updateCategory
} from '@/api/plant/category'

export default {
  name: 'PlantAdminCategory',
  dicts: ['sys_normal_disable'],
  components: { Treeselect },
  data() {
    return {
      loading: true,
      showSearch: true,
      categoryList: [],
      categoryOptions: [],
      title: '',
      open: false,
      isExpandAll: true,
      refreshTable: true,
      queryParams: {
        categoryName: undefined,
        categoryCode: undefined,
        status: undefined
      },
      form: {},
      rules: {
        parentId: [
          { required: true, message: '上级分类不能为空', trigger: 'change' }
        ],
        categoryName: [
          { required: true, message: '分类名称不能为空', trigger: 'blur' }
        ],
        orderNum: [
          { required: true, message: '显示排序不能为空', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '状态不能为空', trigger: 'change' }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listCategory(this.queryParams).then(response => {
        this.categoryList = this.handleTree(response.data, 'categoryId')
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    buildRootOptions(children) {
      return [{
        id: 0,
        label: '顶级分类',
        children: children || []
      }]
    },
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.id !== undefined ? node.id : node.categoryId,
        label: node.label !== undefined ? node.label : node.categoryName,
        children: node.children
      }
    },
    cancel() {
      this.open = false
      this.reset()
    },
    reset() {
      this.form = {
        categoryId: undefined,
        parentId: 0,
        ancestors: undefined,
        categoryName: undefined,
        categoryCode: undefined,
        orderNum: 0,
        status: '0',
        remark: undefined
      }
      this.resetForm('form')
    },
    handleQuery() {
      this.getList()
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.handleQuery()
    },
    toggleExpandAll() {
      this.refreshTable = false
      this.isExpandAll = !this.isExpandAll
      this.$nextTick(() => {
        this.refreshTable = true
      })
    },
    handleAdd(row) {
      this.reset()
      this.title = '添加植物分类'
      this.form.parentId = row ? row.categoryId : 0
      categoryTreeSelect().then(response => {
        this.categoryOptions = this.buildRootOptions(response.data || [])
        this.open = true
      })
    },
    handleUpdate(row) {
      this.reset()
      getCategory(row.categoryId).then(response => {
        this.form = response.data
        this.title = '修改植物分类'
        listCategoryExcludeChild(row.categoryId).then(optionResponse => {
          this.categoryOptions = this.buildRootOptions(optionResponse.data || [])
          this.open = true
        })
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) {
          return
        }
        if (this.form.categoryId !== undefined) {
          updateCategory(this.form).then(() => {
            this.$modal.msgSuccess('修改成功')
            this.open = false
            this.getList()
          })
        } else {
          addCategory(this.form).then(() => {
            this.$modal.msgSuccess('新增成功')
            this.open = false
            this.getList()
          })
        }
      })
    },
    handleDelete(row) {
      this.$modal.confirm('是否确认删除分类"' + row.categoryName + '"？').then(() => {
        return delCategory(row.categoryId)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess('删除成功')
      }).catch(() => {})
    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .vue-treeselect__control {
  min-height: 32px;
}
</style>