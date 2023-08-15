export type diskType = {
  DeviceID: string
  VolumeName: string
  FreeSpace: number
  Size: number
}

export type omDiskStatusType = {
  name: string
  status: string
  state: string
  failure: string
  capacity: string
}

export type omRaidStatusType = {
  name: string
  layout: string
  status: string
  state: string
  media: string
}

export type omChassisStatusType = {
  component: string
  severity: string
}

export type wsbType = {
  LastSuccessfulBackupTime: string
  NumberOfVersions: string
}

export type veeamType = {
  Message: string
  TimeWritten: string
}

export type infoType = {
  hostname: string
  os: string
  memory: number
  cpu: string
  manufacturer: string
  serialnumber: string
  lastreboot: string
}

export type reliabilityType = {
  SourceName: string
  Message: string
  TimeGenerated: string
}

export type speedtestType = {
  download: number
  upload: number
  ping: number
  internalIp: string
  externalIp: string
}
