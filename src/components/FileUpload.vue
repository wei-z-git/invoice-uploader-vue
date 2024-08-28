<template>
  <a-card title="团建发票上传" class="upload-card">
    <a-upload 
      v-model:file-list="fileList" 
      :max-count="1" 
      @change="handleFileChange">
      <a-button>
        <upload-outlined></upload-outlined>
        Click to Upload
    </a-button>
    </a-upload>

    <a-form layout="vertical" class="upload-form">
      <a-form-item label="类型">
        <a-select v-model="invoicetype" placeholder="请选择类型">
          <a-select-option value="个人贡献发票">个人贡献发票</a-select-option>
          <a-select-option value="团建发票">团建发票</a-select-option>
        </a-select>
      </a-form-item>
      
      <a-form-item label="文件描述">
        <a-textarea v-model="description" placeholder="请输入文件描述" />
      </a-form-item>
      
      <a-form-item>
        <a-button type="primary" @click="uploadFile">上传</a-button>
      </a-form-item>
    </a-form>
  </a-card>

</template>

<script lang="ts" setup>
import { ref } from 'vue';
import axios from 'axios';
import { message } from 'ant-design-vue';

// 定义响应式变量
const selectedFile = ref<File | null>(null);
const invoicetype = ref<string>('个人贡献发票');
const description = ref<string>('');
const fileList = ref([]);

// 文件选择处理
function beforeUpload(file: File) {
  selectedFile.value = file;
  return false; // 阻止自动上传
}

// 文件上传处理
async function uploadFile() {
  if (!selectedFile.value) {
    message.error('请选择一个文件');
    return;
  }

  const formData = new FormData();
  formData.append('file', selectedFile.value);
  formData.append('invoicetype', invoicetype.value);
  formData.append('description', description.value);

  try {
    const response = await axios.post('http://127.0.0.1:8000/v1/upload/', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    message.success('上传成功');
    console.log('上传成功:', response.data);
    fileList.value = []; // 清空文件列表
    selectedFile.value = null;
    invoicetype.value = '个人贡献发票'; // 重置为默认值
    description.value = '';
  } catch (error) {
    message.error('上传失败');
    console.error('上传失败:', error);
  }
}


</script>
