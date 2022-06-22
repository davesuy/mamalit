window.Vue   = require('vue');
import VModal from 'vue-js-modal';
Vue.use(VModal);

let app = new Vue({
  el: "#depotise-app",
  delimiters: ['${', '}'],
  methods: {
    showImages(id) {
      this.$modal.show(id);
    }
  }
});

