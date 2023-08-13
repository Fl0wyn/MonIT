<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Table from '@/components/TableComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { useAppStore } from '@/stores/index'
const data = useAppStore().DATA_APP.omRaidStatus

const thead = [
  { name: 'Nom' },
  { name: 'Type' },
  { name: 'Statut' },
  { name: 'Etat' },
  { name: 'Média' }
]
</script>
<template>
  <Card col="col-md-6" title="💽 Santé des RAID" :thead="thead">
    <Table :thead="thead" v-if="data !== null">
      <tr v-for="item in data" :key="item.name" v-show="item.name && !item.name.includes('Name')">
        <td>{{ item.name }}</td>
        <td>{{ item.layout }}</td>
        <!-- Statut-->
        <td>
          <emoji-success v-if="item.status.includes('Ok')" />
          <emoji-danger v-else />
          {{ item.status }}
        </td>
        <!-- Etat-->
        <td>
          <emoji-success v-if="item.state.includes('Ready')" />
          <emoji-danger v-else />
          {{ item.state }}
        </td>
        <!-- Media-->
        <td>{{ item.media }}</td>
      </tr>
    </Table>
    <Empty v-else />
  </Card>
</template>
