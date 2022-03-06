<template>
  <div :class="size">
    <div class="card">
      <div class="card-header">
        <svg
          class="icon-title"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
        >
          <path
            d="M256 0C114.6 0 0 114.6 0 256s114.6 256 256 256s256-114.6 256-256S397.4 0 256 0zM256 128c17.67 0 32 14.33 32 32c0 17.67-14.33 32-32 32S224 177.7 224 160C224 142.3 238.3 128 256 128zM296 384h-80C202.8 384 192 373.3 192 360s10.75-24 24-24h16v-64H224c-13.25 0-24-10.75-24-24S210.8 224 224 224h32c13.25 0 24 10.75 24 24v88h16c13.25 0 24 10.75 24 24S309.3 384 296 384z"
          /></svg
        ><span class="card-title mx-2">{{ title }}</span>
      </div>
      <div class="list-group list-group-flush list-group-hoverable">
        <div
          class="list-group-item"
          v-for="(item, index) in msg.info"
          :key="index"
        >
          <div class="row align-items-center">
            <div class="col-auto"><span class="badge bg-primary"></span></div>
            <div class="col text-truncate">
              <small class="d-block text-muted text-truncate mt-n1">{{
                item.name
              }}</small
              ><span v-if="item.name.includes('Mémoire')">{{
                convertByte(item.val)
              }}</span
              ><span
                class="text-capitalize"
                v-else-if="item.name.includes('redémarrage')"
                >{{ item.val }}</span
              ><span v-else>{{ item.val }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { convertByte } from "../convert";

export default {
  name: "Information",
  props: ["size", "title", "msg"],
  methods: {
    convertByte,
  },
};
</script>
