<template>
    <div class="container">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回我的信息</button>
      
    
  
      <!-- 工作经历 -->
      <form @submit.prevent="updateWorkExperience">
        <h3>工作经历</h3>
        <div v-for="(work, index) in form.work_experience" :key="index" class="experience-section">
          <h4>工作经历 #{{ index + 1 }}</h4>
          <div>
            <label>公司名称：</label>
            <input v-model="work.company_name" />
          </div>
          <div>
            <label>职位名称：</label>
            <input v-model="work.job_title" />
          </div>
          <div>
            <label>开始日期：</label>
            <input type="date" v-model="work.start_date" />
          </div>
          <div>
            <label>结束日期：</label>
            <input type="date" v-model="work.end_date" />
          </div>
          <div>
            <label>职责：</label>
            <textarea v-model="work.responsibilities_text" rows="6" />
          </div>
          <button type="button" @click="deleteWorkExperience(index)" class="remove-button">删除此工作经历</button>
        </div>
        <button type="button" @click="appendWorkExperience" class="add-button">添加工作经历</button>
        <button type="submit">保存工作经历</button>
      </form>
  
      <hr />
  
      <!-- 项目经历 -->
      <form @submit.prevent="updateProjectExperience">
        <h3>项目经历</h3>
        <div v-for="(project, index) in form.project_experience" :key="index" class="experience-section">
          <h4>项目经历 #{{ index + 1 }}</h4>
          <div>
            <label>项目名称：</label>
            <input v-model="project.project_name" />
          </div>
          <div>
            <label>角色：</label>
            <input v-model="project.role" />
          </div>
          <div>
            <label>开始日期：</label>
            <input type="date" v-model="project.start_date" />
          </div>
          <div>
            <label>结束日期：</label>
            <input type="date" v-model="project.end_date" />
          </div>
          <div>
            <label>描述：</label>
            <textarea v-model="project.description" rows="3" />
          </div>
          <div>
            <label>技术栈（以逗号分隔）：</label>
            <input v-model="project.technologies_text" />
          </div>
          <div>
            <label>成果：</label>
            <textarea v-model="project.achievements_text" rows="6" />
          </div>
          <div>
            <label>职责：</label>
            <textarea v-model="project.responsibilities_text" rows="6" />
          </div>
          <button type="button" @click="deleteProjectExperience(index)" class="remove-button">删除此项目经历</button>
        </div>
        <button type="button" @click="appendProjectExperience" class="add-button">添加项目经历</button>
        <button type="submit">保存项目经历</button>
      </form>
  
      <hr />
  
      
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue';
  import {
    getJobSeeker, updateJobSeeker, updateCurrentUser,
    getLanguages, getJobSeekerLanguages, updateJobSeekerLanguage,
    getSchools, getEducationExperiences, updateEducationExperience,
    getIndustries, getDesiredIndustries, updateDesiredIndustry,
    getJobTitles, getDesiredJobTitles, updateDesiredJobTitle,
    getCities, getDesiredCities, updateDesiredCity
  } from '../api/api.js';
  import { useRoute, useRouter } from 'vue-router';
  
  const route = useRoute();
  const router = useRouter();
  const id = ref(route.params.id);
  
  const goBack = () => {
    router.push(`/jobseeker_home/jobseeker_info/${id.value}`);
  };
  
  const form = ref({
   
    work_experience: [],
    project_experience: []
  
  });
  
  
  const appendWorkExperience = () => {
    form.value.work_experience.push({
      company_name: '',
      job_title: '',
      start_date: '',
      end_date: '',
      responsibilities_text: ''
    });
  };
  
  const deleteWorkExperience = (index) => {
    if (form.value.work_experience.length > 1) {
      form.value.work_experience.splice(index, 1);
    } else {
      alert('至少保留一份工作经历');
    }
  };
  
  const appendProjectExperience = () => {
    form.value.project_experience.push({
      project_name: '',
      role: '',
      start_date: '',
      end_date: '',
      description: '',
      technologies_text: '',
      achievements_text: '',
      responsibilities_text: ''
    });
  };
  
  const deleteProjectExperience = (index) => {
    if (form.value.project_experience.length > 1) {
      form.value.project_experience.splice(index, 1);
    } else {
      alert('至少保留一份项目经历');
    }
  };
  
  onMounted(async () => {
    try {
      // Fetch job seeker basic info
      const jobSeekerData = await getJobSeeker(id.value);
      const raw = jobSeekerData.data;
  
  
      // Handle multiple work experiences
      form.value.work_experience = Array.isArray(raw.work_experience) && raw.work_experience.length
        ? raw.work_experience.map(work => ({
            company_name: work.company_name || '',
            job_title: work.job_title || '',
            start_date: work.start_date || '',
            end_date: work.end_date || '',
            responsibilities_text: work.responsibilities?.join('\n') || ''
          }))
        : [{
            company_name: '',
            job_title: '',
            start_date: '',
            end_date: '',
            responsibilities_text: ''
          }];
  
      // Handle multiple project experiences
      form.value.project_experience = Array.isArray(raw.project_experience) && raw.project_experience.length
        ? raw.project_experience.map(project => ({
            project_name: project.project_name || '',
            role: project.role || '',
            start_date: project.start_date || '',
            end_date: project.end_date || '',
            description: project.description || '',
            technologies_text: project.technologies?.join(', ') || '',
            achievements_text: project.achievements?.join('\n') || '',
            responsibilities_text: project.responsibilities?.join('\n') || ''
          }))
        : [{
            project_name: '',
            role: '',
            start_date: '',
            end_date: '',
            description: '',
            technologies_text: '',
            achievements_text: '',
            responsibilities_text: ''
          }];
  
      
     
  
     
    } catch (e) {
      console.error('Failed to fetch data in onMounted', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value
      });
      alert('获取数据失败，请稍后重试');
    }
  });
 
  
  const updateWorkExperience = async () => {
    try {
      const updatedJobSeeker = {
        id: id.value,
        work_experience: form.value.work_experience.map(work => ({
          company_name: work.company_name || '',
          job_title: work.job_title || '',
          start_date: work.start_date || '',
          end_date: work.end_date || '',
          responsibilities: work.responsibilities_text
            ? work.responsibilities_text.split('\n').filter(r => r.trim())
            : []
        }))
      };
  
      console.log('Attempting to update work experience', { jobSeekerId: id.value, data: updatedJobSeeker });
  
      const jobSeekerResponse = await updateJobSeeker(id.value, updatedJobSeeker);
      if (!jobSeekerResponse || jobSeekerResponse.status !== 200) {
        const error = new Error('更新工作经历失败，服务器返回非200状态');
        console.error('Failed in updateWorkExperience: updateJobSeeker', {
          error: error.message,
          stack: error.stack,
          responseStatus: jobSeekerResponse?.status,
          responseData: jobSeekerResponse?.data,
          jobSeekerId: id.value,
          data: updatedJobSeeker
        });
        throw error;
      }
  
      alert('工作经历更新成功');
      console.log('Work experience updated successfully', { jobSeekerId: id.value });
    } catch (e) {
      console.error('Failed in updateWorkExperience', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: form.value.work_experience
      });
      alert(`工作经历更新失败: ${e.message || '未知错误'}`);
    }
  };
  
  const updateProjectExperience = async () => {
    try {
      const updatedJobSeeker = {
        id: id.value,
        project_experience: form.value.project_experience.map(project => ({
          project_name: project.project_name || '',
          role: project.role || '',
          start_date: project.start_date || '',
          end_date: project.end_date || '',
          description: project.description || '',
          technologies: project.technologies_text
            ? project.technologies_text.split(',').map(t => t.trim()).filter(t => t)
            : [],
          achievements: project.achievements_text
            ? project.achievements_text.split('\n').filter(a => a.trim())
            : [],
          responsibilities: project.responsibilities_text
            ? project.responsibilities_text.split('\n').filter(r => r.trim())
            : []
        }))
      };
  
      console.log('Attempting to update project experience', { jobSeekerId: id.value, data: updatedJobSeeker });
  
      const jobSeekerResponse = await updateJobSeeker(id.value, updatedJobSeeker);
      if (!jobSeekerResponse || jobSeekerResponse.status !== 200) {
        const error = new Error('更新项目经历失败，服务器返回非200状态');
        console.error('Failed in updateProjectExperience: updateJobSeeker', {
          error: error.message,
          stack: error.stack,
          responseStatus: jobSeekerResponse?.status,
          responseData: jobSeekerResponse?.data,
          jobSeekerId: id.value,
          data: updatedJobSeeker
        });
        throw error;
      }
  
      alert('项目经历更新成功');
      console.log('Project experience updated successfully', { jobSeekerId: id.value });
    } catch (e) {
      console.error('Failed in updateProjectExperience', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: form.value.project_experience
      });
      alert(`项目经历更新失败: ${e.message || '未知错误'}`);
    }
  };
  
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
  select,
  textarea {
    width: 60%;
    padding: 4px;
  }
  textarea {
    resize: vertical;
  }
  button {
    padding: 8px 16px;
    margin-top: 10px;
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
    margin-right: 10px;
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
  h3 {
    margin-top: 20px;
    margin-bottom: 10px;
  }
  h4 {
    margin-top: 10px;
    margin-bottom: 10px;
    color: #34495e;
  }
  </style>