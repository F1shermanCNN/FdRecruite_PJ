<template>
  <div class="jobseeker-info-page">
    <div class="container">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回上一页</button>

      <!-- 顶部头像和姓名 -->
      <div class="header">
        <img :src="avatarSrc" alt="头像" class="avatar" />
        <div class="header-info">
          <h1 class="jobseeker-name">{{ jobSeeker.name || '求职者' }}</h1>
        </div>
      </div>

      <!-- 查看收藏夹 -->
      <div class="button-section">
        <button class="favorite-button" @click="goToFavorites">查看收藏夹</button>
      </div>

      <!-- 基本信息 -->
      <div class="section">
        <h2 class="section-title">基本信息</h2>
        <div class="button-section">
          <button class="edit-button" @click="goToEditInfo">修改信息</button>
        </div>
        <p><strong>ID：</strong>{{ jobSeeker.id || '暂无' }}</p>
        <p><strong>姓名：</strong>{{ jobSeeker.name || '暂无' }}</p>
        <p><strong>性别：</strong>{{ jobSeeker.gender || '未知' }}</p>
        <p><strong>出生日期：</strong>{{ jobSeeker.birth_date || '未知' }}</p>
        <p><strong>电话：</strong>{{ jobSeeker.phone || '暂无' }}</p>
        <p><strong>邮箱：</strong>{{ jobSeeker.email || '暂无' }}</p>
        <p><strong>目前状态：</strong>{{ jobSeeker.current_status || '未知' }}</p>
        <p><strong>期望工作类型：</strong>{{ jobSeeker.expected_work_type || '未填写' }}</p>
        <p>
          <strong>期望薪资：</strong>
          {{ jobSeeker.expected_min_salary || '未填写' }} - {{ jobSeeker.expected_max_salary || '未填写' }} 千元/月
        </p>
      </div>

      <!-- 背景信息 -->
      <div class="section">
        <h2 class="section-title">个人背景信息</h2>

        <p>
          <strong>
            教育经历
            <sup><button class="sup-edit-button" @click="goToEditEducation">✎修改</button></sup>
          </strong>：
          {{ formatEducation(jobSeeker.education_experiences) }}
        </p>

        <p>
          <strong>
            语言能力
            <sup><button class="sup-edit-button" @click="goToEditLanguages">✎修改</button></sup>
          </strong>：
          {{ formatLanguages(jobSeeker.languages) }}
        </p>

        <p>
          <strong>
            期望行业
            <sup><button class="sup-edit-button" @click="goToEditIndustries">✎修改</button></sup>
          </strong>：
          {{ formatNestedList(jobSeeker.desired_industries, 'industry') }}
        </p>

        <p>
          <strong>
            期望城市
            <sup><button class="sup-edit-button" @click="goToEditCities">✎修改</button></sup>
          </strong>：
          {{ formatCities(jobSeeker.desired_cities) }}
        </p>

        <p>
          <strong>
            期望职位
            <sup><button class="sup-edit-button" @click="goToEditJobTitles">✎修改</button></sup>
          </strong>：
          {{ formatNestedList(jobSeeker.desired_job_titles, 'job_title') }}
        </p>
      </div>

      <!-- 经历记录 -->
      <div class="section">
        <h2 class="section-title">经历记录</h2>
        <div class="button-section">
          <button class="edit-button" @click="goToExperienceInfo">管理经历记录</button>
        </div>

        <!-- 工作经历 -->
        <section v-if="jobSeeker.work_experience?.length">
          <h3>工作经历</h3>
          <div v-for="(job, i) in jobSeeker.work_experience" :key="i" class="job-block">
            <p><strong>💼 {{ job.company_name }}</strong> · {{ job.job_title }}</p>
            <p>📅 {{ formatDate(job.start_date) }} - {{ formatDate(job.end_date) }}</p>
            <ul v-if="job.responsibilities?.length">
              <li v-for="(res, j) in job.responsibilities" :key="j">职责: {{ res }}</li>
            </ul>
          </div>
        </section>

        <!-- 项目经历 -->
        <section v-if="jobSeeker.project_experience?.length">
          <h3>项目经历</h3>
          <div v-for="(proj, i) in jobSeeker.project_experience" :key="i" class="project-block">
            <p><strong>📁 {{ proj.project_name }}</strong> · {{ proj.role }}</p>
            <p>📅 {{ formatDate(proj.start_date) }} - {{ formatDate(proj.end_date) }}</p>
            <p>项目描述: {{ proj.description }}</p>
            <p><strong>使用技术: </strong>{{ proj.technologies.join('、') }}</p>
            <ul v-if="proj.responsibilities?.length">
              <li v-for="(res, j) in proj.responsibilities" :key="'res' + j">职责: {{ res }}</li>
            </ul>
            <ul v-if="proj.achievements?.length">
              <li v-for="(ach, j) in proj.achievements" :key="'ach' + j">成就: {{ ach }}</li>
            </ul>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getJobSeeker } from '../api/api'

