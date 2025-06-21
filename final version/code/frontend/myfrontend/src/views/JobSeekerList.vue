<template>
  <div class="top-bar">
    <button class="back-btn" @click="goBack">← 返回</button>
  </div>
  <div class="search-bar">
    <input v-model="keyword" @keyup.enter="searchJobSeekers" placeholder="请输入关键词搜索，如姓名、岗位、学校等" />
    <button @click="searchJobSeekers">搜索</button>
  </div>
  <div class="filters">

    <select v-model="filters.education">
      <option value="">学历不限</option>
      <option v-for="(label, index) in educationOptions" :key="index" :value="label">{{ label }}</option>
    </select>

    <select v-model="filters.city">
      <option value="">城市不限</option>
      <option v-for="city in cities" :key="city.id" :value="city.name">{{ city.name }}</option>
    </select>

    <select v-model="filters.job_title">
      <option value="">岗位不限</option>
      <option v-for="title in jobTitles" :key="title.id" :value="title.name">{{ title.name }}</option>
    </select>

    <select v-model="filters.industry">
      <option value="">行业不限</option>
      <option v-for="ind in industries" :key="ind.id" :value="ind.name">{{ ind.name }}</option>
    </select>

    <button @click="searchJobSeekers">筛选</button>
  </div>
  <div class="p-4 space-y-4">
    <JobSeekerCard v-for="jobSeeker in jobSeekers" :key="jobSeeker.id" :jobSeeker="jobSeeker" />
  </div>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue'
import { getJobSeekers, getCities, getIndustries, getJobTitles } from '../api/api'
import JobSeekerCard from '../components/JobSeekerCard.vue'

import { useRouter } from 'vue-router'
const router = useRouter()

const goBack = () => {
  router.back()
}


const jobSeekers = ref([])
const keyword = ref('')
const filters = reactive({
  education: '',
  city: '',
  job_title: '',
  industry: '',
})

const cities = ref([])
const industries = ref([])
const jobTitles = ref([])

const educationOptions = ['专科', '本科', '硕士', '博士']


const searchJobSeekers = async () => {
  const params = {
    keyword: keyword.value,
    education: filters.education,
    city: filters.city,
    job_title: filters.job_title,
    industry: filters.industry
  }

  const res = await getJobSeekers(params)
  jobSeekers.value = res.data
}

onMounted(async () => {
  cities.value = (await getCities()).data
  industries.value = (await getIndustries()).data
  jobTitles.value = (await getJobTitles()).data

  await searchJobSeekers()  // 默认展示全部
})
</script>

<style scoped>
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
  padding: 0px;
  border-radius: 12px;
  margin-bottom: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.filters select {
  flex: 1 1 100px;
  padding: 8px 12px;
  border-radius: 6px;
  border: 1px solid #ccc;
  font-size: 14px;
  background-color: white;
  transition: border-color 0.2s ease;
}

.filters select:focus {
  border-color: #007bff;
  outline: none;
}

.filters button {
  padding: 8px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.filters button:hover {
  background-color: #0056b3;
}

.top-bar {
  margin-bottom: 16px;
}

.back-btn {
  background-color: #f2f2f2;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.back-btn:hover {
  background-color: #e0e0e0;
}

</style>