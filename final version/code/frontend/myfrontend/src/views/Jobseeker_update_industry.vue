<template>
  <div class="container">
    <button class="back-button" @click="goBack">← 返回上一页</button>
    <h2>更新期望行业</h2>
    <div v-if="desiredIndustries.length && industries.length">
      <div v-for="(item, index) in desiredIndustries" :key="item.id" class="experience-section">
        <h4>期望行业 {{ index + 1 }}</h4>
        <form @submit.prevent="updateIndustry(index)">
          <div>
            <label>行业：</label>
            <select v-model="item.industry">
              <option v-for="ind in industries" :key="ind.id" :value="ind.id">
                {{ ind.name }}
              </option>
            </select>
          </div>
          <button type="submit">保存</button>
          <button type="button" class="remove-button" @click="deleteIndustry(index)">删除</button>
        </form>
      </div>
    </div>

    <div v-else>
      <p>加载中或无期望行业信息。</p>
    </div>

    <button class="add-button" @click="addIndustry">添加期望行业</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import {
  getCurrentUser,
  getIndustries,
  getJobSeeker,
  createDesiredIndustry,
  updateDesiredIndustry,
  deleteDesiredIndustry
} from '../api/api'

const router = useRouter()
const industries = ref([])
const desiredIndustries = ref([])
const jobSeekerId = ref(null)

const goBack = () => {
  router.push(`/jobseeker_home/jobseeker_info/${jobSeekerId.value}`)
}

onMounted(async () => {
  try {
    const res1 = await getIndustries()
    industries.value = res1.data

    const userRes = await getCurrentUser(localStorage.getItem('token'))
    const user = userRes.data
    jobSeekerId.value = user.id

    const seekerRes = await getJobSeeker(user.id)
    const desired = seekerRes.data.desired_industries || []

    desiredIndustries.value = desired.map((d) => ({
      id: d.id,
      industry: d.industry.id,
      job_seeker: user.id,
    }))
  } catch (err) {
    console.error('加载失败', err)
  }
})

const updateIndustry = async (index) => {
  const item = desiredIndustries.value[index];

  // 检查是否有其他记录已经用了这个 industry
  const isDuplicate = desiredIndustries.value.some(
    (r, i) => i !== index && r.industry === item.industry
  );

  if (isDuplicate) {
    alert(`更新失败：该行业已存在于其他记录中`);
    return;
  }

  try {
    await updateDesiredIndustry(item.id, item);
    alert(`第 ${index + 1} 条期望行业更新成功`);
  } catch (err) {
    console.error('更新失败', err);
    if (err.response?.data) {
      alert(`更新失败：${JSON.stringify(err.response.data)}`);
    } else {
      alert('更新失败，请稍后重试');
    }
  }
};


const deleteIndustry = async (index) => {
  const item = desiredIndustries.value[index]
  if (!confirm(`确定删除第 ${index + 1} 条期望行业吗？`)) return
  try {
    await deleteDesiredIndustry(item.id)
    desiredIndustries.value.splice(index, 1)
    alert('删除成功')
  } catch (e) {
    console.error('删除失败', e)
    alert('删除失败')
  }
}

const addIndustry = async () => {
  const usedIds = desiredIndustries.value.map(d => d.industry)
  const available = industries.value.find(ind => !usedIds.includes(ind.id))

  if (!available) {
    alert('所有行业已添加，无法继续添加')
    return
  }

  const newItem = {
    industry: available.id,
    job_seeker: jobSeekerId.value,
  }

  try {
    const res = await createDesiredIndustry(newItem)
    desiredIndustries.value.push(res.data)
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
select {
  width: 60%;
  padding: 4px;
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
.back-button {
  background-color: #3498db;
  border-radius: 6px;
  font-size: 16px;
  margin-bottom: 20px;
}
.add-button {
  background-color: #2ecc71;
}
.add-button:hover {
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
