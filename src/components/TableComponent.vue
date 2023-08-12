<script setup lang="ts">
defineProps<{
  title?: string
  col?: string
  status?: {
    direction: 'top' | 'bottom' | 'start' | 'end'
    color: string
  }
  thead: {
    name: string
    colspan?: number
  }[]
}>()
</script>

<template>
  <div :class="col">
    <div class="card">
      <div v-if="status" :class="`card-status-${status.direction} bg-${status.color}`"></div>
      <div class="card-header" v-if="title">
        <h3 class="card-title">{{ title }}</h3>
      </div>
      <div class="table-responsive overflow-auto" style="max-height: 720px">
        <table class="table card-table table-striped table-borderless table-vcenter">
          <thead>
            <tr>
              <th v-for="(item, i) in thead" :key="i" :colspan="item.colspan">{{ item.name }}</th>
            </tr>
          </thead>
          <tbody>
            <slot />
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
