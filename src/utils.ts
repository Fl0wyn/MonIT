const convertSize = (size: number) => {
  const units = ['o', 'Ko', 'Mo', 'Go', 'To']
  const unitIndex = Math.floor(Math.log(size) / Math.log(1024))
  return `${parseFloat((size / Math.pow(1024, unitIndex)).toFixed(1))} ${units[unitIndex]}`
}

const convertBandwidth = (bandwidth: number) => {
  return `${parseFloat((bandwidth / 125000).toFixed(1))} Mbps`
}

export { convertSize, convertBandwidth }
