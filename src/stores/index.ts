import { defineStore } from 'pinia'

//const DATA_APP: dataType = 'TEMPLATE_DATA'
import DATA_APP from '@/data.json'

import type dataType from '@/stores/types'

export const useAppStore = defineStore('app', {
  state: () => ({
    DATA_APP: DATA_APP as dataType
  })
})
