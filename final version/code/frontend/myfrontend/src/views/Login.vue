<template>
  <div class="login-page">
    <div class="login-container">
      <h2>用户登录</h2>
      <form @submit.prevent="handleLogin">
        <!-- 用户名 -->
        <div class="form-group">
          <label for="username">用户名</label>
          <input
            type="text"
            id="username"
            v-model="form.username"
            required
            placeholder="请输入用户名"
          />
        </div>

        <!-- 密码 -->
        <div class="form-group">
          <label for="password">密码</label>
          <input
            type="password"
            id="password"
            v-model="form.password"
            required
            placeholder="请输入密码"
          />
        </div>

        <!-- 用户类型 -->
        <div class="form-group">
          <label>用户类型</label>
          <select v-model="form.userType" class="user-type-select">
            <option value="jobseeker">求职者</option>
            <option value="company">企业</option>
          </select>
        </div>

        <!-- 登录按钮 -->
        <button type="submit" :disabled="loading">
          {{ loading ? '登录中...' : '登录' }}
        </button>

        <!-- 注册提示 -->
        <p class="register-tip">
          如果你还没有账号，<router-link to="/register">请注册</router-link>
        </p>
      </form>

      <!-- 状态提示 -->
      <div v-if="error" class="error-message">{{ error }}</div>
      <div v-if="loginSuccess" class="success-message">
        <p>登录成功！</p>
        <p>您已以<strong>{{ userTypeDisplay }}</strong>身份登录</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { login, getCurrentUser } from '../api/api'
const router = useRouter()

const form = ref({
  username: '',
  password: '',
  userType: 'jobseeker' // 默认值
})

const loading = ref(false)
const error = ref('')
const loginSuccess = ref(false)

const userTypeDisplay = computed(() => {
  return form.value.userType === 'company' ? '企业用户' : '求职者用户'
})

const handleLogin = async () => {
  loading.value = true
  error.value = ''
  loginSuccess.value = false

  try {
    // 登录获取 token
    localStorage.removeItem('token')
    const response = await login({
      username: form.value.username,
      password: form.value.password,
      user_type: form.value.userType
    })

    const token = response.data.auth_token
    localStorage.setItem('token', token)

    // 获取当前用户信息
    const userRes = await getCurrentUser(token)
    const actualUserType = userRes.data.user_type
    const selectedUserType = form.value.userType

    // 类型不匹配
    if (
      (selectedUserType === 'company' && actualUserType !== 'employer') ||
      (selectedUserType === 'jobseeker' && actualUserType !== 'jobseeker')
    ) {
      error.value = '用户类型与账号实际身份不匹配，请确认后重试'
      localStorage.removeItem('token') // 清除不合法 token
      return
    }

    localStorage.setItem('userType', actualUserType)
    loginSuccess.value = true

    // 登录成功跳转
    setTimeout(() => {
      const userId = userRes.data.id
      if (actualUserType === 'employer') {
        router.push(`/company_home/${userId}`)
      } else {
        router.push(`/jobseeker_home/${userId}`)
      }
    }, 1000)
  } catch (err) {
    error.value =
      err.response?.data?.detail ||
      err.response?.data?.message ||
      '登录失败，请检查用户名或密码'
  } finally {
    loading.value = false
  }
}

</script>

<style scoped>
/* 确保html,body和根元素全屏 */
html, body, #app {
  height: 100%;
  margin: 0;
  padding: 0;
}

.login-page {
  height: 100vh;
  width: 100vw;
  background-image: url(/images/login.png);
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: translateX(-200px);
}

.login-container {
  max-width: 400px;
  width: 100%;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.2); /* 半透明白色背景 */
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(10px); /* 磨砂效果的关键 */
  -webkit-backdrop-filter: blur(10px); /* Safari 支持 */
  border: 1px solid rgba(255, 255, 255, 0.3); /* 轻微边框提升视觉层次 */
}


.form-group {
  margin-bottom: 1rem;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: bold;
}

input,
select {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-sizing: border-box;
}

.user-type-select {
  appearance: none;
  background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9' /%3e%3c/svg%3e");
  background-repeat: no-repeat;
  background-position: right 0.75rem center;
  background-size: 1rem;
  background-color: white;
}

button {
  width: 100%;
  padding: 0.75rem;
  margin-top: 1rem;
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

button:hover:not(:disabled) {
  background-color: #3aa876;
}

.error-message {
  margin-top: 1rem;
  padding: 0.75rem;
  background-color: #ffebee;
  color: #f44336;
  border-radius: 4px;
  text-align: center;
}

.success-message {
  margin-top: 1rem;
  padding: 0.75rem;
  background-color: #e8f5e9;
  color: #4caf50;
  border-radius: 4px;
  text-align: center;
}

.success-message strong {
  color: #2e7d32;
}

.register-tip {
  margin-top: 1rem;
  text-align: center;
  font-size: 14px;
}

.register-tip a {
  color: #42b983;
  text-decoration: underline;
  cursor: pointer;
}
</style>
