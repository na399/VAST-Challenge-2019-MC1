export const state = () => ({
  SelectCategory: 'shake_intensity',
  SelectLocation: 4,
  TimelineControl: 'play',
  Colour: 'VSUP',
  ShowCategory: 'Single',
  FillMap: 'True',
  ShowName: 'False',
  ShowFacilities: 'False',
  ShowRawReports: 'True',
  SortOption: 'hdi95\\.lower'
})

export const mutations = {
  changeSignal(state, payload) {
    state[payload.key] = payload.val
  }
}
