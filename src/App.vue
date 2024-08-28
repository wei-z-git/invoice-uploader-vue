<template>
  <div id="app">
    <FileUpload />
    <HelloWorld />
  </div>
</template>

<script>
import FileUpload from './components/FileUpload.vue';
import HelloWorld from './components/HelloWorld.vue';
export default {
  components: {
    FileUpload,HelloWorld
  },
};
</script>

<style>
#app {
  text-align: center;
  margin-top: 40px;
}
</style>
