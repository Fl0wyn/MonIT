<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Table from '@/components/TableComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { useAppStore } from '@/stores/index'
import { convertSize } from '@/utils'
const data = useAppStore().DATA_APP.omDiskStatus

const thead = [
  { name: 'Disque' },
  { name: 'Statut' },
  { name: 'Echec' },
  { name: 'Etat' },
  { name: 'Taille' }
]
</script>

<template>
  <Card col="col-md-6" title="💿 Santé des disques">
    <Table :thead="thead" v-if="data !== null">
      <tr v-for="item in data" :key="item.name">
        <td>{{ item.name.split(' ')[2] }}</td>
        <!-- Statut-->
        <td>
          <emoji-success v-if="item.status.includes('Ok')" />
          <emoji-warning v-else-if="item.status.includes('Non-Critical')" />
          <emoji-danger v-else />
          {{ item.status }}
        </td>
        <!-- Echec-->
        <td>
          <emoji-success v-if="item.failure.includes('No')" />
          <emoji-danger v-else />
          {{ item.failure }}
        </td>
        <!-- Etat-->
        <td>
          <emoji-success v-if="item.state.includes('Online')" />
          <emoji-warning v-else-if="item.state.includes('Non-RAID')" />
          <emoji-danger v-else />
          {{ item.state }}
        </td>
        <!-- Taille-->
        <td>
          {{ convertSize(item.capacity.split(' ')[2].replace('(', ' ')) }}
        </td>
      </tr>
    </Table>
    <Empty v-else />
  </Card>
</template>
