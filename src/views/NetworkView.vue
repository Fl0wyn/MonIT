<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import { convertBandwidth } from '@/utils'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP.speedtest
</script>

<template>
  <Card col="col-12" title="🚀 Réseau">
    <div class="d-flex justify-content-between align-items-center text-center gap-2">
      <div class="bg-primary-lt rounded w-100 py-2">
        <div>Download</div>
        <div class="mt-1 fw-bold">{{ convertBandwidth(data.download.bandwidth) }}</div>
      </div>
      <div class="bg-primary-lt rounded w-100 py-2">
        <div>Upload</div>
        <div class="mt-1 fw-bold">{{ convertBandwidth(data.upload.bandwidth) }}</div>
      </div>
      <div class="bg-primary-lt rounded w-100 py-2">
        <div>Ping</div>
        <div class="mt-1 fw-bold">{{ data.ping.latency }} ms</div>
      </div>
    </div>

    <div class="d-flex justify-content-between align-items-center text-center gap-2 mt-3">
      <div class="bg-light rounded w-100 py-2">
        <div>IP privé</div>
        <div class="mt-1 fw-bold">{{ data.interface.internalIp }}</div>
      </div>
      <div class="bg-light rounded w-100 py-2">
        <div>IP public</div>
        <div class="mt-1 fw-bold">{{ data.interface.externalIp }}</div>
      </div>
    </div>
  </Card>
</template>
