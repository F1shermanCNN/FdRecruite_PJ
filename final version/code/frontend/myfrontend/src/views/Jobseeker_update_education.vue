<template>
  <div class="container">
    <button class="back-button" @click="goBack">← 返回上一页</button>
    <h2>更新教育经历</h2>
    <!-- 教育经历列表 -->
    <div v-if="educationExperiences.length && schools.length">
      <div
        v-for="(experience, index) in educationExperiences"
        :key="experience.id"
        class="experience-section"
      >
        <h4>教育经历 {{ index + 1 }}</h4>
        <form @submit.prevent="updateExperience(index)">
          <div>
            <label>学校：</label>
            <select v-model="experience.school">
              <option v-for="school in schools" :key="school.id" :value="school.id">
                {{ school.name }}（{{ school.category }}）
              </option>
            </select>
          </div>
          <div>
            <label>学位：</label>
            <select v-model="experience.degree">
              <option v-for="option in educationOptions" :key="option" :value="option">
                {{ option }}
              </option>
            </select>
          </div>
          <div>
            <label>专业：</label>
            <input v-model="experience.major" />
          </div>
          <div>
            <label>开始日期：</label>
            <input type="date" v-model="experience.start_date" />
          </div>
          <div>
            <label>结束日期：</label>
            <input type="date" v-model="experience.end_date" />
          </div>
          <button type="submit">保存</button>
          <button type="button" class="remove-button" @click="deleteExperience(index)">
            删除
          </button>
        </form>
      </div>
    </div>

    <!-- 加载提示 -->
    <div v-else>
      <p>加载中或无教育经历。</p>
    </div>

    <!-- 添加按钮 -->
    <button class="add-button" @click="addExperience">添加教育经历</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import {
  getCurrentUser,
  getJobSeeker,
  getSchools,
  updateEducationExperience,
  createEducationExperience,
  deleteEducationExperience
} from '../api/api'
import { useRouter } from 'vue-router'

const router = useRouter()
const goBack = () => {
  router.push(`/jobseeker_home/jobseeker_info/${jobSeekerId.value}`)
}

const token = localStorage.getItem('token')

const schools = ref([])
const educationExperiences = ref([])
const jobSeekerId = ref(null)

// 定义学位选项（后端 EDUCATION_CHOICES）
const educationOptions = ['专科', '学士', '硕士', '博士']

onMounted(async () => {
  try {
    const res1 = await getSchools()
    schools.value = res1.data

    const res2 = await getCurrentUser(token)
    const user = res2.data
    jobSeekerId.value = user.id

    const res3 = await getJobSeeker(user.id)
    const jobSeekerData = res3.data
    const rawExperiences = jobSeekerData.education_experiences || []

    educationExperiences.value = rawExperiences.map((exp) => ({
      id: exp.id,
      school: exp.school.id,
      degree: exp.degree,
      major: exp.major,
      start_date: exp.start_date,
      end_date: exp.end_date,
      job_seeker: user.id,
    }))
  } catch (err) {
    console.error('加载失败：', err)
  }
})

const updateExperience = async (index) => {
  const exp = educationExperiences.value[index];

  // 检查是否有其他记录拥有相同的 school + degree + major
  const isDuplicate = educationExperiences.value.some((e, i) =>
    i !== index &&
    e.school === exp.school &&
    e.degree === exp.degree &&
    e.major.trim() === exp.major.trim()
  );

  if (isDuplicate) {
    alert(`更新失败：该“学校 + 学位 + 专业”组合的记录已存在`);
    return;
  }

  try {
    await updateEducationExperience(exp.id, exp);
    alert(`第 ${index + 1} 条教育经历更新成功`);
  } catch (err) {
    console.error(`第 ${index + 1} 条教育经历更新失败:`, err);
    if (err.response?.data) {
      alert(`更新失败：${JSON.stringify(err.response.data)}`);
    } else {
      alert(`更新失败：未知错误`);
    }
  }
};



const deleteExperience = async (index) => {
  const exp = educationExperiences.value[index]
  if (!exp.id) {
    educationExperiences.value.splice(index, 1)
    return
  }

  if (!confirm(`确定删除第 ${index + 1} 条教育经历吗？`)) return
  try {
    await deleteEducationExperience(exp.id)
    educationExperiences.value.splice(index, 1)
    alert(`第 ${index + 1} 条教育经历删除成功`)
  } catch (err) {
    console.error(`第 ${index + 1} 条教育经历删除失败:`, err)
    alert('删除失败')
  }
}

const addExperience = async () => {
  // 找一个组合（school+degree+major）尚未使用的默认值
  let newSchool = null
  let newDegree = null
  let newMajor = null

  outer: for (const school of schools.value) {
    for (const degree of educationOptions) {
      for (let i = 1; i <= 99; i++) {
        const candidateMajor = `默认专业${i}`
        const exists = educationExperiences.value.some(
          (e) => e.school === school.id && e.degree === degree && e.major === candidateMajor
        )
        if (!exists) {
          newSchool = school.id
          newDegree = degree
          newMajor = candidateMajor
          break outer
        }
      }
    }
  }

  if (!newSchool || !newDegree || !newMajor) {
    alert('所有默认组合均已使用，无法再添加。请手动填写新记录。')
    return
  }

  const newExp = {
    school: newSchool,
    degree: newDegree,
    major: newMajor,
    start_date: new Date().toISOString().slice(0, 10),
    end_date: new Date().toISOString().slice(0, 10),
    job_seeker: jobSeekerId.value,
  }

  try {
    const res = await createEducationExperience(newExp)
    const createdExp = res.data
    educationExperiences.value.push({
      id: createdExp.id,
      school: createdExp.school,
      degree: createdExp.degree,
      major: createdExp.major,
      start_date: createdExp.start_date,
      end_date: createdExp.end_date,
      job_seeker: createdExp.job_seeker,
    })
    alert('添加新教育经历成功')
  } catch (err) {
    console.error('添加教育经历失败：', err)
    if (err.response?.data) {
      alert(`添加失败：请先保存更改内容，${JSON.stringify(err.response.data)}`)
    } else {
      alert('添加失败：请先保存更改内容')
    }
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
form > div {
  margin-bottom: 10px;
}
label {
  display: inline-block;
  width: 130px;
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
.back-button {
  padding: 12px 24px;
  background-color: #3498db;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.3s, transform 0.1s;
  margin-bottom: 16px;
}
.back-button:hover {
  background-color: #2980b9;
  transform: translateY(-1px);
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
