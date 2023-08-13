<script setup lang="ts">
const weekNumber = 32
const fullDate = 'Dimanche 13 août 2023'
</script>

<template>
  <div class="page-header d-print-none">
    <div class="container-xl">
      <div class="page-pretitle">Semaine {{ weekNumber }}</div>
      <h2 class="page-title">{{ fullDate }}</h2>
    </div>
  </div>
</template>
