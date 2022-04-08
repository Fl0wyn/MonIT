<template>
  <div id="app" v-if="!errored">
    <div class="page">
      <Navbar />
      <VueHtml2pdf
        :show-layout="true"
        :float-layout="false"
        :enable-download="true"
        :preview-modal="false"
        :filename="
          'MonIT' + '_' + new Date().toLocaleDateString().replaceAll('/', '-')
        "
        :pdf-quality="2"
        :manual-pagination="true"
        pdf-format="a4"
        pdf-orientation="portrait"
        ref="html2Pdf"
        pdf-content-width="100%"
      >
        <section slot="pdf-content">
          <div class="page-wrapper">
            <Header />
            <div class="page-body">
              <div class="container-xl">
                <div class="row row-deck row-cards">
                  <Disk size="col-sm-12" title="Liste des disques" :msg="msg" />

                  <OmDiskStatus
                    size="col-sm-12 col-lg-6"
                    title="Santé des disques"
                    :msg="msg"
                    :isomDiskStatus="isomDiskStatus"
                  />

                  <OmChassisStatus
                    size="col-sm-12 col-lg-6"
                    title="Santé du matériel"
                    :msg="msg"
                    :isomChassisStatus="isomChassisStatus"
                  />

                  <OmRaidStatus
                    size="col-sm-12 col-lg-6"
                    title="Santé des RAID"
                    :msg="msg"
                    :isomRaidStatus="isomRaidStatus"
                  />

                  <!-- Backup-->
                  <div class="col-sm-12 col-lg-6">
                    <div class="card">
                      <div class="card-header">
                        <svg
                          class="icon-title"
                          xmlns="http://www.w3.org/2000/svg"
                          viewBox="0 0 448 512"
                        >
                          <path
                            d="M433.1 129.1l-83.9-83.9C342.3 38.32 327.1 32 316.1 32H64C28.65 32 0 60.65 0 96v320c0 35.35 28.65 64 64 64h320c35.35 0 64-28.65 64-64V163.9C448 152.9 441.7 137.7 433.1 129.1zM224 416c-35.34 0-64-28.66-64-64s28.66-64 64-64s64 28.66 64 64S259.3 416 224 416zM320 208C320 216.8 312.8 224 304 224h-224C71.16 224 64 216.8 64 208v-96C64 103.2 71.16 96 80 96h224C312.8 96 320 103.2 320 112V208z"
                          />
                        </svg>
                        <span class="card-title mx-2">Sauvegardes</span>
                      </div>
                      <div
                        class="list-group list-group-flush list-group-hoverable"
                      >
                        <Backup
                          title="WSB - Sauvegarde réussie"
                          :time="wsbLastTime"
                          :msg="wsbNbVersion + ' sauvegardes disponibles'"
                          :isBackupWSB="isBackupWSB"
                        />
                        <Backup
                          title="Veeam Agent - Sauvegarde effectuée"
                          :time="veeamTime"
                          :msg="veeamMsg"
                          :isBackupVeeam="isBackupVeeam"
                        />
                      </div>
                    </div>
                  </div>

                  <span class="m-0 html2pdf__page-break"></span>

                  <Information
                    size="col-sm-12 col-lg-6"
                    title="Information"
                    :msg="msg"
                  />

                  <!-- Network-->
                  <div class="col-sm-12 col-lg-6">
                    <div class="card">
                      <div class="card-header">
                        <svg
                          class="icon-title"
                          xmlns="http://www.w3.org/2000/svg"
                          viewBox="0 0 640 512"
                        >
                          <path
                            d="M400 0C426.5 0 448 21.49 448 48V144C448 170.5 426.5 192 400 192H352V224H608C625.7 224 640 238.3 640 256C640 273.7 625.7 288 608 288H512V320H560C586.5 320 608 341.5 608 368V464C608 490.5 586.5 512 560 512H400C373.5 512 352 490.5 352 464V368C352 341.5 373.5 320 400 320H448V288H192V320H240C266.5 320 288 341.5 288 368V464C288 490.5 266.5 512 240 512H80C53.49 512 32 490.5 32 464V368C32 341.5 53.49 320 80 320H128V288H32C14.33 288 0 273.7 0 256C0 238.3 14.33 224 32 224H288V192H240C213.5 192 192 170.5 192 144V48C192 21.49 213.5 0 240 0H400zM256 64V128H384V64H256zM224 448V384H96V448H224zM416 384V448H544V384H416z"
                          />
                        </svg>

                        <span class="card-title mx-2">Réseau</span>
                      </div>
                      <div
                        class="list-group list-group-flush list-group-hoverable"
                        v-if="isSpeedTest != false"
                      >
                        <Network title="Adresse IP privé" :msg="ipLan" />
                        <Network title="Adresse MAC" :msg="mac" />
                        <Network title="Adresse IP public" :msg="ipWan" />
                        <Network title="Fournisseur (FAI)" :msg="isp" />
                        <Network
                          title="Descendant"
                          :msg="convertBandwidth(download)"
                        />
                        <Network
                          title="Ascendant"
                          :msg="convertBandwidth(upload)"
                        />
                        <Network title="Ping" :msg="ping + ' ms'" />
                      </div>
                      <div v-else style="border-bottom: 1px solid #e6e7e9">
                        <p class="text-primary font-weight-bold my-4 mx-4">
                          Données non disponibles
                        </p>
                      </div>
                    </div>
                  </div>

                  <span class="m-0 html2pdf__page-break"></span>

                  <History
                    size="col-sm-12"
                    title="Historique de fiabilité"
                    :msg="msg"
                  />
                </div>
              </div>
            </div>
          </div>
        </section>
      </VueHtml2pdf>
    </div>
  </div>

  <div class="alert alert-danger mx-4 my-4" v-else role="!alert">
    <h4 class="alert-title">Oups, quelque chose s'est mal passé &hellip;</h4>
    <div class="text-muted">{{ errorlog }}</div>
  </div>
