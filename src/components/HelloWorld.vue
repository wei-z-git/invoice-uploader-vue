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
import { message } from 'ant-design-vue';
import { UploadOutlined } from '@ant-design/icons-vue';
import type { UploadChangeParam } from 'ant-design-vue';
import axios from 'axios';
const handleChange = (info: UploadChangeParam) => {
  if (info.file.status !== 'uploading') {
    console.log(info.file, info.fileList);
  }
  if (info.file.status === 'done') {
    message.success(`${info.file.name} file uploaded successfully`);
  } else if (info.file.status === 'error') {
    message.error(`${info.file.name} file upload failed.`);
  }
};

const fileList = ref([]);
const headers = {
  authorization: 'authorization-text',
};

</script>

