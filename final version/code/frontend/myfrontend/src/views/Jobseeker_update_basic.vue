<template>
  <div class="container">
    <button class="back-button" @click="goBack">← 返回上一页</button>
    <h2>编辑基本信息</h2>

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

  </div>
</template>


<script setup>
import { ref, onMounted } from 'vue';
import {
  getJobSeeker, updateJobSeeker, updateCurrentUser
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
  current_status: ''
});




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

  
  } catch (e) {
    console.error('Failed to fetch data in onMounted', {
      error: e.message,
      stack: e.stack,
      jobSeekerId: id.value
    });
    alert('获取数据失败，请稍后重试');
  }
});

const updateCurrentUserEmail = async (newEmail, newUsername) => {
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
    const payload = {
      username: newUsername,
      email: newEmail
    };

    const response = await updateCurrentUser(payload, token);
    if (response?.status !== 200) {
      const error = new Error('更新当前用户邮箱失败，服务器返回非200状态');
      console.error('Failed in updateCurrentUserEmail: Non-200 response', {
        error: error.message,
        stack: error.stack,
        responseStatus: response?.status,
        responseData: response?.data,
        payload
      });
      throw error;
    }
    console.log('当前用户信息更新成功', payload);
  } catch (error) {
    console.error('Failed in updateCurrentUserEmail', {
      error: error.message,
      stack: error.stack,
      email: newEmail,
      username: newUsername
    });
    throw error;
  }
};


const updatePersonalInfo = async () => {
  try {
    // 电话格式校验
    const phoneRegex = /^\d{11}$/;
    if (!phoneRegex.test(form.value.phone)) {
      alert('请输入有效的11位手机号');
      return;
    }

    // 薪资范围校验
    if (
      form.value.expected_min_salary != null &&
      form.value.expected_max_salary != null &&
      form.value.expected_min_salary > form.value.expected_max_salary
    ) {
      alert('期望最低薪资不能高于期望最高薪资');
      return;
    }

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

    await updateCurrentUserEmail(form.value.email, form.value.name);

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