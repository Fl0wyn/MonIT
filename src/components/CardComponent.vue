<script setup lang="ts">
defineProps<{
  title?: string
  col?: string
  status?: {
    direction: 'top' | 'bottom' | 'start' | 'end'
    color: string
  }
  noBody?: boolean
}>()
</script>

<template>
  <div :class="col">
    <div class="card">
      <div v-if="status" :class="`card-status-${status.direction} bg-${status.color}`"></div>
      <div class="card-header" v-if="title">
        <h3 class="card-title">{{ title }}</h3>
      </div>
      <div class="card-body overflow-auto" :class="{ 'p-0': noBody }" style="max-height: 720px">
        <slot />
      </div>
    </div>
  </div>
</template>
