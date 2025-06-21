<template>
    <div class="container">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">← 返回我的信息</button>
      <h2>求职者信息修改</h2>
  
      <!-- 个人信息 -->
      <form @submit.prevent="updatePersonalInfo">
        <h3>个人信息</h3>
        <div>
          <label>姓名：</label>
          <input v-model="form.name" />
        </div>
        <div>
          <label>性别：</label>
          <select v-model="form.gender">
            <option value="男">男</option>
            <option value="女">女</option>
            <option value="其他">其他</option>
          </select>
        </div>
        <div>
          <label>出生日期：</label>
          <input type="date" v-model="form.birth_date" />
        </div>
        <div>
          <label>电话：</label>
          <input v-model="form.phone" />
        </div>
        <div>
          <label>邮箱：</label>
          <input v-model="form.email" />
        </div>
        <div>
          <label>期望工作类型：</label>
          <select v-model="form.expected_work_type">
            <option value="全职">全职</option>
            <option value="兼职">兼职</option>
            <option value="实习">实习</option>
          </select>
        </div>
        <div>
          <label>期望最低薪资：</label>
          <input type="number" v-model.number="form.expected_min_salary" />
        </div>
        <div>
          <label>期望最高薪资：</label>
          <input type="number" v-model.number="form.expected_max_salary" />
        </div>
        <div>
          <label>当前状态：</label>
          <select v-model="form.current_status">
            <option value="在职">在职</option>
            <option value="离职">离职</option>
            <option value="应届生">应届生</option>
          </select>
        </div>
        <button type="submit">保存个人信息</button>
      </form>
  
      <hr />
  
      <!-- 语言能力 -->
      <form @submit.prevent="updateLanguage">
        <h3>语言能力</h3>
        <div>
          <label>语言：</label>
          <select v-model="form.language_id">
            <option v-for="lang in availableLanguages" :key="lang.id" :value="lang.id">
              {{ lang.name }}
            </option>
          </select>
        </div>
        <div>
          <label>熟练程度：</label>
          <input v-model="form.language_proficiency" placeholder="如：母语、熟练、基础" />
        </div>
        <button type="submit">保存语言能力</button>
      </form>
  
      <hr />
  
      <!-- 教育经历 -->
      <form @submit.prevent="updateEducation">
        <h3>教育经历</h3>
        <div>
          <label>学校：</label>
          <select v-model="form.education_experience.school_id">
            <option v-for="school in schools" :key="school.id" :value="school.id">
              {{ school.name }}
            </option>
          </select>
        </div>
        <div>
          <label>学位：</label>
          <select v-model="form.education_experience.degree">
            <option v-for="degree in degreeOptions" :key="degree" :value="degree">{{ degree }}</option>
          </select>
        </div>
        <div>
          <label>专业：</label>
          <input v-model="form.education_experience.major" />
        </div>
        <div>
          <label>开始日期：</label>
          <input type="date" v-model="form.education_experience.start_date" />
        </div>
        <div>
          <label>结束日期：</label>
          <input type="date" v-model="form.education_experience.end_date" />
        </div>
        <button type="submit">保存教育经历</button>
      </form>
  
      <hr />
  
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
  
      <!-- 职业偏好 -->
      <h3>职业偏好</h3>
      <form @submit.prevent="updateDesiredInd">
        <div>
          <label>喜爱行业：</label>
          <select v-model="form.desired_industry_id">
            <option v-for="industry in industries" :key="industry.id" :value="industry.id">
              {{ industry.name }}
            </option>
          </select>
        </div>
        <button type="submit">保存喜爱行业</button>
      </form>
      <form @submit.prevent="updateDesiredJobT">
        <div>
          <label>喜爱岗位：</label>
          <select v-model="form.desired_job_title_id">
            <option v-for="jobTitle in jobTitles" :key="jobTitle.id" :value="jobTitle.id">
              {{ jobTitle.name }}
            </option>
          </select>
        </div>
        <button type="submit">保存喜爱岗位</button>
      </form>
      <form @submit.prevent="updateDesiredC">
        <div>
          <label>喜爱城市：</label>
          <select v-model="form.desired_city_id">
            <option v-for="city in cities" :key="city.id" :value="city.id">
              {{ city.name }}
            </option>
          </select>
        </div>
        <button type="submit">保存喜爱城市</button>
      </form>
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
    name: '',
    gender: '',
    birth_date: '',
    phone: '',
    email: '',
    expected_work_type: '',
    expected_min_salary: null,
    expected_max_salary: null,
    current_status: '',
    language_id: null,
    language_proficiency: '',
    education_experience: {
      id: null,
      school_id: null,
      degree: '',
      major: '',
      start_date: '',
      end_date: ''
    },
    work_experience: [],
    project_experience: [],
    desired_industry_id: null,
    desired_job_title_id: null,
    desired_city_id: null
  });
  
  const availableLanguages = ref([]);
  const schools = ref([]);
  const industries = ref([]);
  const jobTitles = ref([]);
  const cities = ref([]);
  const languageRecordId = ref(null);
  const educationRecordId = ref(null);
  const industryRecordId = ref(null);
  const jobTitleRecordId = ref(null);
  const cityRecordId = ref(null);
  const degreeOptions = ['专科', '学士', '硕士', '博士', 'MBA', 'EMBA'];
  
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
  
      form.value.name = raw.name || '';
      form.value.gender = raw.gender || '';
      form.value.birth_date = raw.birth_date || '';
      form.value.phone = raw.phone || '';
      form.value.email = raw.email || '';
      form.value.expected_work_type = raw.expected_work_type || '';
      form.value.expected_min_salary = raw.expected_min_salary || null;
      form.value.expected_max_salary = raw.expected_max_salary || null;
      form.value.current_status = raw.current_status || '应届生';
  
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
  
      // Fetch languages
      const languagesData = await getLanguages();
      availableLanguages.value = languagesData.data || [];
      const jobSeekerLanguages = await getJobSeekerLanguages();
      const userLanguage = jobSeekerLanguages.data?.find(lang => lang.job_seeker === parseInt(id.value));
      
      if (userLanguage) {
        languageRecordId.value = userLanguage.id;
        form.value.language_id = userLanguage.language?.id || null;
        form.value.language_proficiency = userLanguage.proficiency || '';
      }
      // Fetch education experiences
      const schoolsData = await getSchools();
      schools.value = schoolsData.data || [];
      const educationExperiences = await getEducationExperiences();
      const userEducation = educationExperiences.data?.find(edu => edu.job_seeker === parseInt(id.value));
      if (userEducation) {
        educationRecordId.value = userEducation.id;
        form.value.education_experience.id = userEducation.id;
        form.value.education_experience.school_id = userEducation.school?.id || null;
        form.value.education_experience.degree = userEducation.degree || '';
        form.value.education_experience.major = userEducation.major || '';
        form.value.education_experience.start_date = userEducation.start_date || '';
        form.value.education_experience.end_date = userEducation.end_date || '';
      }
  
      // Fetch desired industries
      const industriesData = await getIndustries();
      industries.value = industriesData.data || [];
      const desiredIndustries = await getDesiredIndustries();
      const userIndustry = desiredIndustries.data?.find(ind => ind.job_seeker === parseInt(id.value));
      if (userIndustry) {
        industryRecordId.value = userIndustry.id;
        form.value.desired_industry_id = userIndustry.industry?.id || null;
      }
  
      // Fetch desired job titles
      const jobTitlesData = await getJobTitles();
      jobTitles.value = jobTitlesData.data || [];
      const desiredJobTitles = await getDesiredJobTitles();
      const userJobTitle = desiredJobTitles.data?.find(job => job.job_seeker === parseInt(id.value));
      if (userJobTitle) {
        jobTitleRecordId.value = userJobTitle.id;
        form.value.desired_job_title_id = userJobTitle.job_title?.id || null;
      }
  
      // Fetch desired cities
      const citiesData = await getCities();
      cities.value = citiesData.data || [];
      const desiredCities = await getDesiredCities();
      const userCity = desiredCities.data?.find(city => city.job_seeker === parseInt(id.value));
      if (userCity) {
        cityRecordId.value = userCity.id;
        form.value.desired_city_id = userCity.city?.id || null;
      }
    } catch (e) {
      console.error('Failed to fetch data in onMounted', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value
      });
      alert('获取数据失败，请稍后重试');
    }
  });
  
  const updateCurrentUserEmail = async (newEmail) => {
    const token = localStorage.getItem('token');
    if (!token) {
      const error = new Error('Token不存在');
      console.error('Failed in updateCurrentUserEmail: No token found', {
        error: error.message,
        stack: error.stack,
        email: newEmail
      });
      alert('请先登录，获取不到token');
      throw error;
    }
    try {
      const response = await updateCurrentUser({ email: newEmail }, token);
      if (response?.status !== 200) {
        const error = new Error('更新当前用户邮箱失败，服务器返回非200状态');
        console.error('Failed in updateCurrentUserEmail: Non-200 response', {
          error: error.message,
          stack: error.stack,
          responseStatus: response?.status,
          responseData: response?.data,
          email: newEmail
        });
        throw error;
      }
      console.log('当前用户邮箱更新成功', { email: newEmail });
    } catch (error) {
      console.error('Failed in updateCurrentUserEmail', {
        error: error.message,
        stack: error.stack,
        email: newEmail
      });
      throw error;
    }
  };
  
  const updatePersonalInfo = async () => {
    try {
      const updatedJobSeeker = {
        id: id.value,
        name: form.value.name || '',
        gender: form.value.gender || '',
        birth_date: form.value.birth_date || '',
        phone: form.value.phone || '',
        email: form.value.email || '',
        expected_work_type: form.value.expected_work_type || '',
        expected_min_salary: form.value.expected_min_salary || null,
        expected_max_salary: form.value.expected_max_salary || null,
        current_status: form.value.current_status || '应届生'
      };
  
      console.log('Attempting to update personal info', { jobSeekerId: id.value, data: updatedJobSeeker });
  
      const jobSeekerResponse = await updateJobSeeker(id.value, updatedJobSeeker);
      if (!jobSeekerResponse || jobSeekerResponse.status !== 200) {
        const error = new Error('更新个人信息失败，服务器返回非200状态');
        console.error('Failed in updatePersonalInfo: updateJobSeeker', {
          error: error.message,
          stack: error.stack,
          responseStatus: jobSeekerResponse?.status,
          responseData: jobSeekerResponse?.data,
          jobSeekerId: id.value,
          data: updatedJobSeeker
        });
        throw error;
      }
  
      await updateCurrentUserEmail(form.value.email);
  
      alert('个人信息更新成功');
      console.log('Personal info updated successfully', { jobSeekerId: id.value });
    } catch (e) {
      console.error('Failed in updatePersonalInfo', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: {
          name: form.value.name,
          gender: form.value.gender,
          birth_date: form.value.birth_date,
          phone: form.value.phone,
          email: form.value.email,
          expected_work_type: form.value.expected_work_type,
          expected_min_salary: form.value.expected_min_salary,
          expected_max_salary: form.value.expected_max_salary,
          current_status: form.value.current_status
        }
      });
      alert(`个人信息更新失败: ${e.message || '未知错误'}`);
    }
  };
  console.log('输入id为：',form.value.language_id)
  const updateLanguage = async () => {
    try {
      if (form.value.language_id && form.value.language_proficiency) {
        const languageData = {
          id: languageRecordId.value || undefined,
          language: form.value.language_id,
          proficiency: form.value.language_proficiency,
          job_seeker: parseInt(id.value)
        };
  
        console.log('Attempting to update language', { jobSeekerId: id.value, data: languageData });
  
        const languageResponse = await updateJobSeekerLanguage(languageData.id, languageData);
        if (!languageResponse || languageResponse.status !== 200) {
          const error = new Error('更新语言能力失败');
          console.error('Failed in updateLanguage: updateJobSeekerLanguage', {
            error: error.message,
            stack: error.stack,
            responseStatus: languageResponse?.status,
            responseData: languageResponse?.data,
            jobSeekerId: id.value,
            data: languageData
          });
          throw error;
        }
        if (!languageRecordId.value && languageResponse.data?.id) {
          languageRecordId.value = languageResponse.data.id;
        }
        alert('语言能力更新成功');
        console.log('Language updated successfully', { jobSeekerId: id.value, languageId: languageRecordId.value });
      } else {
        console.error('Validation failed in updateLanguage', {
          error: 'Missing language or proficiency',
          jobSeekerId: id.value,
          language_id: form.value.language_id,
          language_proficiency: form.value.language_proficiency
        });
        alert('请填写语言和熟练程度');
      }
    } catch (e) {
      console.error('Failed in updateLanguage', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: {
          language_id: form.value.language_id,
          language_proficiency: form.value.language_proficiency
        }
      });
      alert(`语言能力更新失败: ${e.message || '未知错误'}`);
    }
  };
  
  const updateEducation = async () => {
    try {
      
      if (form.value.education_experience.school_id && form.value.education_experience.degree) {
        const selectedSchool = schools.value.find(school => school.id === form.value.education_experience.school_id);
        const educationData = {
          id: educationRecordId.value || undefined,
          school: selectedSchool.id,
          degree: form.value.education_experience.degree,
          major: form.value.education_experience.major || '',
          start_date: form.value.education_experience.start_date || '',
          end_date: form.value.education_experience.end_date || '',
          job_seeker: parseInt(id.value)
        };
  
        console.log('Attempting to update education', { jobSeekerId: id.value, data: educationData });
  
        const educationResponse = await updateEducationExperience(educationData.id, educationData);
        if (!educationResponse || educationResponse.status !== 200) {
          const error = new Error('更新教育经历失败');
          console.error('Failed in updateEducation: updateEducationExperience', {
            error: error.message,
            stack: error.stack,
            responseStatus: educationResponse?.status,
            responseData: educationResponse?.data,
            jobSeekerId: id.value,
            data: educationData
          });
          throw error;
        }
        if (!educationRecordId.value && educationResponse.data?.id) {
          educationRecordId.value = educationResponse.data.id;
        }
        alert('教育经历更新成功');
        console.log('Education updated successfully', { jobSeekerId: id.value, educationId: educationRecordId.value });
      } else {
        console.error('Validation failed in updateEducation', {
          error: 'Missing school or degree',
          jobSeekerId: id.value,
          school_id: form.value.education_experience.school_id,
          degree: form.value.education_experience.degree
        });
        alert('请填写学校和学位');
      }
    } catch (e) {
      console.error('Failed in updateEducation', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: {
          school_id: form.value.education_experience.school_id,
          degree: form.value.education_experience.degree,
          major: form.value.education_experience.major,
          start_date: form.value.education_experience.start_date,
          end_date: form.value.education_experience.end_date
        }
      });
      alert(`教育经历更新失败: ${e.message || '未知错误'}`);
    }
  };
  
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
  
  const updateDesiredInd = async () => {
    try {
      
      if (form.value.desired_industry_id) {
        const selectedIndustry = industries.value.find(ind => ind.id === form.value.desired_industry_id);
        const industryData = {
          id: industryRecordId.value || undefined,
          industry: selectedIndustry.id,
          job_seeker: parseInt(id.value)
        };
        console.log('上传信息：',industryData)
        console.log('Attempting to update desired industry', { jobSeekerId: id.value, data: industryData });
        
        const industryResponse = await updateDesiredIndustry(industryData.id, industryData);
        if (!industryResponse || industryResponse.status !== 200) {
          const error = new Error('更新喜爱行业失败');
          console.error('Failed in updateDesiredIndustry: updateDesiredIndustry', {
            error: error.message,
            stack: error.stack,
            responseStatus: industryResponse?.status,
            responseData: industryResponse?.data,
            jobSeekerId: id.value,
            data: industryData
          });
          throw error;
        }
        if (!industryRecordId.value && industryResponse.data?.id) {
          industryRecordId.value = industryResponse.data.id;
        }
        alert('喜爱行业更新成功');
        console.log('Desired industry updated successfully', { jobSeekerId: id.value, industryId: industryRecordId.value });
      } else {
        console.error('Validation failed in updateDesiredIndustry', {
          error: 'Missing desired industry',
          jobSeekerId: id.value,
          desired_industry_id: form.value.desired_industry_id
        });
        alert('请选择喜爱行业');
      }
    } catch (e) {
      console.error('Failed in updateDesiredIndustry', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: { desired_industry_id: form.value.desired_industry_id }
      });
      alert(`喜爱行业更新失败: ${e.message || '未知错误'}`);
    }
  };
  
  const updateDesiredJobT = async () => {
    try {
      if (form.value.desired_job_title_id) {
        const selectedJobTitle = jobTitles.value.find(job => job.id === form.value.desired_job_title_id);
        const jobTitleData = {
          id: jobTitleRecordId.value || undefined,
          job_title: selectedJobTitle.id,
          job_seeker: parseInt(id.value)
        };
  
        console.log('Attempting to update desired job title', { jobSeekerId: id.value, data: jobTitleData });
  
        const jobTitleResponse = await updateDesiredJobTitle(jobTitleData.id, jobTitleData);
        if (!jobTitleResponse || jobTitleResponse.status !== 200) {
          const error = new Error('更新喜爱岗位失败');
          console.error('Failed in updateDesiredJobTitle: updateDesiredJobTitle', {
            error: error.message,
            stack: error.stack,
            responseStatus: jobTitleResponse?.status,
            responseData: jobTitleResponse?.data,
            jobSeekerId: id.value,
            data: jobTitleData
          });
          throw error;
        }
        if (!jobTitleRecordId.value && jobTitleResponse.data?.id) {
          jobTitleRecordId.value = jobTitleResponse.data.id;
        }
        alert('喜爱岗位更新成功');
        console.log('Desired job title updated successfully', { jobSeekerId: id.value, jobTitleId: jobTitleRecordId.value });
      } else {
        console.error('Validation failed in updateDesiredJobTitle', {
          error: 'Missing desired job title',
          jobSeekerId: id.value,
          desired_job_title_id: form.value.desired_job_title_id
        });
        alert('请选择喜爱岗位');
      }
    } catch (e) {
      console.error('Failed in updateDesiredJobTitle', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: { desired_job_title_id: form.value.desired_job_title_id }
      });
      alert(`喜爱岗位更新失败: ${e.message || '未知错误'}`);
    }
  };
  
  const updateDesiredC = async () => {
    try {
      if (form.value.desired_city_id) {
        const selectedCity = cities.value.find(city => city.id === form.value.desired_city_id);
        const cityData = {
          id: cityRecordId.value || undefined,
          city: selectedCity.id,
          job_seeker: parseInt(id.value)
        };
  
        console.log('Attempting to update desired city', { jobSeekerId: id.value, data: cityData });
  
        const cityResponse = await updateDesiredCity(cityData.id, cityData);
        if (!cityResponse || cityResponse.status !== 200) {
          const error = new Error('更新喜爱城市失败');
          console.error('Failed in updateDesiredCity: updateDesiredCity', {
            error: error.message,
            stack: error.stack,
            responseStatus: cityResponse?.status,
            responseData: cityResponse?.data,
            jobSeekerId: id.value,
            data: cityData
          });
          throw error;
        }
        if (!cityRecordId.value && cityResponse.data?.id) {
          cityRecordId.value = cityResponse.data.id;
        }
        alert('喜爱城市更新成功');
        console.log('Desired city updated successfully', { jobSeekerId: id.value, cityId: cityRecordId.value });
      } else {
        console.error('Validation failed in updateDesiredCity', {
          error: 'Missing desired city',
          jobSeekerId: id.value,
          desired_city_id: form.value.desired_city_id
        });
        alert('请选择喜爱城市');
      }
    } catch (e) {
      console.error('Failed in updateDesiredCity', {
        error: e.message,
        stack: e.stack,
        jobSeekerId: id.value,
        data: { desired_city_id: form.value.desired_city_id }
      });
      alert(`喜爱城市更新失败: ${e.message || '未知错误'}`);
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