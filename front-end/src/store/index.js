import { createStore } from 'vuex'
import axios from 'axios'


export default createStore({
  state: {
    st : 1,
    vcode : '',
    resdata : '',
    errormsg : 0,
    gene : 'LDLR',
    genecode :'NG_009060.1(LDLR)'
  },
  mutations: {
    reload(state){
      state.st = 1
      state.vcode = ''
      state.resdata = ''
      state.errormsg = 0
      state.gene = 'LDLR'
      state.genecode = 'NG_009060.1(LDLR)'
    },
    varload(state, resd){
      state.resdata = resd
    }

  },
  actions: {
    lookvar({commit}) {
      this.state.st = 0
      axios.get("https://maxsplizer.com/maxent",{
        params : {
          variant : this.state.vcode ,
          gene : this.state.gene 
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
