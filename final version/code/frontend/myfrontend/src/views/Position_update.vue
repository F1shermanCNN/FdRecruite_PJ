```vue
<template>
  <div class="position-info-update-page">
    <div class="container">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回公司信息</button>

      <!-- 错误提示 -->
      <div v-if="error" class="error">{{ error }}</div>

      <!-- 岗位信息编辑 -->
      <div class="section" v-if="position">
        <h2 class="section-title">编辑岗位信息</h2>
        <div class="form">
          <!-- 最低薪资 -->
          <div class="form-group">
            <label>最低薪资（千元/月）</label>
            <input v-model="form.min_salary" type="number" class="input" placeholder="请输入最低薪资" />
          </div>

          <!-- 最高薪资 -->
          <div class="form-group">
            <label>最高薪资（千元/月）</label>
            <input v-model="form.max_salary" type="number" class="input" placeholder="请输入最高薪资" />
          </div>

          <!-- 最低年龄 -->
          <div class="form-group">
            <label>最低年龄（可选）</label>
            <input v-model="form.min_age" type="number" class="input" placeholder="请输入最低年龄" />
          </div>

          <!-- 最高年龄 -->
          <div class="form-group">
            <label>最高年龄（可选）</label>
            <input v-model="form.max_age" type="number" class="input" placeholder="请输入最高年龄" />
          </div>

          <!-- 经验要求 -->
          <div class="form-group">
            <label>经验要求</label>
            <select v-model="form.experience_required" class="input">
              <option value="不限">不限</option>
              <option value="应届生">应届生</option>
              <option value="1-3年">1-3年</option>
              <option value="3-5年">3-5年</option>
              <option value="5年+">5年+</option>
            </select>
          </div>

          <!-- 学历要求 -->
          <div class="form-group">
            <label>学历要求</label>
            <select v-model="form.education_required" class="input">
              <option value="不限">不限</option>
              <option value="专科">专科</option>
              <option value="本科">本科</option>
              <option value="硕士">硕士</option>
              <option value="博士">博士</option>
            </select>
          </div>

          <!-- 岗位要求 -->
          <div class="form-group">
            <label>岗位要求</label>
            <textarea v-model="form.description.requirements" class="input textarea" placeholder="请输入岗位要求"></textarea>
          </div>

          <!-- 工作描述 -->
          <div class="form-group">
            <label>工作描述</label>
            <textarea v-model="form.description.job_description" class="input textarea" placeholder="请输入工作描述"></textarea>
          </div>

          <!-- 工作条件 -->
          <div class="form-group">
            <label>工作条件</label>
            <textarea v-model="form.description.work_conditions" class="input textarea" placeholder="请输入工作条件"></textarea>
          </div>

          <!-- 提交按钮 -->
          <button class="submit-button" @click="submitUpdate">保存更改</button>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading">加载中...</div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getPosition, updatePosition } from '../api/api'

const route = useRoute()
const router = useRouter()

// 从 URL 路径解析 companyId 和 positionId
const pathSegments = route.path.split('/')
const companyId = ref(Number(pathSegments[pathSegments.length - 2])) // 倒数第二个段
const positionId = ref(Number(pathSegments[pathSegments.length - 1])) // 最后一个段

const position = ref(null)
const form = ref({
  min_salary: null,
  max_salary: null,
  min_age: null,
  max_age: null,
  experience_required: '',
  education_required: '',
  description: {
    requirements: '',
    job_description: '',
    work_conditions: ''
  }
})
const originalIds = ref({}) // 存储不可修改的 ID
const loading = ref(true)
const error = ref(null)

onMounted(async () => {
  console.log('Full URL:', route.fullPath)
  console.log('Path segments:', pathSegments)
  console.log('companyId:', companyId.value)
  console.log('positionId:', positionId.value)

  if (!positionId.value || isNaN(positionId.value)) {
    error.value = '未提供有效的岗位 ID'
    console.error('加载岗位信息失败：未提供有效的岗位 ID', {
      context: 'onMounted',
      positionId: positionId.value,
      companyId: companyId.value,
      pathSegments,
      url: route.fullPath
    })
    loading.value = false
    return
  }

  try {
    console.log(`正在调用 getPosition(${positionId.value})`)
    const response = await getPosition(positionId.value)
    position.value = response.data
    form.value = {
      min_salary: position.value.min_salary || null,
      max_salary: position.value.max_salary || null,
      min_age: position.value.min_age || null,
      max_age: position.value.max_age || null,
      experience_required: position.value.experience_required || '',
      education_required: position.value.education_required || '',
      description: {
        requirements: position.value.description?.requirements || '',
        job_description: position.value.description?.job_description || '',
        work_conditions: position.value.description?.work_conditions || ''
      }
    }
    originalIds.value = {
      id: position.value.id,
      company: position.value.company?.id,
      industry: position.value.industry?.id,
      job_title: position.value.job_title?.id,
      city: position.value.city?.id
    }
    console.log('岗位信息加载成功：', JSON.stringify(position.value, null, 2))
  } catch (err) {
    const errorDetails = {
      context: 'getPosition',
      positionId: positionId.value,
      companyId: companyId.value,
      message: err.message || '未知错误',
      status: err.response?.status,
      data: err.response?.data,
      stack: err.stack
    }
    console.error('加载岗位信息失败：', JSON.stringify(errorDetails, null, 2))
    error.value = `加载岗位信息失败：${err.response?.data?.error || '请检查岗位 ID 或稍后重试'}`
  } finally {
    loading.value = false
  }
})

const submitUpdate = async () => {
  // 基本验证
  if (!form.value.min_salary || form.value.min_salary < 0) {
    alert('最低薪资不能为空且必须为非负数');
    return;
  }

  if (!form.value.max_salary || form.value.max_salary < form.value.min_salary) {
    alert('最高薪资不能为空，且必须大于或等于最低薪资');
    return;
  }

  if (form.value.min_salary > form.value.max_salary) {
    alert('最低薪资不能高于最高薪资');
    return;
  }

  if (form.value.min_age !== null && form.value.min_age < 0) {
    alert('最低年龄不能为负数');
    return;
  }

  if (form.value.max_age !== null && (form.value.max_age < 0)) {
    alert('最高年龄不能为负数');
    return;
  }

  if (
    form.value.min_age !== null &&
    form.value.max_age !== null &&
    form.value.min_age > form.value.max_age
  ) {
    alert('最低年龄不能高于最高年龄');
    return;
  }

  if (!['不限', '应届生', '1-3年', '3-5年', '5年+'].includes(form.value.experience_required)) {
    alert('经验要求必须是以下选项之一：不限, 应届生, 1-3年, 3-5年, 5年+');
    return;
  }

  if (!['不限', '专科', '本科', '硕士', '博士'].includes(form.value.education_required)) {
    alert('学历要求必须是以下选项之一：不限, 专科, 本科, 硕士, 博士');
    return;
  }

  try {
    const data = {
      id: originalIds.value.id,
      company: originalIds.value.company,
      industry: originalIds.value.industry,
      job_title: originalIds.value.job_title,
      city: originalIds.value.city,
      min_salary: form.value.min_salary,
      max_salary: form.value.max_salary,
      min_age: form.value.min_age,
      max_age: form.value.max_age,
      experience_required: form.value.experience_required,
      education_required: form.value.education_required,
      description: {
        requirements: form.value.description.requirements,
        job_description: form.value.description.job_description,
        work_conditions: form.value.description.work_conditions
      }
    };
    console.log(`正在调用 updatePosition(${positionId.value})，提交数据：`, JSON.stringify(data, null, 2));
    await updatePosition(positionId.value, data);
    alert('岗位信息更新成功！');
    router.push(`/company_home/company_info/${companyId.value}`);
  } catch (err) {
    console.error('更新岗位信息失败：', err);
    alert(`更新岗位信息失败：${err.response?.data?.error || '请检查输入或稍后重试'}`);
  }
};


const goBack = () => {
  console.log('Returning to:', `/company_home/company_info/${companyId.value}`)
  router.push(`/company_home/company_info/${companyId.value}`)
}
</script>

<style scoped>
.position-info-update-page {
  min-height: 100vh;
  background-image: url('/images/update-position.jpg');
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding: 40px 20px;
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

.back-button, .submit-button {
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

.form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
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