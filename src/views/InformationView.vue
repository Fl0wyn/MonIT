<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import Empty from '@/components/BadgeEmpty.vue'
import { convertSize, formatDate } from '@/utils'
import { useAppStore } from '@/stores/index'

const data = useAppStore().DATA_APP.info

const dataMap = [
  { k: 'Nom de la machine', v: data.hostname },
  { k: "Système d'exploitation", v: data.os },
  { k: 'Mémoire', v: convertSize(data.memory) },
  { k: 'Processeur', v: data.cpu },
  { k: 'Fabricant', v: data.manufacturer },
  { k: 'Numero de série', v: data.serialnumber },
  {
    k: 'Dernier redémarrage',
    v: formatDate(data.lastreboot)
  }
]
</script>

<template>
  <Card no-body col="col-12" title="📰 Information">
    <div class="list-group list-group-flush" v-if="data !== null">
      <div class="list-group-item" v-for="item in dataMap" :key="item.k">
        <div class="row align-items-center">
          <div class="col-auto">
            <span class="badge bg-primary"></span>
          </div>
          <div class="col text-truncate">
            <small class="d-block text-muted">{{ item.k }}</small>
            {{ item.v }}
          </div>
        </div>
      </div>
    </div>
    <Empty v-else />
  </Card>
</template>
