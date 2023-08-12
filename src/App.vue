<script setup lang="ts">
import Navbar from '@/layouts/NavbarLayout.vue'
import Header from '@/layouts/HeaderLayout.vue'
import Footer from '@/layouts/FooterLayout.vue'

import DiskViews from '@/views/DiskViews.vue'
import BackupView from '@/views/BackupView.vue'
import HistoryView from '@/views/HistoryView.vue'
import InformationView from '@/views/InformationView.vue'
import NetworkView from '@/views/NetworkView.vue'
import OmChassisStatusView from '@/views/OmChassisStatusView.vue'
import OmDiskStatusView from '@/views/OmDiskStatusView.vue'
import OmRaidStatusView from '@/views/OmRaidStatusView.vue'
</script>

<template>
  <Navbar />
  <div class="page-wrapper">
    <Header />
    <div class="page-body">
      <div class="container-xl">
        <div class="row row-deck row-cards">
          <Disk-views />
          <Om-disk-status-view />
          <Om-chassis-status-view />
          <Om-raid-status-view />
          <Backup-view />
          <div class="col-md-6">
            <div class="col-12">
              <Network-view />
              <Information-view class="mt-3" />
            </div>
          </div>
          <History-view />
        </div>
      </div>
    </div>
    <Footer />
  </div>
</template>

<style>
emoji-success::after {
  content: '✔️';
  color: transparent;
  text-shadow: 0 0 0 #00d26a;
}
emoji-warning::after {
  content: '⚠️';
}
emoji-danger::after {
  content: '❌';
}

.list-group-item:hover {
  background-color: transparent !important;
}
</style>
