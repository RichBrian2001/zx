<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch" label-width="82px">
      <el-form-item label="植物名称" prop="plantName">
        <el-input
          v-model="queryParams.plantName"
          placeholder="请输入植物名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="植物分类" prop="categoryId" class="category-query-item">
        <treeselect
          v-model="queryParams.categoryId"
          :options="categoryOptions"
          :normalizer="normalizer"
          placeholder="请选择植物分类"
          no-results-text="暂无分类"
          no-options-text="暂无分类"
        />
      </el-form-item>
      <el-form-item label="养护难度" prop="difficultyLevel">
        <el-select v-model="queryParams.difficultyLevel" placeholder="请选择养护难度" clearable>
          <el-option
            v-for="item in difficultyOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="价格带" prop="priceLevel">
        <el-select v-model="queryParams.priceLevel" placeholder="请选择价格带" clearable>
          <el-option
            v-for="item in priceOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="宠物友好" prop="petSafeFlag">
        <el-select v-model="queryParams.petSafeFlag" placeholder="请选择宠物友好" clearable>
          <el-option
            v-for="item in petSafeOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="上架状态" prop="displayStatus">
        <el-select v-model="queryParams.displayStatus" placeholder="请选择上架状态" clearable>
          <el-option
            v-for="item in displayStatusOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="数据状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择数据状态" clearable>
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
          v-hasPermi="['plant:plant:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['plant:plant:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-collection-tag"
          size="mini"
          :disabled="single"
          @click="handleTagConfig"
          v-hasPermi="['plant:plant:tag']"
        >标签配置</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['plant:plant:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="plantList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="植物编号" align="center" prop="plantId" width="100" />
      <el-table-column label="封面" align="center" width="100">
        <template slot-scope="scope">
          <image-preview v-if="scope.row.coverImage" :src="scope.row.coverImage" :width="48" :height="48" />
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="植物名称" align="center" min-width="160" show-overflow-tooltip>
        <template slot-scope="scope">
          <el-button
            type="text"
            @click="handleView(scope.row)"
            v-hasPermi="['plant:plant:detail']"
          >{{ scope.row.plantName }}</el-button>
          <span v-if="!hasPermission(['plant:plant:detail'])">{{ scope.row.plantName }}</span>
        </template>
      </el-table-column>
      <el-table-column label="分类" align="center" prop="categoryName" min-width="120" show-overflow-tooltip />
      <el-table-column label="难度" align="center" width="100">
        <template slot-scope="scope">
          <span>{{ difficultyLabel(scope.row.difficultyLevel) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="价格带" align="center" width="110">
        <template slot-scope="scope">
          <span>{{ priceLabel(scope.row.priceLevel) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="宠物友好" align="center" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.petSafeFlag === '1' ? 'success' : 'warning'" size="small">
            {{ scope.row.petSafeFlag === '1' ? '友好' : '慎选' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="前台展示" align="center" width="110">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.displayStatus"
            active-value="0"
            inactive-value="1"
            @change="handleDisplayStatusChange(scope.row)"
            v-hasPermi="['plant:plant:edit']"
          />
        </template>
      </el-table-column>
      <el-table-column label="数据状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="排序" align="center" prop="sortNum" width="80" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="160">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="260">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['plant:plant:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-notebook-2"
            @click="handleDetail(scope.row)"
            v-hasPermi="['plant:plant:care']"
          >养护配置</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-collection-tag"
            @click="handleTagConfig(scope.row)"
            v-hasPermi="['plant:plant:tag']"
          >标签配置</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['plant:plant:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

  </div>
</template>

<script>
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import { checkPermi } from '@/utils/permission'
import {
  categoryTreeSelect,
  changePlantDisplayStatus,
  delPlant,
  listPlant
} from '@/api/plant/plant'

export default {
  name: 'PlantAdminPlant',
  components: { Treeselect },
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      plantList: [],
      categoryOptions: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        plantName: undefined,
        categoryId: undefined,
        difficultyLevel: undefined,
        priceLevel: undefined,
        petSafeFlag: undefined,
        displayStatus: undefined,
        status: undefined
      },
      difficultyOptions: [
        { label: 'L1 入门', value: '1' },
        { label: 'L2 进阶', value: '2' },
        { label: 'L3 专业', value: '3' }
      ],
      priceOptions: [
        { label: 'P1 低预算', value: '1' },
        { label: 'P2 中预算', value: '2' },
        { label: 'P3 高预算', value: '3' }
      ],
      petSafeOptions: [
        { label: '友好', value: '1' },
        { label: '慎选', value: '0' }
      ],
      displayStatusOptions: [
        { label: '展示', value: '0' },
        { label: '隐藏', value: '1' }
      ]
    }
  },
  created() {
    this.getCategoryOptions()
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listPlant(this.queryParams).then(response => {
        this.plantList = response.rows
        this.total = response.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    getCategoryOptions() {
      categoryTreeSelect().then(response => {
        this.categoryOptions = response.data || []
      })
    },
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.id,
        label: node.label,
        children: node.children
      }
    },
    difficultyLabel(value) {
      const matched = this.difficultyOptions.find(item => item.value === value)
      return matched ? matched.label : value || '-'
    },
    priceLabel(value) {
      const matched = this.priceOptions.find(item => item.value === value)
      return matched ? matched.label : value || '-'
    },
    hasPermission(value) {
      return checkPermi(value)
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.plantId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.$router.push('/plant-admin/plant/add')
    },
    handleUpdate(row) {
      const plantId = row.plantId || this.ids[0]
      if (!plantId) {
        return
      }
      this.$router.push('/plant-admin/plant/edit/' + plantId)
    },
    handleView(row) {
      const plantId = row && row.plantId ? row.plantId : this.ids[0]
      if (!plantId) {
        return
      }
      this.$router.push('/plant-admin/plant/detail/' + plantId)
    },
    handleDetail(row) {
      const plantId = row && row.plantId ? row.plantId : this.ids[0]
      if (!plantId) {
        return
      }
      this.$router.push('/plant-admin/plant-care/' + plantId)
    },
    handleTagConfig(row) {
      const plantId = row && row.plantId ? row.plantId : this.ids[0]
      if (!plantId) {
        return
      }
      this.$router.push('/plant-admin/plant-tag/' + plantId)
    },
    handleDelete(row) {
      const plantIds = row.plantId || this.ids
      this.$modal.confirm('是否确认删除植物编号为"' + plantIds + '"的数据项？').then(() => {
        return delPlant(plantIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess('删除成功')
      }).catch(() => {})
    },
    handleDisplayStatusChange(row) {
      const text = row.displayStatus === '0' ? '展示' : '隐藏'
      this.$modal.confirm('确认要"' + text + '"植物"' + row.plantName + '"吗？').then(() => {
        return changePlantDisplayStatus({
          plantId: row.plantId,
          displayStatus: row.displayStatus
        })
      }).then(() => {
        this.$modal.msgSuccess(text + '成功')
      }).catch(() => {
        row.displayStatus = row.displayStatus === '0' ? '1' : '0'
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.category-query-item {
  min-width: 260px;
}

::v-deep .category-query-item .vue-treeselect__control,
::v-deep .vue-treeselect__control {
  min-height: 32px;
}

::v-deep .el-image,
::v-deep .image-preview {
  vertical-align: middle;
}
</style>