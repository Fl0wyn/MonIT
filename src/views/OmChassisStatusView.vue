<script lang="ts" setup>
import Table from '@/components/TableComponent.vue'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP.omChassisStatus

const thead = [{ name: 'Statut' }, { name: 'Composant' }]
</script>
<template>
  <Table col="col-md-6" title="⚙️ Santé du matériel" :thead="thead">
    <tr v-for="item in data" :key="item.component">
      <!-- Statut-->
      <td>
        <emoji-success v-if="item.severity.includes('Ok')" />
        <emoji-danger v-else />
        {{ item.severity }}
      </td>
      <td>{{ item.component }}</td>
    </tr>
  </Table>
</template>
