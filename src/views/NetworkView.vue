<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { speedtest } from '@/data'
import { convertBandwidth } from '@/utils'
</script>

<template>
  <Card col="col-12" title="🚀 Réseau">
    <div v-if="speedtest !== null">
      <div class="d-flex justify-content-between align-items-center text-center gap-2">
        <div class="bg-primary-lt rounded w-100 py-2">
          <div>Download</div>
          <div class="mt-1 fw-bold">{{ convertBandwidth(speedtest.download) }}</div>
        </div>
        <div class="bg-primary-lt rounded w-100 py-2">
          <div>Upload</div>
          <div class="mt-1 fw-bold">{{ convertBandwidth(speedtest.upload) }}</div>
        </div>
        <div class="bg-primary-lt rounded w-100 py-2">
          <div>Ping</div>
          <div class="mt-1 fw-bold">{{ speedtest.ping }} ms</div>
        </div>
      </div>
      <div class="d-flex justify-content-between align-items-center text-center gap-2 mt-3">
        <div class="bg-light rounded w-100 py-2">
          <div>IP privé</div>
          <div class="mt-1 fw-bold">{{ speedtest.internalIp }}</div>
        </div>
        <div class="bg-light rounded w-100 py-2">
          <div>IP public</div>
          <div class="mt-1 fw-bold">{{ speedtest.externalIp }}</div>
        </div>
      </div>
    </div>
    <Empty v-else />
  </Card>
</template>
