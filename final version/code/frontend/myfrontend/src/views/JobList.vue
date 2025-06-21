<template>
  <div class="job-list-page">
    <!-- 返回按钮 -->
    <button class="back-button" @click="goBack">← 返回上一页</button>

    <!-- 顶部搜索栏 -->
    <div class="search-bar">
      <input
        v-model="searchKeyword"
        placeholder="关键词搜索，如城市、岗位等"
        @keyup.enter="fetchPositions"
      />
      <button @click="fetchPositions">筛选</button>
    </div>

    <!-- 筛选条件栏 -->
    <div class="filters">
      <select v-model="selectedCity">
        <option value="">城市不限</option>
        <option v-for="city in cities" :key="city.id" :value="city.name">{{ city.name }}</option>
      </select>

      <select v-model="selectedJobTitle">
        <option value="">岗位不限</option>
        <option v-for="job in jobTitles" :key="job.id" :value="job.name">{{ job.name }}</option>
      </select>

      <select v-model="selectedIndustry">
        <option value="">行业不限</option>
        <option v-for="industry in industries" :key="industry.id" :value="industry.name">{{ industry.name }}</option>
      </select>

      <select v-model="selectedExperience">
        <option value="">经验不限</option>
        <option v-for="exp in experienceOptions" :key="exp">{{ exp }}</option>
      </select>

      <select v-model="selectedEducation">
        <option value="">学历不限</option>
        <option v-for="edu in educationOptions" :key="edu">{{ edu }}</option>
      </select>
    </div>

    <!-- 岗位卡片列表 -->
    <p v-if="positions.length === 0" class="text-gray-500 mt-4">暂无岗位数据</p>
    <div v-else class="job-list">
      <PositionCard v-for="position in positions" :key="position.id" :position="position" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getCities, getIndustries, getJobTitles, getPositions } from '../api/api'
import PositionCard from '../components/PositionCard.vue'

const router = useRouter()
const goBack = () => router.back()

const searchKeyword = ref('')
const selectedCity = ref('')
const selectedIndustry = ref('')
const selectedJobTitle = ref('')
const selectedExperience = ref('')
const selectedEducation = ref('')

const cities = ref([])
const industries = ref([])
const jobTitles = ref([])
const positions = ref([])

const experienceOptions = ['应届生', '1-3年', '3-5年', '5年+']
const educationOptions = ['专科', '本科', '硕士', '博士']

onMounted(async () => {
  cities.value = (await getCities()).data
  industries.value = (await getIndustries()).data
  jobTitles.value = (await getJobTitles()).data
  await fetchPositions()
})

async function fetchPositions() {
  const allPositions = (await getPositions()).data
  positions.value = allPositions.filter((p) => {
    return (
      (!selectedCity.value || p.city.name === selectedCity.value) &&
      (!selectedIndustry.value || p.industry.name === selectedIndustry.value) &&
      (!selectedJobTitle.value || p.job_title.name === selectedJobTitle.value) &&
      (!selectedExperience.value || selectedExperience.value === '不限' || p.experience_required === selectedExperience.value) &&
      (!selectedEducation.value || selectedEducation.value === '学历不限' || p.education_required === selectedEducation.value) &&
      (!searchKeyword.value || JSON.stringify(p).includes(searchKeyword.value))
    )
  })
}
</script>

<style scoped>
.job-list-page {
  padding: 24px;
  font-family: sans-serif;
}

.back-button {
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

.search-bar {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
}

.search-bar input {
  flex: 1;
  padding: 8px;
  border-radius: 4px;
  border: 1px solid #ccc;
}

.search-bar button {
  padding: 8px 16px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
.search-bar button:hover {
  background-color: #0056b3;
}

.filters {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  background-color: #f9f9f9;
  padding: 12px;
  border-radius: 12px;
  margin-bottom: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.filters select {
  flex: 1 1 160px;
  padding: 8px 12px;
  border-radius: 6px;
  border: 1px solid #ccc;
  font-size: 14px;
  background-color: white;
}

.job-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
</style>