</template>

<script>
import OmChassisStatus from "./components/OpenManage/OmChassisStatus";
import OmDiskStatus from "./components/OpenManage/OmDiskStatus";
import OmRaidStatus from "./components/OpenManage/OmRaidStatus";
import Backup from "./components/Backup";
import Disk from "./components/Disk";
import Header from "./components/Header";
import History from "./components/History";
import Information from "./components/Information";
import Navbar from "./components/Navbar";
import Network from "./components/Network";

import axios from "axios";
import { convertBandwidth } from "./convert";

import VueHtml2pdf from "vue-html2pdf";

export default {
  name: "App",
  components: {
    OmChassisStatus,
    OmDiskStatus,
    OmRaidStatus,
    Backup,
    Disk,
    Header,
    History,
    Information,
    Navbar,
    Network,
    VueHtml2pdf,
  },

  data: () => ({
    msg: [],

    isomDiskStatus: false,
    isomRaidStatus: false,
    isomChassisStatus: false,

    isBackupWSB: true,
    isBackupVeeam: true,

    isSpeedTest: true,

    /* Network */
    network: "",
    ipLan: "",
    mac: "",
    ipWan: "",
    isp: "",
    download: "",
    upload: "",
    ping: "",

    /* Backup */
    veeamMsg: "",
    veeamTime: "",
    wsbLastTime: "",
    wsbNbVersion: "",

    errored: false,
    errorlog: "",
  }),

  methods: {
    convertBandwidth,
    /*     aFarAwayEventHandler() {
      this.$refs.html2Pdf.generatePdf();
    }, */
  },

  mounted() {
    //this.$root.$on("a-far-away-event", this.aFarAwayEventHandler),
    axios
      .get("data.json")
      .then((response) => {
        var res = response.data;
        this.msg = res;

        this.$refs.html2Pdf.generatePdf();

        res.omDiskStatus != null
          ? (this.isomDiskStatus = true)
          : (this.isomDiskStatus = false);

        res.omRaidStatus != null
          ? (this.isomRaidStatus = true)
          : (this.isomRaidStatus = false);

        res.omChassisStatus != null
          ? (this.isomChassisStatus = true)
          : (this.isomChassisStatus = false);

        // Network
        if (res.speedtest != null) {
          this.ipLan = res.speedtest.interface.internalIp;
          this.mac = res.speedtest.interface.macAddr;
          this.ipWan = res.speedtest.interface.externalIp;
          this.isp = res.speedtest.isp;
          this.download = res.speedtest.download.bandwidth;
          this.upload = res.speedtest.upload.bandwidth;
          this.ping = Math.round(res.speedtest.ping.latency);
        } else {
          this.isSpeedTest = false;
        }

        // Disk
        if (res.wsb != null) {
          this.wsbLastTime = res.wsb.LastSuccessfulBackupTime;
          this.wsbNbVersion = res.wsb.NumberOfVersions;
        } else {
          this.isBackupWSB = false;
        }
        if (res.veeam != null) {
          this.veeamMsg = res.veeam.Message;
          this.veeamTime = res.veeam.TimeWritten;
        } else {
          this.isBackupVeeam = false;
        }
      })
      .catch((error) => {
        console.log(error);
        this.errored = true;
        this.errorlog = error;
      });
  },
};
</script>