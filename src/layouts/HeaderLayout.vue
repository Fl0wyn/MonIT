<script setup lang="ts">
import { date } from '@/data'
import { formatDate, getWeek } from '@/utils'

const weekNumber = getWeek(date)
const fullDate = formatDate(date)
</script>

<template>
  <div class="page-header d-print-none">
    <div class="container-xl">
      <div class="page-pretitle">Semaine {{ weekNumber }}</div>
      <h2 class="page-title">{{ fullDate }}</h2>
    </div>
  </div>
</template>
