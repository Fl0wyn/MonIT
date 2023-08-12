<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP.reliability

import dayjs from 'dayjs'
import 'dayjs/locale/fr'
import weekOfYear from 'dayjs/plugin/weekOfYear'

dayjs.locale('fr')
dayjs.extend(weekOfYear)
</script>

<template>
  <Card class="col-md-6" title="🔍 Historique">
    <ul class="steps steps-counter steps-vertical">
      <li class="step-item" v-for="item in data" :key="item.TimeGenerated">
        <div>{{ dayjs(item.TimeGenerated.split('.')[0]).format('DD/MM/YYYY') }}</div>
        <div>{{ item.SourceName }}</div>
        <p class="text-muted mt-1">{{ item.Message }}</p>
      </li>
    </ul>
  </Card>
</template>
