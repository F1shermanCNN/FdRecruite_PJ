<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import dayjs from 'dayjs'
import {
  getJobSeeker,
  getCompany,
  addCompanyFavoriteJobSeeker,
  getCompanyFavoriteJobSeekers,
  deleteCompanyFavoriteJobSeeker
} from '../api/api'

const route = useRoute()
const router = useRouter()

const jobSeeker = ref(null)
const errorMsg = ref('')
const isFavorited = ref(false)
const isLoaded = ref(false)
const favoriteId = ref(null) // ⭐️ 新增：记录收藏记录的 id

const pathSegments = route.path.split('/')
const companyId = Number(pathSegments[pathSegments.length - 3])
const jobSeekerId = Number(pathSegments[pathSegments.length - 1])

onMounted(async () => {
  try {
    const jobSeekerRes = await getJobSeeker(jobSeekerId)
    jobSeeker.value = jobSeekerRes.data

    const favRes = await getCompanyFavoriteJobSeekers()
    const favorites = favRes.data || []

    console.log('收藏项结构为:', favorites)

    const matched = favorites.find(fav =>
      Number(fav.job_seeker?.id) === jobSeekerId &&
      Number(fav.company) === companyId
    )

    if (matched) {
      isFavorited.value = true
      favoriteId.value = matched.id // ⭐️ 记录该条收藏记录的 id
    }
  } catch (err) {
    console.error('加载失败', err)
    errorMsg.value = '加载失败'
  } finally {
    isLoaded.value = true
  }
})

const goBack = () => {
  router.back()
}
const goTo = () => {
  router.push('/reaction')
}

const age = computed(() => {
  if (!jobSeeker.value?.birth_date) return '未知'
  return dayjs().year() - dayjs(jobSeeker.value.birth_date).year()
})

const formatDate = (dateStr) => {
  return dayjs(dateStr).format('YYYY.MM')
}

const handleFavorite = async () => {
  errorMsg.value = ''

  try {
    const [companyRes, jobSeekerRes] = await Promise.all([
      getCompany(companyId),
      getJobSeeker(jobSeekerId)
    ])

    const payload = {
      company: companyRes.data.id,
      job_seeker: jobSeekerRes.data.id
    }

    if (isFavorited.value) {
      // ⭐️ 取消收藏，传入 { id: favoriteId }
      if (favoriteId.value != null) {
        console.log('🗑️ 删除收藏 ID:', favoriteId.value)
        await deleteCompanyFavoriteJobSeeker(favoriteId.value)
        isFavorited.value = false
        favoriteId.value = null
        alert('✅ 已取消收藏！')
      } else {
        console.warn('⚠️ 收藏 ID 不存在，无法取消')
      }
    } else {
      // 添加收藏
      console.log('📦 添加收藏 payload:', payload)
      await addCompanyFavoriteJobSeeker(payload)
      isFavorited.value = true
      alert('✅ 加入收藏成功！')

      // 添加成功后刷新收藏 ID
      const favRes = await getCompanyFavoriteJobSeekers()
      const matched = favRes.data.find(fav =>
        Number(fav.job_seeker?.id) === jobSeekerId &&
        Number(fav.company) === companyId
      )
      if (matched) {
        favoriteId.value = matched.id
      }
    }
  } catch (err) {
    console.error('❌ 操作失败:', err)
    if (err.response?.data) {
      errorMsg.value = err.response.data.message || '操作失败'
    } else {
      errorMsg.value = '发生未知错误'
    }
  }
}
</script>


