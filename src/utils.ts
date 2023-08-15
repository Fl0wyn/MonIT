import dayjs from 'dayjs'
import 'dayjs/locale/fr'
import weekOfYear from 'dayjs/plugin/weekOfYear'
import advancedFormat from 'dayjs/plugin/advancedFormat'
dayjs.locale('fr')
dayjs.extend(weekOfYear)
dayjs.extend(advancedFormat)

export const convertSize = (size: number | string) => {
  size = typeof size === 'string' ? parseInt(size) : size
  const units = ['o', 'Ko', 'Mo', 'Go', 'To']
  const unitIndex = Math.floor(Math.log(size) / Math.log(1024))
  return `${parseFloat((size / Math.pow(1024, unitIndex)).toFixed(1))} ${units[unitIndex]}`
}

export const convertBandwidth = (bandwidth: number) => {
  return `${parseFloat((bandwidth / 125000).toFixed(1))} Mbps`
}

export const formatDate = (date: string) => {
  const d = date.split('.')[0]
  return dayjs(d).format('dddd DD MMMM YYYY à kk:mm')
}

export const getWeek = (date: string) => dayjs(date).week()
