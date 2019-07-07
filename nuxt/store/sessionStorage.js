export const state = () => ({
  warningShown: false
})

export const mutations = {
  registerWarningShown(state) {
    state.warningShown = true
  }
}
