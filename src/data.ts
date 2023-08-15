import type {
  diskType,
  omDiskStatusType,
  omRaidStatusType,
  omChassisStatusType,
  wsbType,
  veeamType,
  infoType,
  reliabilityType,
  speedtestType
} from '@/types'

const getData = async () => {
  let data = null
  if (import.meta.env.MODE === 'dev') {
    data = await import('@/test.json')
  } else {
    data = 'TEMPLATE_DATA' as any
  }
  return data
}

const data = await getData()

export const disk = data.disk as diskType[]
export const info = data.info as infoType
export const omDiskStatus = data.omDiskStatus as omDiskStatusType[] | null
export const omRaidStatus = data.omRaidStatus as omRaidStatusType[] | null
export const omChassisStatus = data.omChassisStatus as omChassisStatusType[] | null
export const speedtest = data.speedtest as speedtestType | null
export const wsb = data.wsb as wsbType | null
export const veeam = data.veeam as veeamType | null
export const reliability = data.reliability as reliabilityType[] | null
export const date: string = data.date
