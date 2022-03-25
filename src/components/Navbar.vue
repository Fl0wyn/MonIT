<template>
  <div class="sticky-top">
    <!--     <header
      class="navbar navbar-expand-md navbar-light sticky-top d-print-none"
    > -->
    <header class="navbar navbar-expand-md navbar-light d-print-none">
      <div class="container-xl">
        <h1
          class="
            navbar-brand navbar-brand-autodark
            d-none-navbar-horizontal
            pe-0 pe-md-3
          "
        >
          <img
            class="navbar-brand-image me-2"
            src="../assets/logo.svg"
            alt="Tabler"
          />
          MonIT
        </h1>
        <!--         <ul class="navbar-nav">
          <li v-for="(next, i) in list" :key="i" class="nav-item">
            :class="['nav-item', { active: i === activeItem }]"
            @click="selectItem(i)"

            <a class="nav-link" :href="'#' + next.link">
              <span class="nav-link-title">{{ next.title }}</span>
            </a>
          </li>
        </ul> -->
      </div>
    </header>
  </div>
</template>

<script>
export default {
  name: "Navbar",
  /*   methods: {
    selectItem(i) {
      this.activeItem = i;
    },
  }, */

  /*   data: () => ({
    activeItem: null,

    list: [
      {
        title: "Disques & matériels",
        link: "",
      },
      {
        title: "Raid et sauvegardes",
        link: "raidBackup",
      },
      {
        title: "Information et réseau",
        link: "informationNetwork",
      },
      {
        title: "Historique",
        link: "history",
      },
    ],
  }), */
};
</script>