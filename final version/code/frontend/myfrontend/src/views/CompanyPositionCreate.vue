<template>
  <div class="position-create-container">
    <button class="back-button" @click="goBack">← 返回上一页</button>
    <h2>发布岗位信息</h2>
    <form @submit.prevent="handleSubmit">
      <!-- 1. 岗位基本信息部分 -->
      <div class="form-section">
        <h3>岗位基本信息</h3>

        <div class="form-group" :class="{ 'error': !formData.minSalary && submitted }">
          <label>最低薪资 (千/月) *</label>
          <span v-if="!formData.minSalary && submitted" class="error-message">需填写</span>
          <input v-model.number="formData.minSalary" type="number" required placeholder="最低薪资" />
        </div>
        <div class="form-group" :class="{ 'error': !formData.maxSalary && submitted }">
          <label>最高薪资 (千/月) *</label>
          <span v-if="!formData.maxSalary && submitted" class="error-message">需填写</span>
          <input v-model.number="formData.maxSalary" type="number" required placeholder="最高薪资" />
        </div>
      </div>

      <!-- 2. 岗位要求部分 -->
      <div class="form-section">
        <h3>岗位要求</h3>
        <div class="form-group" :class="{ 'error': !formData.experienceRequired && submitted }">
          <label>工作经验要求 *</label>
          <span v-if="!formData.experienceRequired && submitted" class="error-message">需填写</span>
          <select v-model="formData.experienceRequired" required>
            <option value="">请选择</option>
            <option v-for="exp in experienceOptions" :key="exp" :value="exp">{{ exp }}</option>
          </select>
        </div>
        <div class="form-group" :class="{ 'error': !formData.educationRequired && submitted }">
          <label>教育要求 *</label>
          <span v-if="!formData.educationRequired && submitted" class="error-message">需填写</span>
          <select v-model="formData.educationRequired" required>
            <option value="">请选择</option>
            <option v-for="edu in educationOptions" :key="edu" :value="edu">{{ edu }}</option>
          </select>
        </div>
        <div class="form-group" :class="{ 'error': !formData.industryId && submitted }">
          <label>行业 *</label>
          <span v-if="!formData.industryId && submitted" class="error-message">需填写</span>
          <select v-model="formData.industryId" required>
            <option value="">请选择</option>
            <option v-for="ind in industries" :key="ind.id" :value="ind.id">{{ ind.name }}</option>
          </select>
        </div>
        <div class="form-group" :class="{ 'error': !formData.jobTitleId && submitted }">
          <label>职位标题 *</label>
          <span v-if="!formData.jobTitleId && submitted" class="error-message">需填写</span>
          <select v-model="formData.jobTitleId" required>
            <option value="">请选择</option>
            <option v-for="job in jobTitles" :key="job.id" :value="job.id">{{ job.name }}</option>
          </select>
        </div>
        <div class="form-group" :class="{ 'error': !formData.cityId && submitted }">
          <label>工作城市 *</label>
          <span v-if="!formData.cityId && submitted" class="error-message">需填写</span>
          <select v-model="formData.cityId" required>
            <option value="">请选择</option>
            <option v-for="city in cities" :key="city.id" :value="city.id">{{ city.name }}</option>
          </select>
        </div>
        <div class="form-group" :class="{ 'error': (!formData.description.jobDescription) && submitted }">
          <label>职位描述 *</label>
          <span v-if="!formData.description.jobDescription && submitted" class="error-message">需填写</span>
          <textarea v-model="formData.description.jobDescription" required placeholder="请输入职位描述"></textarea>
        </div>
        <div class="form-group" :class="{ 'error': (!formData.description.requirements) && submitted }">
          <label>职位要求 *</label>
          <span v-if="!formData.description.requirements && submitted" class="error-message">需填写</span>
          <textarea v-model="formData.description.requirements" required placeholder="请输入职位要求"></textarea>
        </div>
        <div class="form-group" :class="{ 'error': (!formData.description.workConditions) && submitted }">
          <label>职位福利 *</label>
          <span v-if="!formData.description.workConditions && submitted" class="error-message">需填写</span>
          <textarea v-model="formData.description.workConditions" required placeholder="请输入职位福利"></textarea>
        </div>
      </div>

      <!-- 3. 提交按钮和草稿 -->
      <button type="submit">发布岗位</button>
      <p v-if="errorMessage" style="color: red;">{{ errorMessage }}</p>
      <pre v-if="debugInfo" style="color: blue;">Debug Info: {{ debugInfo }}</pre>
    </form>
  </div>
</template>

<script>
import { ref, onMounted, watch } from 'vue';
import { createPosition, getIndustries, getCities, getJobTitles } from '../api/api.js';
import { useRoute, useRouter } from 'vue-router';

