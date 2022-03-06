<template>
  <div class="list-group-item">
    <div class="row align-items-center">
      <div class="col-auto">
        <span class="badge bg-primary"></span>
      </div>
      <div class="col">
        <small class="d-block text-muted mt-n1">{{ title }}</small>
        <span>{{ msg }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Network",
  props: {
    title: String,
    msg: [Number, String],
  },
};
</script>
