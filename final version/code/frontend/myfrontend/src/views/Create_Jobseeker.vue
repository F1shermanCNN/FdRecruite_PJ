<template>
  <div class="create-jobseeker-container">
    <h2>完善求职者信息</h2>

    <form @submit.prevent="handleSubmit">
      <div class="form-group">
        <label>出生日期</label>
        <input type="date" v-model="form.birth_date" required />
      </div>

      <div class="form-group">
        <label>电话号码</label>
        <input type="text" v-model="form.phone" required />
      </div>

      <div class="form-group">
        <label>期望最低薪资</label>
        <input type="number" v-model.number="form.expected_min_salary" required />
      </div>

      <div class="form-group">
        <label>期望最高薪资</label>
        <input type="number" v-model.number="form.expected_max_salary" required />
      </div>

      <div class="form-group">
        <label>教育程度</label>
        <select v-model="form.education" required>
          <option value="专科">专科</option>
          <option value="本科">本科</option>
          <option value="硕士">硕士</option>
          <option value="博士">博士</option>
        </select>
      </div>

      <button type="submit">提交信息</button>
    </form>

    <div v-if="error" class="error">{{ error }}</div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { login, getCurrentUser, createJobSeeker } from '../api/api'

const route = useRoute()
const router = useRouter()

const pathSegments = route.path.split('/')
const userpassword = decodeURIComponent(pathSegments[pathSegments.length - 2])
const username = decodeURIComponent(pathSegments[pathSegments.length - 1])


const form = ref({
  name: username,
  birth_date: '',
  phone: '',
  expected_min_salary: 0,
  expected_max_salary: 0,
  education: '本科'
})

const error = ref('')

const handleSubmit = async () => {
  error.value = ''
  try {
    const loginRes = await login({
      username: username,
      password: userpassword,
      user_type: 'jobseeker'
    })

    const token = loginRes.data.auth_token
    const userRes = await getCurrentUser(token)
    const userId = userRes.data.id

    const data = {
      id: userId,
      name: form.value.name,
      birth_date: form.value.birth_date,
      phone: form.value.phone,
      expected_min_salary: form.value.expected_min_salary,
      expected_max_salary: form.value.expected_max_salary,
      education: form.value.education
    }

    await createJobSeeker(data)
    router.push('/login')
  } catch (err) {
    error.value = '创建失败，请检查信息或稍后重试'
  }
}
</script>

<style scoped>
.create-jobseeker-container {
  max-width: 500px;
  margin: 3rem auto;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

form {
  display: flex;
  flex-direction: column;
}

.form-group {
  margin-bottom: 1rem;
}

label {
  font-weight: bold;
  margin-bottom: 0.5rem;
  display: block;
}

input, select {
  padding: 0.5rem;
  width: 100%;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  padding: 0.75rem;
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #3aa374;
}

.error {
  color: red;
  margin-top: 1rem;
  text-align: center;
}
</style>