export default {
  name: 'CompanyPositionCreate',
  setup() {
    const route = useRoute();
    const router = useRouter();
    const companyIdFromUrl = Number(route.params.id);

    const goBack = () => {
      router.back();
    };

    const formData = ref({
      minSalary: null,
      maxSalary: null,
      experienceRequired: '',
      educationRequired: '',
      industryId: null,
      jobTitleId: null,
      cityId: null,
      companyId: companyIdFromUrl,
      description: {
        jobDescription: '',
        requirements: '',
        workConditions: ''
      }
    });

    const industries = ref([]);
    const cities = ref([]);
    const jobTitles = ref([]);
    const errorMessage = ref('');
    const submitted = ref(false);
    const debugInfo = ref('');

    const experienceOptions = ['应届生', '1-3年', '3-5年', '5年+', '不限'];
    const educationOptions = ['专科', '本科', '硕士', '博士', '不限'];

    const fetchDictionaries = async () => {
      try {
        const [industriesResp, citiesResp, jobTitlesResp] = await Promise.all([
          getIndustries(),
          getCities(),
          getJobTitles()
        ]);
        industries.value = industriesResp.data;
        cities.value = citiesResp.data;
        jobTitles.value = jobTitlesResp.data;
      } catch (error) {
        console.error('Failed to fetch dictionaries:', error);
      }
    };

    const saveFormData = () => {
      localStorage.setItem('companyPositionForm', JSON.stringify(formData.value));
    };
    watch(formData, saveFormData, { deep: true });

    const loadFormData = () => {
      const savedData = localStorage.getItem('companyPositionForm');
      if (savedData) {
        try {
          const parsedData = JSON.parse(savedData);
          formData.value = {
            ...parsedData,
            companyId: companyIdFromUrl, // 强制绑定 URL 中的 companyId
            description: {
              jobDescription: parsedData.description?.jobDescription || '',
              requirements: parsedData.description?.requirements || '',
              workConditions: parsedData.description?.workConditions || ''
            }
          };
        } catch (e) {
          console.error('Failed to parse savedData:', e);
        }
      }
    };

    const handleSubmit = async () => {
      submitted.value = true;
      if (!formData.value.minSalary || !formData.value.maxSalary ||
          !formData.value.experienceRequired || !formData.value.educationRequired ||
          !formData.value.industryId || !formData.value.jobTitleId || !formData.value.cityId) {
        errorMessage.value = '用户信息不完整需要重新补全';
        return;
      }

     

      try {
        const positionPayload = {
          min_salary: Number(formData.value.minSalary),
          max_salary: Number(formData.value.maxSalary),
          experience_required: formData.value.experienceRequired,
          education_required: formData.value.educationRequired,
          description: {
            job_description: String(formData.value.description.jobDescription || ''),
            requirements: String(formData.value.description.requirements || ''),
            work_conditions: String(formData.value.description.workConditions || '')
          },
          position: formData.value.jobTitleId,
          company: formData.value.companyId,
          industry: formData.value.industryId,
          job_title: formData.value.jobTitleId,
          city: formData.value.cityId
        };
        debugInfo.value = `Submitting: ${JSON.stringify(positionPayload, null, 2)}`;
        const positionResponse = await createPosition(positionPayload);
        debugInfo.value += `\nResponse: ${JSON.stringify(positionResponse.data, null, 2)}`;

     

        alert('岗位发布成功！');
        localStorage.removeItem('companyPositionForm');
        formData.value = {
          minSalary: null,
          maxSalary: null,
          experienceRequired: '',
          educationRequired: '',
          industryId: null,
          jobTitleId: null,
          cityId: null,
          companyId: companyIdFromUrl,
          description: {
            jobDescription: '',
            requirements: '',
            workConditions: ''
          }
        };
        errorMessage.value = '';
        debugInfo.value = '';
        submitted.value = false;
      } catch (error) {
        const errorDetail = error.response?.data?.detail || error.message || '未知错误';
        errorMessage.value = `岗位发布失败：${errorDetail}`;
        debugInfo.value = `Error: ${JSON.stringify(error.response?.data, null, 2) || error.message}`;
      }
    };

    const saveDraft = () => {
      alert('草稿保存成功（功能待后端支持）');
    };

    onMounted(() => {
      fetchDictionaries();
      loadFormData();
    });

    return {
      goBack,
      formData,
      handleSubmit,
      saveDraft,
      errorMessage,
      submitted,
      industries,
      cities,
      jobTitles,
      experienceOptions,
      educationOptions,
      debugInfo
    };
  }
};
</script>




<style scoped>
.position-create-container {
  width: 66%;
  min-width: 400px;
  margin: 0 auto;
  padding: 20px;
}

.form-section {
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 15px;
}

.form-group.error label {
  color: red;
}

.error-message {
  color: red;
  font-size: 0.8em;
  display: block;
  margin-bottom: 5px;
}

label {
  display: block;
  margin-bottom: 5px;
}

input, select, textarea {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
  border: 1px solid #ccc; /* 确保输入框有边框 */
  border-radius: 4px;
}

textarea {
  height: 100px;
  resize: vertical; /* 允许垂直调整大小 */
}

button {
  background-color: #1DA1F2;
  color: white;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
  margin-right: 10px;
}

button:hover {
  background-color: #1a91da;
}
/* 返回按钮样式 */
.back-button {
  display: inline-block;
  margin-bottom: 16px;
  padding: 8px 16px;
  background-color: #3498db;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
}

.back-button:hover {
  background-color: #2980b9;
}

.position-detail {
  padding: 24px;
  background: #f9f9f9;
  border-radius: 8px;
}
</style>