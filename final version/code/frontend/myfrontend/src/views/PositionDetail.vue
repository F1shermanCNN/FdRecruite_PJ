<template>
  <div class="position-detail-page">
    <div class="container">
      <button class="back-button" @click="goBack">← 返回上一页</button>

      <div class="position-detail" v-if="position">
        <h1>{{ position.job_title.name }}</h1>
        <!-- 查看收藏夹按钮 -->
        <button @click="goToFavourite" class="Favourite-button">查看收藏夹</button>
        <!-- 🗑️ 删除职位按钮 -->
        <button @click="handleDelete" class="delete-button">🗑️ 删除职位</button>

        <!-- ✏️ 修改信息按钮 -->
        <button @click="goToEdit" class="edit-button">✏️ 修改信息</button>

        <p><strong>公司：</strong>{{ position.company.name }}</p>
        <p><strong>城市：</strong>{{ position.city.name }}</p>
        <p><strong>行业：</strong>{{ position.industry.name }}</p>
        <p><strong>薪资：</strong>{{ position.min_salary }}k - {{ position.max_salary }}k</p>
        <p><strong>年龄要求：</strong>{{ position.min_age || '无' }} - {{ position.max_age || '无' }}</p>
        <p><strong>经验：</strong>{{ position.experience_required }}</p>
        <p><strong>学历：</strong>{{ position.education_required }}</p>

        <h3>岗位职责</h3>
        <p>{{ position.description?.job_description || '无' }}</p>

        <h3>任职要求</h3>
        <p>{{ position.description?.requirements || '无' }}</p>

        <h3>福利待遇</h3>
        <p>{{ position.description?.work_conditions || '无' }}</p>

        
     
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import {
  getPosition,
  getFavoritePositions,
  addFavoritePosition,
  deleteFavoritePosition,
  deletePosition // ✅ 引入删除职位的 API
} from '../api/api'

const route = useRoute()
const router = useRouter()

const pathSegments = route.path.split('/')
const jobseekerId = Number(pathSegments[pathSegments.length - 2])
const positionId = Number(pathSegments[pathSegments.length - 1])

const position = ref(null)
const isFavorited = ref(false)
const favoriteId = ref(null)
const isLoaded = ref(false)
const errorMsg = ref('')

onMounted(async () => {
  try {
    const response = await getPosition(positionId)
    position.value = response.data

    const favRes = await getFavoritePositions()
    const favorites = favRes.data || []

    const matched = favorites.find(fav =>
      Number(fav.position?.id) === positionId &&
      Number(fav.job_seeker) === jobseekerId
    )

    if (matched) {
      isFavorited.value = true
      favoriteId.value = matched.id
    }
  } catch (err) {
    console.error('加载失败:', err)
    errorMsg.value = '加载失败'
  } finally {
    isLoaded.value = true
  }
})

// ⭐ 删除职位逻辑
const handleDelete = async () => {
  const confirmDelete = window.confirm('⚠️ 是否确定删除这个职位？')
  if (!confirmDelete) return

  try {
    await deletePosition(positionId)
    alert('✅ 职位已成功删除')
    router.back()
  } catch (err) {
    console.error('❌ 删除失败:', err)
    alert('删除失败，请稍后重试')
  }
}

const handleFavorite = async () => {
  errorMsg.value = ''
  try {
    if (isFavorited.value) {
      if (favoriteId.value != null) {
        await deleteFavoritePosition(favoriteId.value)
        isFavorited.value = false
        favoriteId.value = null
        alert('✅ 已取消收藏！')
      } else {
        console.warn('收藏 ID 不存在')
      }
    } else {
      const payload = {
        job_seeker: jobseekerId,
        position: positionId
      }
      await addFavoritePosition(payload)
      isFavorited.value = true
      alert('✅ 加入收藏成功！')

      const favRes = await getFavoritePositions()
      const matched = favRes.data.find(fav =>
        Number(fav.position?.id) === positionId &&
        Number(fav.job_seeker) === jobseekerId
      )
      if (matched) {
        favoriteId.value = matched.id
      }
    }
  } catch (err) {
    console.error('❌ 操作失败:', err)
    errorMsg.value = err.response?.data?.message || '发生未知错误'
  }
}
const goToFavourite = () => {
  router.push(`/company_home/company_info/favourite/${jobseekerId}/${positionId}`)
}
const goToEdit = () => {
  router.push(`/company_home/company_info/update/${jobseekerId}/${positionId}`)
}

const goBack = () => {
  router.back()
}
</script>

<style scoped>
.position-detail-page {
  min-height: 100vh;
  background-image: url('/images/position-details.jpg');
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

.back-button, .edit-button, .favorite-btn, .delete-button {
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
  margin-left: 16px;
}

.edit-button:hover {
  background-color: #8e44ad;
  transform: translateY(-1px);
}

.favorite-btn {
  background-color: #e67e22;
  margin-top: 20px;
}

.favorite-btn:hover {
  background-color: #d35400;
  transform: translateY(-1px);
}

.favorite-btn.disabled {
  background-color: #aaa;
  cursor: not-allowed;
}

.favorite-btn.disabled:hover {
  background-color: #aaa;
  transform: none;
}

/* 🔴 删除按钮样式 */
.delete-button {
  background-color: #e74c3c;
  margin-bottom: 16px;
}

.delete-button:hover {
  background-color: #c0392b;
  transform: translateY(-1px);
}

.position-detail {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

h1 {
  font-size: 28px;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
  text-align: center;
}

h3 {
  font-size: 20px;
  font-weight: 600;
  color: #444;
  margin-top: 24px;
  margin-bottom: 8px;
}

p {
  font-size: 16px;
  color: #555;
  line-height: 1.6;
}

p strong {
  color: #333;
  font-weight: 600;
}

.error-msg {
  color: #e74c3c;
  font-size: 16px;
  margin-top: 16px;
  text-align: center;
}

.loading {
  font-size: 16px;
  color: #333;
  text-align: center;
  margin-top: 16px;
}
</style>
