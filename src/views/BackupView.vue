<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { wsb, veeam } from '@/data'
import { formatDate } from '@/utils'
</script>

<template>
  <Card col="col-md-6" title="💾 Sauvegardes">
    <div class="d-flex align-items-center gap-3 py-1 px-2 bg-light rounded" v-if="wsb !== null">
      <emoji-success />
      <div>
        <div class="fw-bold">WSB</div>
        <div>{{ formatDate(wsb.LastSuccessfulBackupTime) }}</div>
        <div class="text-muted">
          Dernière sauvegarde réussie ({{ wsb.NumberOfVersions }} sauvegardes)
        </div>
      </div>
    </div>
    <Empty v-else />

    <hr class="my-3" />

    <div class="d-flex align-items-center gap-3 py-1 px-2 bg-light rounded" v-if="veeam !== null">
      <emoji-success v-if="veeam.Message.includes('Success')" />
      <emoji-warning v-if="veeam.Message.includes('Warning')" />
      <emoji-danger v-if="veeam.Message.includes('Failed')" />
      <div>
        <div class="fw-bold">Veeam</div>
        <div>{{ formatDate(veeam.TimeWritten) }}</div>
        <div class="text-muted">{{ veeam.Message }}</div>
      </div>
    </div>
    <Empty v-else />
  </Card>
</template>
