import { createStore } from 'vuex'
import axios from 'axios'


export default createStore({
  state: {
    st : 1,
    vcode : '',
    resdata : '',
    errormsg : 0
  },
  mutations: {
    reload(state){
      state.st = 1
      state.vcode = ''
      state.resdata = ''
      state.errormsg = 0
    },
    varload(state, resd){
      
      state.resdata = resd
    },
    updateVcode(value){
      state.vcode = value
    }
  },
  actions: {
    lookvar({commit}) {
      this.state.st = 0
      axios.get("http://45.79.145.22/maxent",{
        params : {
          variant : this.state.vcode
        }
      })
      .then(response => response.data)
      .then(results => {
        commit('varload', results)
        this.state.errormsg = 0
      })
      .catch((error) => {
        console.log(error)
        this.state.errormsg = 1
      })
    },
    
  },
  modules: {
  }
})
