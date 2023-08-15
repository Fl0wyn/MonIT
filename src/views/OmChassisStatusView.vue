<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Table from '@/components/TableComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { omChassisStatus } from '@/data'

const thead = [{ name: 'Statut' }, { name: 'Composant' }]
</script>
<template>
  <Card no-body col="col-md-6" title="⚙️ Santé du matériel">
    <Table :thead="thead" v-if="omChassisStatus !== null">
      <tr v-for="item in omChassisStatus" :key="item.component">
        <td>
          <emoji-success v-if="item.severity.includes('Ok')" />
          <emoji-danger v-else />
          {{ item.severity }}
        </td>
        <td>{{ item.component }}</td>
      </tr>
    </Table>
    <Empty class="p-3" v-else />
  </Card>
</template>
