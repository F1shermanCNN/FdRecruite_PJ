```vue
<template>
  <div class="company-info-page">
    <div class="container">
      <button class="back-button" @click="goBack">← 返回上一页</button>

      <div class="header" v-if="company">
        <img src="/images/Company.jpg" alt="公司头像" class="logo" />
        <div class="header-info">
          <h1 class="company-name">{{ company.name }}</h1>
          <p class="company-size">企业规模：{{ company.size }}</p>
        </div>
      </div>

      <div class="section">
        <button class="favorite-button" @click="goToFavorites">查看收藏夹</button>
      </div>

      <div class="section" v-if="company">
        <h2 class="section-title">公司信息</h2>
        <button class="edit-button" @click="goToEditCompany">修改信息</button>
        <div class="company-details">
          <p><strong>公司名称：</strong>{{ company.name || '暂无' }}</p>
          <p><strong>企业规模：</strong>{{ company.size || '暂无' }}</p>
          <p><strong>是否认证：</strong>{{ company.verified ? '已认证' : '未认证' }}</p>
          <p><strong>简介：</strong>{{ company.description || '暂无简介' }}</p>
          <p><strong>营业执照有效期：</strong>{{ company.license_period || '暂无' }} 年</p>
          <p><strong>注册资本：</strong>{{ company.registered_capital || '暂无' }} 万元</p>
          <p v-if="company.locations?.length">
            <strong>地址：</strong>
            <span v-for="(location, index) in company.locations" :key="location.id">
              {{ location.city.name }} - {{ location.address || '暂无详细地址' }}<span v-if="index < company.locations.length - 1">; </span>
            </span>
          </p>
          <p v-else><strong>地址：</strong>暂无地址</p>
        </div>
      </div>

      <div class="section">
        <h2 class="section-title">岗位列表</h2>
        <div v-if="positions.length" class="job-list">
          <JobCard
            v-for="position in positions"
            :key="position.id"
            :position="position"
          />
        </div>
        <p v-else class="no-positions">暂无岗位</p>
        <button class="create-button" @click="goToCreatePosition">+ 发布新岗位</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getPositions, getCompany } from '../api/api'
import JobCard from '../components/PositionCard.vue'

const route = useRoute()
const router = useRouter()
const companyId = route.params.id

const company = ref(null)
const positions = ref([])

const goToFavorites = () => {
  router.push(`/company_home/company_info/favourite_jobseekers/${companyId}`)
}

onMounted(async () => {
  try {
    const positionResponse = await getPositions()
    const allPositions = positionResponse.data
    const companyPositions = allPositions.filter(
      pos => String(pos.company?.id) === String(companyId)
    )
    positions.value = companyPositions

    const companyResponse = await getCompany(companyId)
    company.value = companyResponse.data
  } catch (error) {
    console.error('加载公司信息或岗位失败：', error)
  }
})

const goToCreatePosition = () => {
  router.push(`/company_home/company_info/create_position/${companyId}`)
}

const goBack = () => {
  router.push(`/company_home/${companyId}`)
}

const goToEditCompany = () => {
  router.push(`/company_home/company_info/${companyId}/update`)
}
</script>

<style scoped>
.company-info-page {
  min-height: 100vh;
  width: 100%;
  background-image: url('/images/company-info.jpg');
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

.back-button, .edit-button, .favorite-button, .create-button {
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
  background-color: #9b59b6;
  margin-bottom: 16px;
}

.favorite-button:hover {
  background-color: #8e44ad;
  transform: translateY(-1px);
}

.create-button {
  background-color: #e67e22;
  margin-top: 24px;
}

.create-button:hover {
  background-color: #d35400;
  transform: translateY(-1px);
}

.header {
  display: flex;
  align-items: center;
  margin-bottom: 32px;
}

.logo {
  width: 100px;
  height: 100px;
  border-radius: 10px;
  margin-right: 24px;
}

.header-info {
  display: flex;
  flex-direction: column;
}

.company-name {
  font-size: 28px;
  font-weight: bold;
  color: #333;
}

.company-size {
  font-size: 20px;
  color: #666;
}

.section {
  margin-bottom: 32px;
  text-align: left;
}

.section-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-bottom: 16px;
}

.company-details {
  font-size: 18px;
  color: #333;
  text-align: left;
  padding-left: 12px;
}

.company-details p {
  margin: 10px 0;
}

.no-positions {
  font-size: 18px;
  color: #666;
}

.job-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

/* 放大卡片样式 */
.job-list > * {
  padding: 28px;
  font-size: 18px;
  border: 1px solid #ccc;
  border-radius: 16px;
  background-color: #fdfdfd;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: transform 0.25s ease;
}

.job-list > *:hover {
  transform: scale(1.03);
}
</style>
```