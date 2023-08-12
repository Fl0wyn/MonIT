type dataType =
  | 'TEMPLATE_DATA'
  | {
      disk: [
        {
          DeviceID: string
          VolumeName: string
          FreeSpace: number
          Size: number
        }
      ]
      omDiskStatus: [
        {
          name: string
          status: string
          state: string
          failure: string
          capacity: string
        }
      ]
      omRaidStatus: [
        {
          name: string
          layout: string
          status: string
          state: string
          media: string
        }
      ]
      omChassisStatus: [
        {
          component: string
          severity: string
        }
      ]
      wsb: {
        LastSuccessfulBackupTime: string
        NumberOfVersions: string
      }
      veeam: {
        Message: string
        TimeWritten: string
      }
      info: {
        hostname: { name: string; val: string }
        os: { name: string; val: string }
        memory: { name: string; val: string }
        procesor: { name: string; val: string }
        manufacturer: { name: string; val: string }
        serialnumber: { name: string; val: string }
        lastreboot: { name: string; val: string }
      }
      reliability: {
        SourceName: string
        Message: string
        TimeGenerated: string
      }
      speedtest: object
    }

export default dataType
