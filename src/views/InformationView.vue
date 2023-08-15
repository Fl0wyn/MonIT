<script lang="ts" setup>
import Card from '@/components/CardComponent.vue'
import { info } from '@/data'
import { convertSize, formatDate } from '@/utils'

const dataMap = [
  { k: "Domaine et nom d'hôte", v: info.hostname },
  { k: "Système d'exploitation", v: info.os },
  { k: 'Mémoire', v: convertSize(info.memory) },
  { k: 'Processeur', v: info.cpu },
  { k: 'Fabricant', v: info.manufacturer },
  { k: 'Numero de série', v: info.serialnumber },
  {
    k: 'Dernier redémarrage',
    v: formatDate(info.lastreboot)
  }
]
</script>

<template>
  <Card no-body col="col-12" title="📰 Information">
    <div class="list-group list-group-flush">
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
  </Card>
</template>
