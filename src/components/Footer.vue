<template>
  <footer class="footer footer-transparent d-print-none">
    <div class="container">
      <div class="row text-center align-items-center flex-row-reverse">
        <div class="col-12 col-lg-auto mt-3 mt-lg-0">
          <ul class="list-inline list-inline-dots mb-0">
            <li class="list-inline-item">
              MonIT © {{ new Date().getFullYear() }}
            </li>
            <li class="list-inline-item">
              {{ "v" + version }}
            </li>
            <li class="list-inline-item">
              <a
                class="link-secondary"
                href="https://github.com/Fl0wyn/MonIT"
                target="_blank"
                rel="noopener noreferrer"
                >GitHub</a
              >
            </li>
          </ul>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
import axios from "axios";

export default {
  name: "Footer",
  props: ["msg"],

  data: () => ({
    version: "",
  }),

  mounted() {
    axios.get("VERSION").then((response) => {
      this.version = response.data;
    });
  },
};
</script>
