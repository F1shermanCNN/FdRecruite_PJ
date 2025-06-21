<template>
    <div class="favorite-page">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回上一页</button>
  
      <!-- 收藏标题 -->
      <h2 class="section-title">已收藏的岗位</h2>
  
      <!-- 岗位列表 -->
      <div v-if="filteredPositions.length">
        <PositionCard
          v-for="position in filteredPositions"
          :key="position.id"
          :position="position"
        />
      </div>
      <div v-else class="empty-message">暂无收藏的岗位</div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { getFavoritePositions } from '../api/api'
  import PositionCard from '../components/PositionCard.vue'
  
  const route = useRoute()
  const router = useRouter()
  
  // ✅ 正确读取求职者 ID
  const jobSeekerId = route.params.id
  const filteredPositions = ref([])
  
  const goBack = () => {
    router.back()
  }
  
  onMounted(async () => {
    try {
      const response = await getFavoritePositions()
      const allFavorites = response.data
  
      // ✅ 过滤出当前求职者收藏的岗位
      const seekerFavorites = allFavorites.filter(
        fav => String(fav.job_seeker) === String(jobSeekerId)
      )
  
      // 每个收藏记录中应包含 position 信息，提取出来
      filteredPositions.value = seekerFavorites.map(fav => fav.position)
    } catch (error) {
      console.error('加载收藏岗位失败:', error)
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
  