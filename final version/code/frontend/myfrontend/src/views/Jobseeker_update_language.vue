<template>
  <div class="container">
    <button class="back-button" @click="goBack">← 返回上一页</button>
    <h2 class="text-xl font-bold mb-6">更新语言能力</h2>
    <div v-if="languageRecords.length && languages.length">
      <div v-for="(record, index) in languageRecords" :key="record.id" class="experience-section">
        <h4>语言能力 {{ index + 1 }}</h4>
        <form @submit.prevent="updateLanguage(index)">
          <div class="form-row">
            <label>语言：</label>
            <select v-model="record.language">
              <option v-for="lang in languages" :key="lang.id" :value="lang.id">
                {{ lang.name }}
              </option>
            </select>
          </div>
          <div class="form-row">
            <label>熟练程度：</label>
            <input v-model="record.proficiency" placeholder="请输入熟练程度" />
          </div>
          <div class="button-group">
            <button type="submit">保存</button>
            <button type="button" class="remove-button" @click="deleteLanguage(index)">删除</button>
          </div>
        </form>
      </div>
    </div>

    <div v-else>
      <p>加载中或无语言能力记录。</p>
    </div>

    <button class="add-button" @click="addLanguage">添加语言能力</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import {
  getLanguages,
  getJobSeeker,
  createJobSeekerLanguage,
  updateJobSeekerLanguage,
  deleteJobSeekerLanguage
} from '../api/api';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();
const id = ref(parseInt(route.params.id));

const goBack = () => {
  router.push(`/jobseeker_home/jobseeker_info/${id.value}`);
};

const languages = ref([]);
const languageRecords = ref([]);

onMounted(async () => {
  try {
    const res1 = await getLanguages();
    languages.value = res1.data;

    const res2 = await getJobSeeker(id.value);
    const raw = res2.data;
    languageRecords.value = (raw.languages || []).map(r => ({
      id: r.id,
      language: r.language.id,
      proficiency: r.proficiency,
      job_seeker: id.value
    }));
  } catch (err) {
    console.error('加载失败：', err);
    alert('加载语言能力失败，请稍后再试');
  }
});

const updateLanguage = async (index) => {
  const rec = languageRecords.value[index];

  // 检查是否有其他记录已使用相同语言
  const isDuplicate = languageRecords.value.some(
    (r, i) => i !== index && r.language === rec.language
  );

  if (isDuplicate) {
    alert(`更新失败：该语言已存在于其他记录中`);
    return;
  }

  try {
    await updateJobSeekerLanguage(rec.id, rec);
    alert(`第 ${index + 1} 条语言能力更新成功`);
  } catch (err) {
    console.error(`更新失败:`, err);
    if (err.response?.data) {
      alert(`更新失败：${JSON.stringify(err.response.data)}`);
    } else {
      alert('更新失败，请检查内容或稍后重试');
    }
  }
};


const deleteLanguage = async (index) => {
  const rec = languageRecords.value[index];
  if (!rec.id) {
    languageRecords.value.splice(index, 1);
    return;
  }
  if (!confirm(`确定删除第 ${index + 1} 条语言能力吗？`)) return;
  try {
    await deleteJobSeekerLanguage(rec.id);
    languageRecords.value.splice(index, 1);
    alert(`第 ${index + 1} 条语言能力删除成功`);
  } catch (err) {
    console.error('删除失败:', err);
    alert('删除失败，请稍后重试');
  }
};

const addLanguage = () => {
  if (!languages.value.length) {
    alert('语言列表为空，无法添加');
    return;
  }

  const existingLanguageIds = languageRecords.value.map(r => r.language);
  const availableLanguages = languages.value.filter(l => !existingLanguageIds.includes(l.id));

  if (!availableLanguages.length) {
    alert('所有语言已添加，无法重复添加');
    return;
  }

  const newLanguage = availableLanguages[0];
  const newRecord = {
    language: newLanguage.id,
    proficiency: '请填写',
    job_seeker: id.value
  };

  createJobSeekerLanguage(newRecord).then(res => {
    languageRecords.value.push({
      ...res.data,
      language: res.data.language
    });
    alert('添加语言能力成功');
  }).catch(err => {
    console.error('添加失败:', err);
    alert('添加失败：请先保存更改内容');
  });
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
.form-row {
  margin-bottom: 12px;
  display: flex;
  flex-direction: column;
}
.form-row label {
  margin-bottom: 4px;
  font-weight: bold;
}
input,
select {
  padding: 6px;
  font-size: 14px;
  border: 1px solid #ccc;
  border-radius: 4px;
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
  display: block;
  margin: 20px auto;
  background-color: #2ecc71;
}
.add-button:hover {
  background-color: #27ae60;
}
.remove-button {
  background-color: #e74c3c;
  margin-left: 10px;
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
.button-group {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-top: 10px;
}
</style>
