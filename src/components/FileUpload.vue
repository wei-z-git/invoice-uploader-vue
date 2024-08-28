<template>
  <a-card title="团建发票上传" class="upload-card">
    <a-upload 
      v-model:file-list="formState.fileList" 
      :max-count="1" 
      :before-upload="beforeUpload" 
      @change="handleFileChange">
      <a-button>
        <upload-outlined></upload-outlined>
        Select files
      </a-button>
    </a-upload>

    <a-form
      ref="formRef"
      :model="formState"
      :label-col="labelCol"
      :wrapper-col="wrapperCol"
    >
      <a-form-item label="类型">
        <a-select v-model:value="formState.invoicetype" placeholder="请选择类型">
          <a-select-option value="个人贡献发票">个人贡献发票</a-select-option>
          <a-select-option value="团建发票">团建发票</a-select-option>
        </a-select>
      </a-form-item>
      
      <a-form-item label="文件标题">
        <a-input placeholder="请输入文件标题" v-model:value="formState.title" />
      </a-form-item>
      
      <a-form-item>
        <a-button type="primary" @click="uploadFile">上传</a-button>
      </a-form-item>
    </a-form>
  </a-card>
</template>

<script lang="ts" setup>
import { reactive, ref, toRaw } from 'vue';
import { message } from 'ant-design-vue';
import { UploadOutlined } from '@ant-design/icons-vue';
import axios from 'axios';
import type { UploadChangeParam } from 'ant-design-vue';
import type { UnwrapRef } from 'vue';

interface FormState {
  invoicetype: string;
  title: string | undefined;
  fileList: any[]; // 添加 fileList 属性
}

const formRef = ref();
const formState: UnwrapRef<FormState> = reactive({
  invoicetype: '',
  title: '',
  fileList: [], // 初始化为一个空数组
});

// 定义响应式变量
const selectedFile = ref<File | null>(null);

// 用来观察上传的文件列表
const handleFileChange = (info: UploadChangeParam) => {
  formState.fileList = info.fileList;
};

const beforeUpload = (file: File) => {
  selectedFile.value = file;
  return false; // 阻止自动上传
};

// 文件上传处理
async function uploadFile() {
  if (!selectedFile.value) {
    message.error('请选择一个文件');
    return;
  }

  // 使用 FormData 来上传文件
  const formData = new FormData();
  formData.append('file', selectedFile.value as File);
  formData.append('invoicetype', formState.invoicetype);
  formData.append('title', formState.title || '');
  const apiUrl = import.meta.env.VITE_API_URL;
  try {
    const response = await axios.post(apiUrl+'/v1/upload/', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    message.success('上传成功');
    console.log('上传成功:', response.data);
    formState.fileList = []; // 清空文件列表
    selectedFile.value = null;
    formState.invoicetype = '';
    formState.title = '';

  } catch (error) {
    message.error('上传失败');
    console.error('上传失败:', error);
  }
}
</script>
