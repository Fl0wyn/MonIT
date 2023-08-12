<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import { convertSize } from '@/utils'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP.info
</script>

<template>
  <Card no-body col="col-12" title="📰 Information">
    <div class="list-group list-group-flush">
      <div class="list-group-item" v-for="item in data" :key="item.name">
        <div class="row align-items-center">
          <div class="col-auto">
            <span class="badge bg-primary"></span>
          </div>
          <div class="col text-truncate">
            <small class="d-block text-muted text-truncate mt-n1">
              {{ item.name }}
            </small>
            <span v-if="item.name.includes('Mémoire')">
              {{ convertSize(item.val) }}
            </span>
            <span class="text-capitalize" v-else-if="item.name.includes('redémarrage')">
              {{ item.val }}
            </span>
            <span v-else>{{ item.val }}</span>
          </div>
        </div>
      </div>
    </div>
  </Card>
</template>
