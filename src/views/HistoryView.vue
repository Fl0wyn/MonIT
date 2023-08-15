<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { reliability } from '@/data'
import { formatDate } from '@/utils'
</script>

<template>
  <Card class="col-md-6" title="🔍 Historique">
    <ul class="steps steps-counter steps-vertical" v-if="reliability !== null">
      <li class="step-item" v-for="item in reliability" :key="item.TimeGenerated">
        <div>{{ formatDate(item.TimeGenerated) }}</div>
        <div>{{ item.SourceName }}</div>
        <p class="text-muted mt-1">{{ item.Message }}</p>
      </li>
    </ul>
    <Empty v-else />
  </Card>
</template>
