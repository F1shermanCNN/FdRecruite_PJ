<template>
  <div class="register-page">
    <div class="register-container">
      <h2>用户注册</h2>
      <form @submit.prevent="handleRegister">
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

        <!-- 确认密码 -->
        <div class="form-group">
          <label for="confirmPassword">确认密码</label>
          <input
            type="password"
            id="confirmPassword"
            v-model="confirmPassword"
            required
            placeholder="请再次输入密码"
          />
        </div>

        <!-- 提交按钮 -->
        <button type="submit" :disabled="loading">
          {{ loading ? '注册中...' : '注册' }}
        </button>
      </form>

      <!-- 状态提示 -->
      <div v-if="error" class="error-message">{{ error }}</div>
      <div v-if="registerSuccess" class="success-message">注册成功，请前往信息完善页面</div>

      <!-- 企业用户提示 -->
      <div class="contact-message">
        如果您是企业用户，请联系我们的邮箱：<strong>contact@example.com</strong>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { login,register } from '../api/api'

const router = useRouter()
localStorage.removeItem('token')
const form = ref({
  username: '',
  password: '',
  user_type: 'jobseeker' // 固定为求职者
})
const confirmPassword = ref('')

const loading = ref(false)
const error = ref('')
const registerSuccess = ref(false)

const handleRegister = async () => {
  error.value = ''
  registerSuccess.value = false

  if (form.value.password !== confirmPassword.value) {
    error.value = '两次输入的密码不一致'
    return
  }

  loading.value = true

  try {
    await register(form.value)
    registerSuccess.value = true
    
    const loginRes = await login({
      username: form.value.username,
      password: form.value.password,
      user_type: 'jobseeker'
    })

    const token = loginRes.data.auth_token
    localStorage.setItem('token', token)
    setTimeout(() => {
      
      router.push(`/register/createjobseeker/${form.value.password}/${form.value.username}`)
    }, 1500)
  } catch (err) {
    error.value =
      err.response?.data?.username?.[0] ||
      err.response?.data?.password?.[0] ||
      err.response?.data?.non_field_errors?.[0] ||
      '注册失败，请检查输入'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
/* 让html, body和根元素全屏 */
html, body, #app {
  height: 100%;
  margin: 0;
  padding: 0;
}

.register-page {
  height: 100vh;
  width: 100vw;
  background-image: url(/images/login.png);
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;

  /* Flex布局，内容居中 */
  display: flex;
  align-items: center;
  justify-content: center;
  transform: translateX(-200px);/*这个是为了控制页面偏移 */
}

.register-container {
  max-width: 400px;
  width: 100%;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.2); /* 半透明背景 */
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2); /* 更立体的阴影 */
  backdrop-filter: blur(10px); /* 毛玻璃效果 */
  -webkit-backdrop-filter: blur(10px); /* Safari 支持 */
  border: 1px solid rgba(255, 255, 255, 0.3); /* 轻微边框提升细节 */
}


.form-group {
  margin-bottom: 1rem;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: bold;
}

input {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-sizing: border-box;
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

.contact-message {
  margin-top: 1.5rem;
  padding: 0.75rem;
  background-color: #f9f9f9;
  color: #555;
  font-size: 14px;
  border-radius: 4px;
  text-align: center;
}
</style>
