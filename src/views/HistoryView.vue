<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { useAppStore } from '@/stores/index'
import { formatDate } from '@/utils'
const data = useAppStore().DATA_APP.reliability
</script>

<template>
  <Card class="col-md-6" title="🔍 Historique">
    <ul class="steps steps-counter steps-vertical" v-if="data !== null">
      <li class="step-item" v-for="item in data" :key="item.TimeGenerated">
        <div>{{ formatDate(item.TimeGenerated) }}</div>
        <div>{{ item.SourceName }}</div>
        <p class="text-muted mt-1">{{ item.Message }}</p>
      </li>
    </ul>
    <Empty v-else />
  </Card>
</template>
