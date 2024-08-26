<template>
  <div class="file-upload">
    <input type="file" @change="handleFileChange" />
    
    <input 
      type="text" 
      v-model="title" 
      placeholder="请输入文件标题" 
    />
    
    <textarea 
      v-model="description" 
      placeholder="请输入文件描述"
    ></textarea>
    
    <button @click="uploadFile">上传</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      selectedFile: null,
      title: '',
      description: '',
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
      formData.append('title', this.title);
      formData.append('description', this.description);

      try {
        const response = await axios.post(`http://127.0.0.1:8000/v1/upload/`, formData, {
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

.file-upload input,
.file-upload textarea {
  margin-top: 10px;
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}

.file-upload button {
  margin-top: 15px;
  padding: 10px 15px;
  cursor: pointer;
}
</style>
