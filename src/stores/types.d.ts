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
        hostname: string
        os: string
        memory: string
        cpu: string
        manufacturer: string
        serialnumber: string
        lastreboot: string
      }
      reliability: {
        SourceName: string
        Message: string
        TimeGenerated: string
      }
      speedtest: object
    }

export default dataType
