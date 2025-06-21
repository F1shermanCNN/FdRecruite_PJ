<template>
    <div class="favorite-page">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回上一页</button>
  
      <!-- 收藏标题 -->
      <h2 class="section-title">已收藏的求职者</h2>
  
      <!-- 求职者列表 -->
      <div v-if="filteredJobSeekers.length">
        <JobSeekerCard
          v-for="seeker in filteredJobSeekers"
          :key="seeker.id"
          :jobSeeker="seeker"
        />
      </div>
      <div v-else class="empty-message">暂无收藏的求职者</div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { getCompanyFavoriteJobSeekers } from '../api/api'
  import { getJobSeeker } from '../api/api'
  import JobSeekerCard from '../components/JobSeekerCard.vue'
  
  const route = useRoute()
  const router = useRouter()
  
  const companyId = route.params.id
  const filteredJobSeekers = ref([])
  
  const goBack = () => {
    router.back()
  }
  
  onMounted(async () => {
    try {
      const response = await getCompanyFavoriteJobSeekers()
      const allFavorites = response.data
  
      // 过滤出当前公司收藏的记录
      const companyFavorites = allFavorites.filter(
        fav => String(fav.company) === String(companyId)
      )
  
      // 获取所有 job_seeker.id
      const seekerIds = companyFavorites.map(fav => fav.job_seeker.id)
  
      // 获取每个求职者的详细信息
      const jobSeekerPromises = seekerIds.map(id => getJobSeeker(id))
      const seekerResponses = await Promise.all(jobSeekerPromises)
      filteredJobSeekers.value = seekerResponses.map(res => res.data)
    } catch (error) {
      console.error('加载收藏求职者失败:', error)
    }
  })
  </script>
  
  <style scoped>
  .favorite-page {
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
  
  .section-title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 16px;
  }
  
  .empty-message {
    font-size: 16px;
    color: #999;
    margin-top: 20px;
  }
  </style>
  