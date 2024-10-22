export const state = () => ({
  SelectCategory: 'shake_intensity',
  SelectLocation: 1,
  TimelineControl: 'Play',
  Colour: 'VSUP',
  ShowCategory: 'Single',
  HighlightSelectedLoc: false,
  FillMap: true,
  ShowName: false,
  ShowFacilities: false,
  ShowRawReports: true,
  SortOption: 'hdi95\\.lower'
})

export const mutations = {
  changeSignal(state, payload) {
    state[payload.key] = payload.val
  }
}
