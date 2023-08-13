<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP.disk

import { convertSize } from '@/utils'

const bgColor = (item: any) => {
  if (item.FreeSpace / item.Size > 0.2) return 'bg-primary'
  else if (item.FreeSpace / item.Size > 0.1) return 'bg-warning'
  else return 'bg-danger'
}
</script>

<template>
  <Card title="📁 Liste des lecteurs">
    <div class="d-flex flex-wrap gap-4" v-if="data !== null">
      <div v-for="item in data" style="min-width: 12rem" :key="item.VolumeName">
        {{ item.VolumeName }} ({{ item.DeviceID }})
        <div class="progress my-1" style="height: 15px">
          <div
            class="progress-bar"
            :class="bgColor(item)"
            :style="{
              width: +Math.round(((item.Size - item.FreeSpace) / item.Size) * 100) + '%'
            }"
          ></div>
        </div>
        {{
          String(convertSize(item.FreeSpace)).length > 6
            ? convertSize(item.FreeSpace).split(' ')[0] +
              ' ' +
              convertSize(item.FreeSpace).split(' ')[1]
            : convertSize(item.FreeSpace)
        }}

        libres sur

        {{
          String(convertSize(item.Size)).length > 6
            ? convertSize(item.Size).split(' ')[0] + ' ' + convertSize(item.Size).split(' ')[1]
            : convertSize(item.Size)
        }}
      </div>
    </div>
    <Empty v-else />
  </Card>
</template>
