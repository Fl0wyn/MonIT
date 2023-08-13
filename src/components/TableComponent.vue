<script setup lang="ts">
defineProps<{
  thead: {
    name: string
    colspan?: number
  }[]
}>()
</script>

<template>
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
</template>
