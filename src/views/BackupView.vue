<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP

const wsb = data.wsb
const veeam = data.veeam
</script>

<template>
  <Card col="col-md-6" title="💾 Sauvegardes">
    <div class="d-flex align-items-center gap-3 py-1 px-2 bg-light rounded">
      <emoji-success />
      <div>
        <div class="fw-bold">WSB</div>
        <div>{{ wsb.LastSuccessfulBackupTime }}</div>
        <div class="text-muted">
          Dernière sauvegarde réussie ({{ wsb.NumberOfVersions }} sauvegardes)
        </div>
      </div>
    </div>

    <hr class="my-3" />

    <div class="d-flex align-items-center gap-3 py-1 px-2 bg-light rounded">
      <emoji-success v-if="veeam.Message.includes('Success')" />
      <emoji-warning v-if="veeam.Message.includes('Warning')" />
      <emoji-danger v-if="veeam.Message.includes('Failed')" />
      <div>
        <div class="fw-bold">Veeam</div>
        <div>{{ veeam.TimeWritten }}</div>
        <div class="text-muted">{{ veeam.Message.replaceAll('.', ' ') }}</div>
      </div>
    </div>
  </Card>
</template>
