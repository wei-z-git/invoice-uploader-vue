<template>
  <div id="app">
    <FileUpload />
  </div>
</template>

<script>
import FileUpload from './components/FileUpload.vue';

export default {
  components: {
    FileUpload,
  },
};
</script>

<style>
#app {
  text-align: center;
  margin-top: 40px;
}
</style>
