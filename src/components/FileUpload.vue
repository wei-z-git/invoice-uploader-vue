<template>
    <div class="file-upload">
      <input type="file" @change="handleFileChange" />
      <button @click="uploadFile">上传</button>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        selectedFile: null,
      };
    },
    methods: {
      handleFileChange(event) {
        this.selectedFile = event.target.files[0];
      },
      async uploadFile() {
        if (!this.selectedFile) {
          alert('请选择一个文件');
          return;
        }
  
        const formData = new FormData();
        formData.append('file', this.selectedFile);
  
        try {
          const response = await axios.post('/api/upload', formData, {
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          });
          console.log('上传成功:', response.data);
        } catch (error) {
          console.error('上传失败:', error);
        }
      },
    },
  };
  </script>
  
  <style scoped>
  .file-upload {
    display: flex;
    flex-direction: column;
    align-items: start;
  }
  </style>