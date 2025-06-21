<template>
    <router-link :to="`${$route.fullPath.replace(/\/$/, '')}/${position.id}`" class="card-link">
      <div class="position-card">
        <!-- 左侧：职位基本信息 -->
        <div class="left">
          <h3 class="title">{{ position.job_title.name }}</h3>
          <p class="salary">💰 {{ position.min_salary }}k - {{ position.max_salary }}k / 月</p>
          <p class="desc">
            📍 {{ position.city.province }}{{ position.city.name }} |
            🧠 {{ position.experience_required }} |
            🎓 {{ position.education_required }}
          </p>
        </div>
  

        <div class="right">
          <p>公司: {{ position.company.name }}</p>
        </div>
      </div>
    </router-link>
  </template>
  
  <script setup>
  const props = defineProps({
    position: Object
  })
  </script>
  
  <style scoped>
  .position-card {
    display: flex;
    justify-content: space-between;
    padding: 16px;
    border-bottom: 1px solid #eee;
    background: #fafafa;
    border-radius: 8px;
    transition: background-color 0.3s ease;
    margin-bottom: 1rem;
  }
  
  .position-card:hover {
    background: #f0f8ff;
  }
  
  .left h3 {
    margin: 0;
    font-size: 18px;
    color: #333;
  }
  
  .salary {
    color: #e67e22;
    font-weight: bold;
    margin: 0.25rem 0;
  }
  
  .desc {
    font-size: 14px;
    color: #666;
  }
  
  .right {
    text-align: right;
    font-size: 13px;
    color: #444;
    white-space: nowrap;
  }
  
  .card-link {
    text-decoration: none;
    color: inherit;
  }
  </style>
  