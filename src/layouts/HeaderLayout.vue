<script setup lang="ts">
import dayjs from 'dayjs'
import 'dayjs/locale/fr'
import weekOfYear from 'dayjs/plugin/weekOfYear'

dayjs.locale('fr')
dayjs.extend(weekOfYear)

const weekNumber = dayjs().week()
const fullDate = dayjs().format('dddd DD MMMM YYYY')
</script>

<template>
  <div class="page-header d-print-none">
    <div class="container-xl">
      <div class="row g-2 align-items-center">
        <div class="col">
          <div class="page-pretitle">Semaine {{ weekNumber }}</div>
          <h2 class="page-title">{{ fullDate }}</h2>
        </div>
        <div class="col-auto ms-auto d-print-none">
          <a
            href="https://github.com/Fl0wyn/MonIT/releases/download/vTEMPLATE_VERSION/MonIT.zip"
            class="btn-outline-success btn position-relative"
          >
            Mise à jour disponible
            <span class="badge bg-success badge-notification badge-blink"></span>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>
