<template>
  <div class="container">
    <button class="back-button" @click="goBack">← 返回上一页</button>
    <h2>更新期望城市</h2>

    <div v-if="desiredCities.length && cities.length">
      <div
        v-for="(record, index) in desiredCities"
        :key="record.id"
        class="experience-section"
      >
        <h4>期望城市 {{ index + 1 }}</h4>
        <form @submit.prevent="updateCity(index)">
          <div>
            <label>城市：</label>
            <select v-model="record.city">
              <option v-for="city in cities" :key="city.id" :value="city.id">
                {{ city.name }}
              </option>
            </select>
          </div>
          <button type="submit">保存</button>
          <button type="button" class="remove-button" @click="deleteCity(index)">
            删除
          </button>
        </form>
      </div>
    </div>

    <div v-else>
      <p>加载中或暂无期望城市信息。</p>
    </div>

    <button class="add-button" @click="addCity">添加期望城市</button>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import {
  getCurrentUser,
  getCities,
  getJobSeeker,
  getDesiredCities,
  updateDesiredCity,
  createDesiredCity,
  deleteDesiredCity,
} from '../api/api'

const router = useRouter()
const jobSeekerId = ref(null)
const cities = ref([])
const desiredCities = ref([])



const goBack = () => {
  router.push(`/jobseeker_home/jobseeker_info/${jobSeekerId.value}`)
}

onMounted(async () => {
  try {
    const res1 = await getCities()
    cities.value = res1.data

    const userRes = await getCurrentUser(localStorage.getItem('token'))
    const user = userRes.data
    jobSeekerId.value = user.id

    const res2 = await getJobSeeker(user.id)
    desiredCities.value = (res2.data.desired_cities || []).map((item) => ({
      id: item.id,
      city: item.city.id,
      job_seeker: user.id,
    }))
  } catch (err) {
    console.error('加载失败：', err)
    alert('加载期望城市失败，请稍后重试')
  }
})

const updateCity = async (index) => {
  const record = desiredCities.value[index]

  // 检查是否有别的记录已经使用了这个城市
  const isDuplicate = desiredCities.value.some(
    (r, i) => i !== index && r.city === record.city
  )

  if (isDuplicate) {
    alert(`更新失败：该城市已存在于其他记录中`)
    return
  }

  try {
    await updateDesiredCity(record.id, record)
    alert(`第 ${index + 1} 条记录更新成功`)
  } catch (err) {
    console.error('更新失败', err)
    if (err.response?.data) {
      alert(`更新失败：${JSON.stringify(err.response.data)}`)
    } else {
      alert('更新失败')
    }
  }
}


const deleteCity = async (index) => {
  const record = desiredCities.value[index]
  if (!confirm(`确定删除第 ${index + 1} 条记录吗？`)) return
  try {
    await deleteDesiredCity(record.id)
    desiredCities.value.splice(index, 1)
    alert('删除成功')
  } catch (err) {
    console.error('删除失败', err)
    alert('删除失败')
  }
}

const addCity = async () => {
  const existingCityIds = desiredCities.value.map((r) => r.city)
  const unused = cities.value.find((c) => !existingCityIds.includes(c.id))

  if (!unused) {
    alert('所有城市都已添加，无法继续添加')
    return
  }

  const newCity = {
    city: unused.id,
    job_seeker: jobSeekerId.value,
  }

  try {
    const res = await createDesiredCity(newCity)
    desiredCities.value.push(res.data)
    alert('添加成功')
  } catch (err) {
    console.error('添加失败', err)
    alert('添加失败：请先保存更改内容')
  }
}
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
}
label {
  display: inline-block;
  width: 100px;
  vertical-align: top;
}
input,
select {
  width: 60%;
  padding: 6px;
}
button {
  padding: 8px 16px;
  margin-top: 10px;
  margin-right: 10px;
  background-color: #3498db;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
button:hover {
  background-color: #2980b9;
}
.add-button {
  background-color: #2ecc71;
}
.add-button:disabled {
  background-color: #95a5a6;
  cursor: not-allowed;
}
.add-button:hover:not(:disabled) {
  background-color: #27ae60;
}
.remove-button {
  background-color: #e74c3c;
}
.remove-button:hover {
  background-color: #c0392b;
}
.experience-section {
  border: 1px solid #eee;
  padding: 15px;
  margin-bottom: 15px;
  border-radius: 4px;
}
</style>
