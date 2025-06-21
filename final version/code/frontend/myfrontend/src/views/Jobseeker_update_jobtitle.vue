<template>
  <div class="container">
    <button class="back-button" @click="goBack">← 返回上一页</button>
    <h2>更新期望职位</h2>
    <div v-if="desiredJobTitles.length && jobTitles.length">
      <div
        v-for="(record, index) in desiredJobTitles"
        :key="record.id"
        class="experience-section"
      >
        <h4>期望职位 {{ index + 1 }}</h4>
        <form @submit.prevent="updateJobTitle(index)">
          <div>
            <label>职位：</label>
            <select v-model="record.job_title">
              <option v-for="jt in jobTitles" :key="jt.id" :value="jt.id">
                {{ jt.name }}
              </option>
            </select>
          </div>
          <button type="submit">保存</button>
          <button type="button" class="remove-button" @click="deleteJobTitle(index)">
            删除
          </button>
        </form>
      </div>
    </div>

    <div v-else>
      <p>加载中或暂无期望职位信息。</p>
    </div>

    <button class="add-button" @click="addJobTitle">添加期望职位</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import {
  getCurrentUser,
  getJobSeeker,
  getJobTitles,
  getDesiredJobTitles,
  createDesiredJobTitle,
  updateDesiredJobTitle,
  deleteDesiredJobTitle,
} from '../api/api'

const router = useRouter()
const jobSeekerId = ref(null)
const jobTitles = ref([])
const desiredJobTitles = ref([])

const goBack = () => {
  router.push(`/jobseeker_home/jobseeker_info/${jobSeekerId.value}`)
}

onMounted(async () => {
  try {
    const jtRes = await getJobTitles()
    jobTitles.value = jtRes.data

    const userRes = await getCurrentUser(localStorage.getItem('token'))
    const user = userRes.data
    jobSeekerId.value = user.id

    const seekerRes = await getJobSeeker(user.id)
    desiredJobTitles.value = (seekerRes.data.desired_job_titles || []).map(item => ({
      id: item.id,
      job_title: item.job_title.id,
      job_seeker: user.id
    }))
  } catch (err) {
    console.error('加载失败', err)
    alert('加载失败，请稍后重试')
  }
})

const updateJobTitle = async (index) => {
  const rec = desiredJobTitles.value[index]

  const isDuplicate = desiredJobTitles.value.some((e, i) =>
    i !== index && e.job_title === rec.job_title
  )
  if (isDuplicate) {
    alert('更新失败：该职位记录已存在')
    return
  }

  try {
    await updateDesiredJobTitle(rec.id, rec)
    alert(`第 ${index + 1} 条期望职位更新成功`)
  } catch (err) {
    console.error('更新失败', err)
    alert('更新失败，请检查内容或稍后重试')
  }
}

const deleteJobTitle = async (index) => {
  const rec = desiredJobTitles.value[index]
  if (!confirm(`确定删除第 ${index + 1} 条记录吗？`)) return
  try {
    await deleteDesiredJobTitle(rec.id)
    desiredJobTitles.value.splice(index, 1)
    alert('删除成功')
  } catch (err) {
    console.error('删除失败', err)
    alert('删除失败')
  }
}

const addJobTitle = async () => {
  const existing = desiredJobTitles.value.map(r => r.job_title)
  const unused = jobTitles.value.find(jt => !existing.includes(jt.id))

  if (!unused) {
    alert('所有职位都已添加，无法继续添加')
    return
  }

  const newItem = {
    job_title: unused.id,
    job_seeker: jobSeekerId.value,
  }

  try {
    const res = await createDesiredJobTitle(newItem)
    desiredJobTitles.value.push(res.data)
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
