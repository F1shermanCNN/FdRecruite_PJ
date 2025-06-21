<template>
  <div class="company-home">
    <!-- 顶部栏 -->
    <header class="top-bar">
      <div class="company-name">
        欢迎，{{ company?.name || '企业用户' }}
      </div>
      <button class="logout-btn" @click="handleLogout">退出登录</button>
    </header>

    <!-- 导航栏 -->
    <nav class="nav-bar" v-if="companyId">
      <span class="nav-label">功能：</span>
      <div class="nav-links">
        <router-link :to="`/company_home/jobseekers/${companyId}`" active-class="active-link">找人</router-link>
        <router-link :to="`/company_home/company_info/${companyId}`" active-class="active-link">企业信息</router-link>
      </div>
    </nav>

    <!-- 主体内容 -->
    <main class="content-area">
      <div class="inner-container">
        <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
        <router-view v-else />

        <!-- VIP 栏目卡片 -->
        <div class="vip-section">
          <div class="vip-card best-value">
            <div class="vip-title">超级VIP</div>
            <ul class="vip-features">
              <li>专属推荐</li>
              <li>极速响应</li>
              <li>更多曝光</li>
            </ul>
            <button class="vip-button" @click="showVipNotImplemented">开通超级VIP</button>
          </div>
          <div class="vip-card">
            <div class="vip-title">普通VIP</div>
            <ul class="vip-features">
              <li>普通推荐</li>
              <li>标准服务</li>
            </ul>
            <button class="vip-button" @click="showVipNotImplemented">开通普通VIP</button>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { getCurrentUser, getCompany, logout } from '../api/api'

const token2 = localStorage.getItem('token')
const router = useRouter()
const route = useRoute()

const company = ref(null)
const errorMessage = ref('')
const companyId = route.params.id

const fetchCompanyInfo = async () => {
  if (!companyId) {
    errorMessage.value = '无效的企业 ID'
    return
  }

  try {
    const { data: user } = await getCurrentUser(token2)
    if (user.user_type !== 'employer') {
      errorMessage.value = token2
      return
    }

    const { data } = await getCompany(companyId)
    company.value = data
  } catch (err) {
    console.error('获取企业信息失败:', err)
    errorMessage.value = '获取企业信息失败'
  }
}

const handleLogout = async () => {
  try {
    await logout(token2)
    localStorage.removeItem('token')
  } catch (err) {
    console.error('登出失败', err)
  } finally {
    localStorage.removeItem('userType')
    router.push('/login')
  }
}

// 替代跳转函数，弹出未实装提示
const showVipNotImplemented = () => {
  alert('开通 VIP 功能尚未实装，敬请期待！')
}

onMounted(fetchCompanyInfo)
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.company-home {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  width: 100vw;
  background-color: #f8f9fa;
  transform: translateX(-200px); /* 页面偏移控制 */
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

.company-name {
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

/* 错误提示 */
.error-message {
  padding: 1rem;
  background-color: #ffdddd;
  color: #a94442;
  border: 1px solid #a94442;
  border-radius: 6px;
  text-align: center;
}

/* VIP 栏目样式 */
.vip-section {
  display: flex;
  justify-content: space-around;
  margin-top: 3rem;
  gap: 2rem;
  flex-wrap: wrap;
}

.vip-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  width: 100%;
  max-width: 500px;
  text-align: center;
}

.best-value {
  border: 3px solid orange;
}

.vip-title {
  font-size: 1.5rem;
  font-weight: bold;
  margin-bottom: 1rem;
}

.vip-features {
  list-style: none;
  padding: 0;
  margin-bottom: 1.5rem;
}

.vip-features li {
  margin: 0.5rem 0;
  font-size: 1.1rem;
}

.vip-button {
  background-color: #ff6600;
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  cursor: pointer;
}

.vip-button:hover {
  background-color: #e65c00;
}
</style>
