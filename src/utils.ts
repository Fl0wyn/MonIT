import dayjs from 'dayjs'
import 'dayjs/locale/fr'
dayjs.locale('fr')

const convertSize = (size: number) => {
  const units = ['o', 'Ko', 'Mo', 'Go', 'To']
  const unitIndex = Math.floor(Math.log(size) / Math.log(1024))
  return `${parseFloat((size / Math.pow(1024, unitIndex)).toFixed(1))} ${units[unitIndex]}`
}

const convertBandwidth = (bandwidth: number) => {
  return `${parseFloat((bandwidth / 125000).toFixed(1))} Mbps`
}

const formatDate = (date: string) => {
  const d = date.split('.')[0]
  return dayjs(d).format('dddd DD MMMM YYYY à hh:00')
}

export { convertSize, convertBandwidth, formatDate }
