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
            d="M480 288H32c-17.62 0-32 14.38-32 32v128c0 17.62 14.38 32 32 32h448c17.62 0 32-14.38 32-32v-128C512 302.4 497.6 288 480 288zM352 408c-13.25 0-24-10.75-24-24s10.75-24 24-24s24 10.75 24 24S365.3 408 352 408zM416 408c-13.25 0-24-10.75-24-24s10.75-24 24-24s24 10.75 24 24S429.3 408 416 408zM480 32H32C14.38 32 0 46.38 0 64v128c0 17.62 14.38 32 32 32h448c17.62 0 32-14.38 32-32V64C512 46.38 497.6 32 480 32zM352 152c-13.25 0-24-10.75-24-24S338.8 104 352 104S376 114.8 376 128S365.3 152 352 152zM416 152c-13.25 0-24-10.75-24-24S402.8 104 416 104S440 114.8 440 128S429.3 152 416 152z"
          /></svg
        ><span class="card-title mx-2">{{ title }}</span>
      </div>
      <div v-if="isomDiskStatus">
        <table class="table card-table table-vcenter">
          <thead>
            <tr>
              <th>ID</th>
              <th>Statut</th>
              <th>Echec</th>
              <th>Etat</th>
              <th>Taille</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in msg.omDiskStatus" :key="index">
              <td>{{ item.name.split(" ")[2] }}</td>
              <!-- Statut-->
              <td>
                <IconSuccess v-if="item.status.includes('Ok')" />
                <IconWarning v-else-if="item.status.includes('Non-Critical')" />
                <IconDanger v-else />
                {{ item.status }}
              </td>
              <!-- Echec-->
              <td>
                <IconSuccess v-if="item.failure.includes('No')" />
                <IconDanger v-else />
                {{ item.failure }}
              </td>
              <!-- Etat-->
              <td>
                <IconSuccess v-if="item.state.includes('Online')" />
                <IconWarning v-else-if="item.state.includes('Non-RAID')" />
                <IconDanger v-else />
                {{ item.state }}
              </td>
              <!-- Taille-->
              <td>
                {{ convertByte(item.capacity.split(" ")[2].replace("(", " ")) }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <div v-else>
        <p class="text-primary font-weight-bold my-4 mx-4">
          Données non disponibles
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import { convertByte } from "../../convert";

import IconSuccess from "../icons/IconSuccess.vue";
import IconDanger from "../icons/IconDanger.vue";
import IconWarning from "../icons/IconWarning.vue";

export default {
  name: "OmDiskStatus",
  components: {
    IconSuccess,
    IconDanger,
    IconWarning,
  },

  props: ["size", "title", "msg", "isomDiskStatus"],
  methods: {
    convertByte,
  },
};
</script>
