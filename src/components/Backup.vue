<template>
  <div class="list-group-item" v-if="isBackupWSB || isBackupVeeam">
    <div class="row align-items-center">
      <div class="col-auto">
        <IconSuccess v-if="msg.includes('Success')" />
        <IconWarning v-if="msg.includes('Warning')" />
        <IconDanger v-if="msg.includes('Failed')" />
        <IconSuccess v-if="title.includes('WSB')" />
      </div>
      <div class="col">
        <span class="d-block mt-n1"
          ><small class="text-muted">{{ title }}</small
          ><br /><span class="bg-blue-lt">{{ time }}</span></span
        ><span>{{ msg.replaceAll(".", " ") }}</span>
      </div>
    </div>
  </div>
  <div v-else style="border-bottom: 1px solid #e6e7e9">
    <p class="text-primary font-weight-bold my-4 mx-4">
      {{ title.split(" ")[0] + " - Données non disponibles" }}
    </p>
  </div>
</template>

<script>
import IconSuccess from "./icons/IconSuccess.vue";
import IconDanger from "./icons/IconDanger.vue";
import IconWarning from "./icons/IconWarning.vue";

export default {
  name: "Backup",
  components: {
    IconSuccess,
    IconDanger,
    IconWarning,
  },

  props: ["title", "msg", "time", "isBackupWSB", "isBackupVeeam"],
};
</script>