const route = useRoute()
const router = useRouter()
const jobSeekerId = route.params.id
const jobSeeker = ref({})

// 路由跳转函数
const goBack = () => router.push(`/jobseeker_home/${jobSeekerId}`)
const goToFavorites = () => router.push(`/jobseeker_home/jobseeker_info/favourite_positions/${jobSeekerId}`)
const goToEditInfo = () => router.push(`/jobseeker_home/jobseeker_info/update_basic/${jobSeekerId}`)
const goToExperienceInfo = () => router.push(`/jobseeker_home/jobseeker_info/update_experience/${jobSeekerId}`)

const goToEditEducation = () => router.push(`/jobseeker_home/jobseeker_info/update_education/${jobSeekerId}`)
const goToEditLanguages = () => router.push(`/jobseeker_home/jobseeker_info/update_language/${jobSeekerId}`)
const goToEditIndustries = () => router.push(`/jobseeker_home/jobseeker_info/update_industry/${jobSeekerId}`)
const goToEditCities = () => router.push(`/jobseeker_home/jobseeker_info/update_city/${jobSeekerId}`)
const goToEditJobTitles = () => router.push(`/jobseeker_home/jobseeker_info/update_jobtitle/${jobSeekerId}`)

// 获取数据
const fetchJobSeeker = async () => {
  try {
    const response = await getJobSeeker(jobSeekerId)
    jobSeeker.value = response.data
  } catch (error) {
    console.error('获取求职者信息失败:', error)
  }
}

// 格式化函数
const avatarSrc = computed(() => {
  if (jobSeeker.value.gender === '男') return '/images/male.jpg'
  if (jobSeeker.value.gender === '女') return '/images/female.jpg'
  return '/images/unknown.jpg'
})

const formatNestedList = (list, key) => {
  if (!Array.isArray(list) || list.length === 0) return '暂无'
  return list.map(item => item[key]?.name).filter(Boolean).join('，')
}

const formatCities = (list) => {
  if (!Array.isArray(list) || list.length === 0) return '暂无'
  return list.map(item => {
    const city = item.city
    return city ? `${city.province}${city.name}` : ''
  }).filter(Boolean).join('，')
}

const formatLanguages = (list) => {
  if (!Array.isArray(list) || list.length === 0) return '暂无'
  return list.map(item => `${item.language?.name}（${item.proficiency}）`).join('，')
}

const formatEducation = (list) => {
  if (!Array.isArray(list) || list.length === 0) return '暂无'
  return list.map(exp => {
    const school = exp.school?.name || '未知学校'
    const degree = exp.degree || ''
    const major = exp.major || ''
    return `${school}（${degree}，${major}）`
  }).join('；')
}

const formatDate = (str) => str ? new Date(str).toLocaleDateString('zh-CN') : '暂无'

onMounted(fetchJobSeeker)
</script>

<style scoped>
.jobseeker-info-page {
  min-height: 100vh;
  width: 100%;
  background-image: url('/images/jobseeker-info.jpg');
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

.back-button, .edit-button, .favorite-button {
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
.edit-button {
  background-color: #9b59b6;
  margin-bottom: 16px;
}
.edit-button:hover {
  background-color: #8e44ad;
  transform: translateY(-1px);
}
.favorite-button {
  background-color: #f39c12;
  margin-bottom: 16px;
}
.favorite-button:hover {
  background-color: #e67e22;
  transform: translateY(-1px);
}

.button-section {
  text-align: left;
  margin-bottom: 12px;
}

.header {
  display: flex;
  align-items: center;
  margin-bottom: 24px;
}

.avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  margin-right: 20px;
  object-fit: cover;
}

.header-info {
  display: flex;
  flex-direction: column;
}

.jobseeker-name {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.section {
  margin-top: 24px;
}

.section-title {
  font-size: 20px;
  font-weight: bold;
  color: #444;
  margin-bottom: 12px;
  text-align: center;
}

p {
  font-size: 16px;
  margin-bottom: 8px;
  color: #555;
  text-align: left;
}

ul {
  padding-left: 20px;
  margin-bottom: 8px;
}

li {
  list-style-type: disc;
  font-size: 15px;
  color: #555;
  text-align: left;
}

.sup-edit-button {
  font-size: 12px;
  background: none;
  color: #3498db;
  border: none;
  cursor: pointer;
  padding: 0 4px;
  vertical-align: super;
}
.sup-edit-button:hover {
  color: #1f6fa4;
  text-decoration: underline;
}
</style>
