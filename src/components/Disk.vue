<template>
  <div id="Disk" :class="size">
    <div class="card">
      <div class="card-header">
        <svg
          class="icon-title"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
        >
          <path
            d="M464 288h-416C21.5 288 0 309.5 0 336v96C0 458.5 21.5 480 48 480h416c26.5 0 48-21.5 48-48v-96C512 309.5 490.5 288 464 288zM320 416c-17.62 0-32-14.38-32-32s14.38-32 32-32s32 14.38 32 32S337.6 416 320 416zM416 416c-17.62 0-32-14.38-32-32s14.38-32 32-32s32 14.38 32 32S433.6 416 416 416zM464 32h-416C21.5 32 0 53.5 0 80v192.4C13.41 262.3 29.92 256 48 256h416c18.08 0 34.59 6.254 48 16.41V80C512 53.5 490.5 32 464 32z"
          />
        </svg>
        <span class="card-title mx-2">{{ title }}</span>
      </div>
      <div
        class="
          list-group list-group-flush list-group-horizontal list-group-hoverable
          overflow-auto
        "
        style="max-height: 23rem"
      >
        <div
          class="list-group-item"
          style="border: none !important"
          v-for="(item, index) in msg.disk"
          :key="index"
        >
          <div class="row align-items-center">
            <div class="col" style="width: 14rem">
              {{ item.VolumeName }} ({{ item.DeviceID }})
              <div class="progress my-1" style="height: 15px">
                <div
                  class="progress-bar"
                  v-bind:style="{
                    width:
                      +Math.round(
                        ((item.Size - item.FreeSpace) / item.Size) * 100
                      ) + '%',
                  }"
                  role="progressbar"
                ></div>
              </div>
              {{
                String(convertByte(item.FreeSpace)).length > 6
                  ? convertByte(item.FreeSpace).substr(0, 3) +
                    " " +
                    convertByte(item.FreeSpace).split(" ")[1]
                  : convertByte(item.FreeSpace)
              }}

              libres sur

              {{
                String(convertByte(item.Size)).length > 6
                  ? convertByte(item.Size).substr(0, 3) +
                    " " +
                    convertByte(item.Size).split(" ")[1]
                  : convertByte(item.Size)
              }}
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
  name: "Disk",
  props: ["size", "title", "msg"],
  methods: {
    convertByte,
  },
};
</script>
