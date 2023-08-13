<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Table from '@/components/TableComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP.omChassisStatus

const thead = [{ name: 'Statut' }, { name: 'Composant' }]
</script>
<template>
  <Card col="col-md-6" title="⚙️ Santé du matériel">
    <Table :thead="thead" v-if="data !== null">
      <tr v-for="item in data" :key="item.component">
        <td>
          <emoji-success v-if="item.severity.includes('Ok')" />
          <emoji-danger v-else />
          {{ item.severity }}
        </td>
        <td>{{ item.component }}</td>
      </tr>
    </Table>
    <Empty v-else />
  </Card>
</template>
