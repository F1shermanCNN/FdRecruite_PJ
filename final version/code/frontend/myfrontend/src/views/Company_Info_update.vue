```vue
<template>
  <div class="company-info-update-page">
    <div class="container">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回公司信息</button>

      <!-- 错误提示 -->
      <div v-if="error" class="error">{{ error }}</div>

      <!-- 公司信息编辑 -->
      <div class="section" v-if="company">
        <h2 class="section-title">编辑基本信息</h2>
        <div class="form">
          <!-- 公司名称 -->
          <div class="form-group">
            <label>公司名称</label>
            <input v-model="form.name" type="text" class="input" placeholder="请输入公司名称" />
          </div>

          <!-- 企业规模 -->
          <div class="form-group">
            <label>企业规模</label>
            <select v-model="form.size" class="input">
              <option value="0-20人">0-20人</option>
              <option value="20-99人">20-99人</option>
              <option value="100-499人">100-499人</option>
              <option value="500+人">500+人</option>
            </select>
          </div>

          <!-- 是否认证 -->
          <div class="form-group">
            <label>是否认证</label>
            <select v-model="form.verified" class="input">
              <option :value="true">已认证</option>
              <option :value="false">未认证</option>
            </select>
          </div>

          <!-- 简介 -->
          <div class="form-group">
            <label>简介</label>
            <textarea v-model="form.description" class="input textarea" placeholder="请输入公司简介"></textarea>
          </div>

          <!-- 营业执照有效期 -->
          <div class="form-group">
            <label>营业执照有效期（年）</label>
            <input v-model="form.license_period" type="number" class="input" placeholder="请输入有效期" />
          </div>

          <!-- 注册资本 -->
          <div class="form-group">
            <label>注册资本（万元）</label>
            <input v-model="form.registered_capital" type="number" class="input" placeholder="请输入注册资本" />
          </div>

          <!-- 修改基本信息按钮 -->
          <button class="submit-button" @click="submitUpdateCompany">修改基本信息</button>
        </div>
      </div>

      <!-- 地址编辑 -->
      <div class="section" v-if="locations && cities.length">
        <h2 class="section-title">编辑地址</h2>
        <div v-for="(loc, index) in locationForms" :key="loc.id" class="form">
          <h3 class="location-title">地址 {{ index + 1 }}</h3>
          <!-- 城市 -->
          <div class="form-group">
            <label>城市</label>
            <select v-model="locationForms[index].city" class="input">
              <option v-for="city in cities" :key="city.id" :value="city">{{ city.name }}</option>
            </select>
          </div>

          <!-- 详细地址 -->
          <div class="form-group">
            <label>详细地址</label>
            <input v-model="locationForms[index].address" type="text" class="input" placeholder="请输入详细地址" />
          </div>

          <!-- 修改和删除地址按钮 -->
          <div class="button-group">
            <button class="submit-button" @click="submitUpdateLocation(index)">修改地址</button>
            <button class="delete-button" @click="deleteLocation(index)">删除地址</button>
          </div>
        </div>

        <!-- 新增地址 -->
        <div class="form" v-if="showAddForm">
          <h3 class="location-title">新增地址</h3>
          <div class="form-group">
            <label>城市</label>
            <select v-model="newLocationForm.city" class="input">
              <option v-for="city in cities" :key="city.id" :value="city">{{ city.name }}</option>
            </select>
          </div>
          <div class="form-group">
            <label>详细地址</label>
            <input v-model="newLocationForm.address" type="text" class="input" placeholder="请输入详细地址" />
          </div>
          <div class="button-group">
            <button class="submit-button" @click="submitCreateLocation">确认新增地址</button>
            <button class="cancel-button" @click="showAddForm = false">取消</button>
          </div>
        </div>

        <!-- 新增地址按钮 -->
        <button class="add-button" @click="showAddForm = true" v-if="!showAddForm">+ 新增地址</button>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading">加载中...</div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getCompany, updateCompany, getCities, updateCompanyLocation, createCompanyLocation, deleteCompanyLocation } from '../api/api'

const route = useRoute()
const router = useRouter()
const companyId = ref(route.params.id) // 从路由获取 ID

const company = ref(null)
const form = ref({
  name: '',
  size: '',
  verified: false,
  description: null,
  license_period: '',
  registered_capital: ''
})
const originalData = ref({}) // 存储原始 locations 和 tags
const locations = ref([]) // 存储公司地址列表
const locationForms = ref([]) // 地址表单列表
const cities = ref([]) // 城市列表
const loading = ref(true)
const error = ref(null)
const showAddForm = ref(false) // 控制新增地址表单显示
const newLocationForm = ref({ city: null, address: '' }) // 新增地址表单

onMounted(async () => {
  console.log('Full URL:', route.fullPath)
  console.log('companyId:', companyId.value)

  if (!companyId.value) {
    error.value = '未提供公司 ID'
    console.error('加载公司信息失败：未提供公司 ID', {
      context: 'onMounted',
      companyId: companyId.value
    })
    loading.value = false
    return
  }

  try {
    // 获取公司信息
    console.log(`正在调用 getCompany(${companyId.value})`)
    const companyResponse = await getCompany(companyId.value)
    company.value = companyResponse.data
    form.value = {
      name: company.value.name || '',
      size: company.value.size || '',
      verified: company.value.verified || false,
      description: company.value.description || null,
      license_period: company.value.license_period || '',
      registered_capital: company.value.registered_capital || ''
    }
    originalData.value = {
      locations: company.value.locations || [],
      tags: company.value.tags || []
    }
    locations.value = company.value.locations || []
    console.log('公司信息加载成功：', JSON.stringify(company.value, null, 2))

    // 获取城市列表
    console.log('正在调用 getCities()')
    const citiesResponse = await getCities()
    cities.value = citiesResponse.data
    console.log('城市列表加载成功：', JSON.stringify(cities.value, null, 2))

    // 初始化地址表单
    locationForms.value = locations.value.map(loc => ({
      id: loc.id,
      city: cities.value.find(city => city.id === loc.city.id) || null,
      address: loc.address || '',
      company: loc.company
    }))
    console.log('公司地址初始化成功：', JSON.stringify(locationForms.value, null, 2))
  } catch (err) {
    const errorDetails = {
      context: err.config?.url?.includes('company') ? 'getCompany' : 'getCities',
      companyId: companyId.value,
      message: err.message || '未知错误',
      status: err.response?.status,
      data: err.response?.data,
      stack: err.stack
    }
    console.error('加载信息失败：', JSON.stringify(errorDetails, null, 2))
    error.value = `加载信息失败：${err.response?.data?.error || '请检查公司 ID 或稍后重试'}`
  } finally {
    loading.value = false
  }
})

const submitUpdateCompany = async () => {
  // 基本验证
  if (!form.value.name) {
    alert('公司名称不能为空');
    console.error('更新公司信息失败：公司名称不能为空', {
      context: 'submitUpdateCompany',
      form: form.value
    });
    return;
  }

  if (form.value.size && !['0-20人', '20-99人', '100-499人', '500+人'].includes(form.value.size)) {
    alert('企业规模必须是以下选项之一：0-20人, 20-99人, 100-499人, 500+人');
    console.error('更新公司信息失败：无效的企业规模', {
      context: 'submitUpdateCompany',
      form: form.value
    });
    return;
  }

  const currentYear = new Date().getFullYear();
  if (form.value.license_period && parseInt(form.value.license_period) <= currentYear) {
    alert(`营业执照有效期必须大于当前年份（${currentYear}）`);
    console.error('更新公司信息失败：营业执照有效期不合法', {
      context: 'submitUpdateCompany',
      license_period: form.value.license_period,
      currentYear
    });
    return;
  }

  try {
    const data = {
      id: companyId.value,
      name: form.value.name,
      size: form.value.size,
      verified: form.value.verified,
      description: form.value.description,
      license_period: form.value.license_period,
      registered_capital: form.value.registered_capital,
      tags: originalData.value.tags,
      locations: originalData.value.locations
    };
    console.log(`正在调用 updateCompany(${companyId.value})，提交数据：`, JSON.stringify(data, null, 2));
    await updateCompany(companyId.value, data);
    alert('公司基本信息更新成功！');
    console.log('公司基本信息更新成功：', JSON.stringify(data, null, 2));
    router.push(`/company_home/company_info/${companyId.value}`);
  } catch (err) {
    const errorDetails = {
      context: 'updateCompany',
      companyId: companyId.value,
      submittedData: form.value,
      originalData: originalData.value,
      message: err.message || '未知错误',
      status: err.response?.status,
      data: err.response?.data,
      stack: err.stack
    };
    console.error('更新公司信息失败：', JSON.stringify(errorDetails, null, 2));
    alert(`更新公司信息失败：${err.response?.data?.error || '除了公司简介，其他不能为空'}`);
  }
};


const submitUpdateLocation = async (index) => {
  const locationForm = locationForms.value[index]
  // 基本验证
  if (!locationForm.city) {
    error.value = `地址 ${index + 1}：城市不能为空`
    console.error('更新公司地址失败：城市不能为空', {
      context: 'submitUpdateLocation',
      locationForm,
      index
    })
    return
  }
  if (!locationForm.address) {
    error.value = `地址 ${index + 1}：详细地址不能为空`
    console.error('更新公司地址失败：详细地址不能为空', {
      context: 'submitUpdateLocation',
      locationForm,
      index
    })
    return
  }

  try {
    const data = {
      id: locationForm.id,
      address: locationForm.address,
      company: locationForm.company,
      city: locationForm.city.id
    }
    console.log(`正在调用 updateCompanyLocation(${locationForm.id})，提交数据：`, JSON.stringify(data, null, 2))
    await updateCompanyLocation(locationForm.id, data)
    alert(`地址 ${index + 1} 更新成功！`)
    console.log('公司地址更新成功：', JSON.stringify(data, null, 2))
    router.push(`/company_home/company_info/${companyId.value}`)
  } catch (err) {
    const errorDetails = {
      context: 'updateCompanyLocation',
      companyId: companyId.value,
      submittedData: locationForm,
      message: err.message || '未知错误',
      status: err.response?.status,
      data: err.response?.data,
      stack: err.stack
    }
    console.error('更新公司地址失败：', JSON.stringify(errorDetails, null, 2))
    error.value = `更新公司地址失败：${err.response?.data?.error || '请检查输入或稍后重试'}`
  }
}

const submitCreateLocation = async () => {
  // 基本验证
  if (!newLocationForm.value.city) {
    error.value = '新增地址：城市不能为空'
    console.error('新增公司地址失败：城市不能为空', {
      context: 'submitCreateLocation',
      newLocationForm: newLocationForm.value
    })
    return
  }
  if (!newLocationForm.value.address) {
    error.value = '新增地址：详细地址不能为空'
    console.error('新增公司地址失败：详细地址不能为空', {
      context: 'submitCreateLocation',
      newLocationForm: newLocationForm.value
    })
    return
  }

  try {
    const data = {
      address: newLocationForm.value.address,
      company: companyId.value,
      city: newLocationForm.value.city.id
    }
    console.log(`正在调用 createCompanyLocation，提交数据：`, JSON.stringify(data, null, 2))
    const response = await createCompanyLocation(data)
    locations.value.push(response.data)
    locationForms.value.push({
      id: response.data.id,
      city: cities.value.find(city => city.id === response.data.city.id) || null,
      address: response.data.address || '',
      company: response.data.company
    })
    alert('地址新增成功！')
    console.log('公司地址新增成功：', JSON.stringify(response.data, null, 2))
    showAddForm.value = false
    newLocationForm.value = { city: null, address: '' } // 重置表单
  } catch (err) {
    const errorDetails = {
      context: 'createCompanyLocation',
      companyId: companyId.value,
      submittedData: newLocationForm.value,
      message: err.message || '未知错误',
      status: err.response?.status,
      data: err.response?.data,
      stack: err.stack
    }
    console.error('新增公司地址失败：', JSON.stringify(errorDetails, null, 2))
    error.value = `新增公司地址失败：${err.response?.data?.error || '请检查输入或稍后重试'}`
  }
}

const deleteLocation = async (index) => {
  const locationForm = locationForms.value[index]
  if (!confirm(`确定要删除地址 ${index + 1} (${locationForm.city?.name} - ${locationForm.address}) 吗？`)) {
    return
  }

  try {
    console.log(`正在调用 deleteCompanyLocation(${locationForm.id})`)
    await deleteCompanyLocation(locationForm.id)
    locations.value.splice(index, 1)
    locationForms.value.splice(index, 1)
    alert(`地址 ${index + 1} 删除成功！`)
    console.log('公司地址删除成功：', locationForm.id)
  } catch (err) {
    const errorDetails = {
      context: 'deleteCompanyLocation',
      companyId: companyId.value,
      locationId: locationForm.id,
      message: err.message || '未知错误',
      status: err.response?.status,
      data: err.response?.data,
      stack: err.stack
    }
    console.error('删除公司地址失败：', JSON.stringify(errorDetails, null, 2))
    error.value = `删除公司地址失败：${err.response?.data?.error || '请检查输入或稍后重试'}`
  }
}

const goBack = () => {
  console.log('Returning to:', `/company_home/company_info/${companyId.value}`)
  router.push(`/company_home/company_info/${companyId.value}`)
}
</script>

<style scoped>
.company-info-update-page {
  min-height: 100vh;
  width: 100%;
  background-image: url('/images/Company-info-update.jpg');
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
  display: flex;
  justify-content: center;
  align-items: flex-start;
}

.container {
  width: 800px;
  max-width: 90%;
  background-color: rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  padding: 32px;
  margin-top: 20px;
}

.back-button, .submit-button, .delete-button, .add-button, .cancel-button {
  padding: 12px 24px;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.3s, transform 0.1s;
}

.back-button {
  background-color: #3498db;
  margin-bottom: 16px;
}

.back-button:hover {
  background-color: #2980b9;
  transform: translateY(-1px);
}

.submit-button {
  background-color: #2ecc71;
  align-self: flex-start;
}

.submit-button:hover {
  background-color: #27ae60;
  transform: translateY(-1px);
}

.delete-button {
  background-color: #e74c3c;
  margin-left: 10px;
}

.delete-button:hover {
  background-color: #c0392b;
  transform: translateY(-1px);
}

.add-button {
  background-color: #f1c40f;
  align-self: flex-start;
}

.add-button:hover {
  background-color: #e1b307;
  transform: translateY(-1px);
}

.cancel-button {
  background-color: #95a5a6;
  margin-left: 10px;
}

.cancel-button:hover {
  background-color: #7f8c8d;
  transform: translateY(-1px);
}

.section {
  margin-bottom: 32px;
}

.section-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 16px;
  text-align: center;
}

.location-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
  margin-bottom: 12px;
}

.form {
  display: flex;
  flex-direction: column;
  gap: 20px;
  margin-bottom: 24px;
}

.form-group {
  display: flex;
  flex-direction: column;
}

.button-group {
  display: flex;
  gap: 10px;
}

.form-group label {
  font-size: 16px;
  font-weight: 600;
  color: #444;
  margin-bottom: 8px;
}

.input {
  padding: 12px;
  font-size: 16px;
  border: 1px solid rgba(255, 255, 255, 0.5);
  border-radius: 6px;
  background-color: rgba(255, 255, 255, 0.7);
  transition: border-color 0.3s, background-color 0.3s;
}

.input:focus {
  border-color: #3498db;
  background-color: rgba(255, 255, 255, 0.9);
  outline: none;
}

.textarea {
  min-height: 120px;
  resize: vertical;
}

.error {
  color: #e74c3c;
  font-size: 16px;
  margin-bottom: 16px;
  text-align: center;
}

.loading {
  font-size: 18px;
  color: #333;
  text-align: center;
  margin-top: 20px;
}
</style>
```