<template>
  <div class="job-seeker-detail" v-if="jobSeeker">
    <button class="back-btn" @click="goBack">← 返回</button>
    <button class="back-btn" @click="goTo">← 进行AI人岗匹配</button>
    <h2>{{ jobSeeker.name }} 的详细信息</h2>

    <p><strong>性别：</strong>{{ jobSeeker.gender }}</p>
    <p><strong>年龄：</strong>{{ age }} 岁</p>
    <p><strong>最高学历：</strong>{{ jobSeeker.education }}</p>

    <!-- 教育经历 -->
    <section>
      <h3>教育经历</h3>
      <ul>
        <li v-for="(edu, i) in jobSeeker.education_experiences" :key="i">
          🎓 {{ edu.school.name }} · {{ edu.major }} · {{ edu.degree }}
          （{{ formatDate(edu.start_date) }} - {{ formatDate(edu.end_date) }}）
        </li>
      </ul>
    </section>

    <!-- 期望岗位 -->
    <section>
      <h3>期望岗位</h3>
      <p><strong>城市：</strong>{{ jobSeeker.desired_cities.map(c => c.city.name).join('、') }}</p>
      <p><strong>行业：</strong>{{ jobSeeker.desired_industries.map(i => i.industry.name).join('、') }}</p>
      <p><strong>岗位：</strong>{{ jobSeeker.desired_job_titles.map(t => t.job_title.name).join('、') }}</p>
    </section>

    <!-- 语言能力 -->
    <section>
      <h3>语言能力</h3>
      <ul>
        <li v-for="(lang, i) in jobSeeker.languages" :key="i">
          {{ lang.language.name }} · {{ lang.proficiency }}
        </li>
      </ul>
    </section>

    <!-- 工作经历 -->
    <section v-if="jobSeeker.work_experience?.length">
      <h3>工作经历</h3>
      <div v-for="(job, i) in jobSeeker.work_experience" :key="i" class="job-block">
        <p><strong>💼 {{ job.company_name }}</strong> · {{ job.job_title }}</p>
        <p>📅 {{ formatDate(job.start_date) }} - {{ formatDate(job.end_date) }}</p>
        <ul v-if="job.responsibilities && job.responsibilities.length">
          <li v-for="(res, j) in job.responsibilities" :key="j">- {{ res }}</li>
        </ul>
      </div>
    </section>

    <!-- 项目经历 -->
    <section v-if="jobSeeker.project_experience?.length">
      <h3>项目经历</h3>
      <div v-for="(proj, i) in jobSeeker.project_experience" :key="i" class="project-block">
        <p><strong>📁 {{ proj.project_name }}</strong> · {{ proj.role }}</p>
        <p>📅 {{ formatDate(proj.start_date) }} - {{ formatDate(proj.end_date) }}</p>
        <p>{{ proj.description }}</p>
        <p><strong>使用技术：</strong>{{ proj.technologies.join('、') }}</p>

        <ul v-if="proj.responsibilities && proj.responsibilities.length">
          <li v-for="(res, j) in proj.responsibilities" :key="'res' + j">- {{ res }}</li>
        </ul>

        <ul v-if="proj.achievements && proj.achievements.length">
          <li v-for="(ach, j) in proj.achievements" :key="'ach' + j">🏆 {{ ach }}</li>
        </ul>
      </div>
    </section>

    <!-- 收藏按钮 -->
    <div v-if="isLoaded">
      <button
        class="favorite-btn"
        :class="{ disabled: isFavorited }"
        @click="handleFavorite"
      >
        {{ isFavorited ? '取消收藏' : '加入收藏' }}
      </button>
      <pre v-if="errorMsg" class="error-msg">❌ {{ errorMsg }}</pre>
    </div>
    <div v-else>
      <p>正在检查收藏状态...</p>
    </div>
  </div>

  <div v-else>
    <p>加载中...</p>
  </div>
</template>


<style scoped>
.job-seeker-detail {
  max-width: 800px;
  margin: 32px auto;
  padding: 24px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background: white;
  font-family: sans-serif;
}

h2 {
  font-size: 22px;
  margin-bottom: 16px;
}

.back-btn {
  margin-bottom: 20px;
  padding: 6px 14px;
  border: none;
  background: #eee;
  cursor: pointer;
}

.favorite-btn {
  margin-top: 20px;
  background-color: #409eff;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
}

.favorite-btn:hover {
  background-color: #337ecc;
}

.favorite-btn.disabled {
  background-color: #aaa;
}

.error-msg {
  color: red;
  margin-top: 10px;
  white-space: pre-wrap;
}
.back-btn {
  background-color: #e74c3c;     /* 红色主色 */
  color: white;                  /* 白色文字 */
  border: none;                  /* 去边框 */
  padding: 10px 20px;            /* 内边距 */
  font-size: 16px;               /* 字体大小 */
  font-weight: bold;            /* 加粗文字 */
  border-radius: 8px;           /* 圆角 */
  cursor: pointer;              /* 鼠标样式 */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);  /* 阴影 */
  transition: background-color 0.3s ease, transform 0.2s ease;
}

.back-btn:hover {
  background-color: #c0392b;     /* 悬停颜色 */
  transform: translateY(-2px);   /* 轻微上移动效 */
}

</style>