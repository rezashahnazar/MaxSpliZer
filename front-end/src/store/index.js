import { createStore } from 'vuex'
import axios from 'axios'


export default createStore({
  state: {
    st : 1,
    vcode : '',
    resdata : ''
  },
  mutations: {
    reload(state){
      state.st = 1
      state.vcode = ''
      state. resdata = ''
    },
    varload(state, resd){
      state.st = 0
      state.resdata = resd
    },
    updateVcode(value){
      state.vcode = value
    }
  },
  actions: {
    lookvar({commit}) {
      axios.get("http://localhost:3000/",{
        params : {
          variant : this.state.vcode
        }
      })
      .then(response => response.data)
      .then(results => {
        commit('varload', results)
      })
      .catch((error) => {
        console.log(error)
      })
    },
    
  },
  modules: {
  }
})
