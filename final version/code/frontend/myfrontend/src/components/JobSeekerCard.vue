<template>
    <router-link :to="`${$route.fullPath.replace(/\/$/, '')}/${jobSeeker.id}`" class="card-link">

        <div class="job-seeker-card">
            <!-- block1: 左侧头像 -->
            <div class="block1">
                <img :src="avatarSrc" alt="avatar" class="avatar" />
            </div>

            <!-- block2: 基本信息 + 期望 -->
            <div class="block2">
                <div class="basic-info">
                    <span class="name">{{ jobSeeker.name }}</span>
                    <span class="gender-icon">{{ genderSymbol }}</span>
                    <span class="desc">
                        {{ age }}岁 · {{ jobSeeker.education }}
                    </span>
                </div>
                <div class="expectation">
                    求职期望：
                    <span>
                        {{jobSeeker.desired_cities.map(c => c.city.name).join('、') || '未知城市'}}
                    </span>
                    /
                    <span>
                        {{jobSeeker.desired_job_titles.map(t => t.job_title.name).join('、') || '未知岗位'}}
                    </span>
                </div>
            </div>

            <!-- block3: 教育经历 + 工作经历 -->
            <div class="block3">
                <div v-for="(edu, i) in jobSeeker.education_experiences" :key="'edu' + i">
                    🎓 {{ edu.school.name }} · {{ edu.major }} · {{ edu.degree }}
                    （{{ formatDate(edu.start_date) }} - {{ formatDate(edu.end_date) }}）
                </div>
                <div v-for="(job, index) in jobSeeker.work_experience" :key="'job' + index">
                    💼 {{ job.company_name }} · {{ job.job_title }}
                </div>
            </div>

          
        </div>
    </router-link>
</template>


<script setup>
import { computed } from 'vue'
import dayjs from 'dayjs'

const props = defineProps({
    jobSeeker: Object
})

const jobSeeker = props.jobSeeker

const avatarSrc = computed(() => {
    if (jobSeeker.gender === '男') return '/images/male.jpg'
    if (jobSeeker.gender === '女') return '/images/female.jpg'
    return '/images/unknown.jpg'
})

const genderSymbol = computed(() => {
    if (jobSeeker.gender === '男') return '♂'
    if (jobSeeker.gender === '女') return '♀'
    return '⚧'
})

const formatDate = (dateStr) => {
    return dayjs(dateStr).format('YYYY.MM')
}

const age = computed(() => {
    const birthYear = dayjs(props.jobSeeker.birth_date).year()
    return dayjs().year() - birthYear
})
</script>

<style scoped>
.job-seeker-card {
    display: flex;
    align-items: flex-start;
    padding: 16px;
    border-bottom: 1px solid #ddd;
    font-family: sans-serif;
    width: 100%
}

/* block1: 头像 */
.block1 {
    width: 64px;
    margin-right: 16px;
}

.avatar {
    width: 64px;
    height: 64px;
    border-radius: 50%;
}

/* block2: 基本信息 */
.block2 {
    flex: 1;
    min-width: 180px;
    margin-right: 16px;
}

.name {
    font-size: 18px;
    font-weight: bold;
    margin-right: 8px;
}

.gender-icon {
    font-size: 14px;
    color: #409eff;
}

.desc {
    font-size: 14px;
    color: #666;
}

.expectation {
    margin-top: 8px;
    font-size: 14px;
    color: #333;
}

/* block3: 教育/工作经历 */
.block3 {
    flex: 1.5;
    font-size: 13px;
    color: #555;
    line-height: 1.6;
    min-width: 300px;
    margin-right: 16px;
}

/* block4: 按钮 */
.block4 {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
}

.contact-btn {
    background-color: #409eff;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
}

.card-link {
  text-decoration: none;
  color: inherit;
}
</style>
