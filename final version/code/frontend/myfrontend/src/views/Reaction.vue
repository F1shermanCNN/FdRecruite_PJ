<template>
    <div class="simple-page">
      <button class="back-button" @click="goBack">← 返回</button>
  
      <div class="message-box">
        {{ message }}
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  
  const router = useRouter()
  
  // ✨ 留给你设置的文字显示接口
  const message = ref('未检测到端口')
  
  // ✨ 留给你定义的返回逻辑
  const goBack = () => {
    router.back() // 或者 router.push('/other-route')
  }
  </script>
  
  <style scoped>
  .simple-page {
    padding: 24px;
    font-family: sans-serif;
  }
  
  .back-button {
    margin-bottom: 20px;
    padding: 8px 16px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
  }
  
  .back-button:hover {
    background-color: #2980b9;
  }
  
  .message-box {
    padding: 20px;
    background: #f9f9f9;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 18px;
    color: #333;
  }
  </style>
  