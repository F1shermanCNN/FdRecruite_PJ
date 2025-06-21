<template>
  <div class="jobseeker-home">
    <!-- 顶部栏 -->
    <header class="top-bar">
      <div class="jobseeker-name">
        欢迎，{{ jobseeker?.name || '求职者' }}
      </div>
      <button class="logout-btn" @click="handleLogout">退出登录</button>
    </header>

    <!-- 导航栏 -->
    <nav class="nav-bar" v-if="jobseekerId">
      <span class="nav-label">功能：</span>
      <div class="nav-links">
        <router-link :to="`/jobseeker_home/joblist/${jobseekerId}`" active-class="active-link">职位</router-link>
        <router-link :to="`/jobseeker_home/jobseeker_info/${jobseekerId}`" active-class="active-link">个人信息</router-link>
      </div>
    </nav>

    <!-- 主体内容 -->
    <main class="content-area">
      <div class="inner-container">
        <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
        <router-view v-else />

        <!-- 推荐服务卡片 -->
        <div class="service-section">
          <div class="service-card highlight">
            <div class="service-title">推荐职位服务</div>
            <ul class="service-features">
              <li>每日智能匹配</li>
              <li>职位动态提醒</li>
              <li>HR主动沟通</li>
            </ul>
            <button class="service-button" @click="showNotImplemented">立即订阅</button>
          </div>

          <div class="service-card">
            <div class="service-title">简历优化建议</div>
            <ul class="service-features">
              <li style="font-weight: bold; font-size: 18px; color: #d9534f;">
                请及时更新你的个人信息，以便企业查看
              </li>

              <li>简历内容需简洁明了</li>
              <li>避免空洞的形容词</li>
              <li>展示你的业务价值</li>
            </ul>
            <!-- 删除查看详情按钮 -->
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { getJobSeeker, logout } from '../api/api'

const router = useRouter()
const route = useRoute()
const jobseeker = ref(null)
const errorMessage = ref('')
const token = localStorage.getItem('authToken')
const jobseekerId = route.params.id

const fetchJobSeekerInfo = async () => {
  if (!jobseekerId) {
    errorMessage.value = '无效的求职者 ID'
    return
  }

  try {
    const { data } = await getJobSeeker(jobseekerId)
    jobseeker.value = data
  } catch (err) {
    console.error('获取求职者信息失败:', err)
    errorMessage.value = '获取求职者信息失败'
  }
}

const handleLogout = async () => {
  try {
    await logout(token)
    localStorage.removeItem('job_token')
  } catch (err) {
    console.error('登出失败', err)
  } finally {
    localStorage.removeItem('authToken')
    localStorage.removeItem('userType')
    router.push('/login')
  }
}

// 弹出未实装提示
const showNotImplemented = () => {
  alert('订阅功能尚未实装')
}

onMounted(fetchJobSeekerInfo)
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.jobseeker-home {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  width: 100vw;
  background-color: #f4f6f8;
  transform: translateX(-200px);
}

/* 顶部栏 */
.top-bar {
  background-color: #2c3e50;
  color: #fff;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.jobseeker-name {
  font-size: 1.2rem;
  font-weight: bold;
}

.logout-btn {
  background-color: #e74c3c;
  border: none;
  padding: 0.5rem 1rem;
  color: white;
  border-radius: 4px;
  cursor: pointer;
}

/* 导航栏 */
.nav-bar {
  background: #34495e;
  display: flex;
  align-items: center;
  padding: 1rem 2rem;
  gap: 1rem;
  flex-wrap: wrap;
}

.nav-label {
  color: white;
  font-weight: bold;
  font-size: 1.6rem;
}

.nav-links {
  display: flex;
  flex: 1;
  justify-content: space-evenly;
  gap: 20px;
}

.nav-links a {
  color: white;
  text-decoration: none;
  font-weight: 600;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-size: 1.6rem;
}

.nav-links a.active-link {
  background-color: rgba(255, 255, 255, 0.25);
}

/* 主体内容 */
.content-area {
  flex: 1;
  padding: 2rem;
  width: 100%;
}

.inner-container {
  max-width: 1200px;
  margin: 0 auto;
}

/* 错误信息 */
.error-message {
  padding: 1rem;
  background-color: #ffdddd;
  color: #a94442;
  border: 1px solid #a94442;
  border-radius: 6px;
  text-align: center;
}

/* 推荐服务样式 */
.service-section {
  display: flex;
  justify-content: space-around;
  margin-top: 3rem;
  gap: 2rem;
  flex-wrap: wrap;
}

.service-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  width: 100%;
  max-width: 500px;
  text-align: center;
}

.highlight {
  border: 3px solid #ff8800;
}

.service-title {
  font-size: 1.5rem;
  font-weight: bold;
  margin-bottom: 1rem;
}

.service-features {
  list-style: none;
  padding: 0;
  margin-bottom: 1.5rem;
}

.service-features li {
  margin: 0.5rem 0;
  font-size: 1.1rem;
}

.service-button {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  cursor: pointer;
}

.service-button:hover {
  background-color: #2980b9;
}
</style>
