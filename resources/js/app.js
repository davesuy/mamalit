window.axios = require('axios');
window.Vue   = require('vue');
window.qs    = require('qs');

import Paginate from 'vuejs-paginate'
import Cart from '../components/Cart';
import ShoppingCart from '../components/ShoppingCart';
import MultipleCart from '../components/MultipleCart';
import MultiplePayment from '../components/MultiplePayment';
import ProductVariant from '../components/ProductVariant';
import Shipping from '../components/Shipping';
import OrderReview from '../components/OrderReview';
import Payment from '../components/Payment';
import Loading from 'vue-loading-overlay';
import LineItemCount from '../components/LineItemCount';
import AddressForm from '../components/AddressForm';
import 'vue-loading-overlay/dist/vue-loading.css';
import { ModalPlugin, IconsPlugin, SpinnerPlugin } from 'bootstrap-vue'
import Vuelidate from 'vuelidate'
import { required, minLength, maxLength, numeric, minValue } from 'vuelidate/lib/validators'
import VueAutosuggest from "vue-autosuggest";
import AutoSuggest from '../components/AutoSuggest';
import InfiniteLoading from 'vue-infinite-loading';
import Time from '../mixins/Time';
import MultipleCartMixin from '../mixins/MultipleCart';
import FixedHeader from 'vue-fixed-header'
import VueCarousel from 'vue-carousel';

Vue.component('fixed-header', FixedHeader);
Vue.use(InfiniteLoading, { /* options */ });
Vue.component('infinite-loading', InfiniteLoading)

Vue.use(VueAutosuggest);
Vue.use(Vuelidate);

Vue.use(require('vue-moment'));
Vue.component('paginate', Paginate);
Vue.component('cart', Cart);
Vue.component('shopping-cart', ShoppingCart);
Vue.component('payment', Payment);
Vue.component('multiple-cart', MultipleCart);
Vue.component('multiple-payment', MultiplePayment);
Vue.component('product-variant', ProductVariant);
Vue.component('shipping', Shipping);
Vue.component('order-review', OrderReview);
Vue.component('loading', Loading);
Vue.component('line-item-count', LineItemCount);
Vue.component('address-form', AddressForm);
Vue.component('auto-suggest', AutoSuggest);

// Install BootstrapVue
Vue.use(ModalPlugin);
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin);
Vue.use(SpinnerPlugin);
Vue.use(VueCarousel);
if (document.getElementById('app')) {
  new Vue({
    el: "#app",
    delimiters: ['${', '}'],
    mixins: [Time, MultipleCartMixin],
    data: {
      suggest: null,
      rememberMe: null
    },
    methods: {
      searchTitle(value) {

        let seg = this.suggest;
        if (typeof value === 'string') {
          seg = value;
        }

        window.location.href = '/products/?fields[title]=' + seg;
      },
      onSuggest(value) {
        this.suggest = value;
      }
    }
  });
}
if (document.getElementById('address-app')) {
  new Vue({
    el: "#address-app",
    delimiters: ['${', '}'],
    mixins: [Time, MultipleCartMixin],
    data: {
      phone: '',
      alternativePhone: '',
      firstName: '',
      address1: '',
      address3: '',
      stopSubmit: false,
      zipCode: null
    },
    validations: {
      phone: {
        required,
        minLength: minLength(10),
        maxLength: maxLength(11),
        numeric
      },
      alternativePhone: {
        minLength: minLength(10),
        maxLength: maxLength(11),
        numeric
      },
      address1: {
        required,
        minLength: minLength(3)
      },
      address3: {
        required,
        minLength: minLength(3)
      },
      firstName: {
        required,
        minLength: minLength(3)
      },
      zipCode: {
        required
      }
    },
    methods: {
      submitAddress(e) {
        if (this.stopSubmit === true) {
          e.preventDefault();

          this.$v.$touch()
          if (this.$v.$invalid) {

          } else {
            this.$refs.addressForm.submit();
          }
        } else {
          if (this.$refs.userAddresses === undefined) {
            this.$v.$touch();
          }

          if (this.$refs.userAddresses === undefined && this.$v.$invalid) {

          } else {
            let form = document.forms.addressForm;
            let formData = new FormData(form);

            let shippingAddressId = formData.get('shippingAddressId');

            if (shippingAddressId !== null) {
              this.$refs.addressForm.submit();
            } else {
              this.$bvModal.show('choose-shipping');
              let self = this;
              setTimeout(function() {
                self.$bvModal.hide('choose-shipping');
              }, 2000)
            }
          }
        }
      },
      setSubmit(bool) {
        this.stopSubmit = bool
      }
    },
    mounted() {

    }
  });
}


if (document.getElementById('search-app')) {
  let app = new Vue({
    el: "#search-app",
    delimiters: ['${', '}'],
    mixins: [Time, MultipleCartMixin],
    data: {
      handle: superFilterHandle,
      items: [],
      links: {
        totalPages: 1
      },
      config: {
        params: {
          sort: null,
          fields: [],
          siteId: null
        }
      },
      itemAttributes: superFilterItemAttributes,
      currentPage: 1,
      loading: true,
      loadingFields: true,
      infiniteId: +new Date(),
      firstLoad: true,
      query: '',
      categories: [],
      selectedProduct: {},
      location: null,
      suggest: null,
      bundleSuggest: null,
      filterToggle: false
    },
    methods: {
      onFilterToggle() {
        if (this.filterToggle === true) {
          this.filterToggle = false;
        }
      },
      submitFilter() {
        this.config.params.fields.title = this.suggest;
        this.reload();
      },
      clearFilter() {

        let fields = this.config.params.fields;
        for (let key in fields) {
          if (Array.isArray(fields[key])) {
            this.config.params.fields[key] = [];
          } else {
            this.config.params.fields[key] = "";
          }
        }
        this.suggest = '';
        let parse = JSON.parse(superFilterParams);

        if (parse.preFilter !== undefined) {
          this.config.params.fields = {...this.config.params.fields, ...parse.preFilter};
        }

        this.reload();
      },
      submitSort() {
        this.reload();
      },
      pushState() {
        let queryString = (this.query !== '') ? window.location.pathname + '?' + this.query : window.location.pathname;

        window.history.pushState("/", "", queryString);
      },
      reload() {
        this.currentPage = 1;
        this.config.currentPage = this.currentPage;
        this.items = [];
        this.infiniteId += 1;

        window.scrollTo(0, 0);
      },
      infiniteHandler($state) {

        this.config.currentPage = this.currentPage;

        if (this.firstLoad === true) {
          this.initialLoad($state);
          this.loadCategories();
          this.firstLoad = false;
        } else {
          this.filterItems($state);
        }
      },
      filterItems($state) {

        let data = {
          handle: this.handle,
          config: this.config,
          itemAttributes: this.itemAttributes
        };

        data[csrfTokenName] = csrfTokenValue;
        this.loading = true;
        axios.post('/super-filter/filter', qs.stringify(data))
          .then(({data}) => {
            if (data.items.length) {
              this.currentPage++;
              this.items.push(...data.items);

              $state.loaded();
            } else {
              $state.complete();
            }
            this.query = data.query;

            this.pushState();
            this.loading = false;
          });
      },
      addAllToCart() {

        for (let item of this.items) {
          let data = {
            qty: item.qty,
            purchasableId: item.defaultVariantId,
            siteId: item.siteId
          };

          data[csrfTokenName] = csrfTokenValue;

          this.submit = true;
          this.error = false;

          axios.post(updateCartAction, data)
            .then((response) => {
              this.submit = false;

              if (response.data.success === false) {
                this.error = true;

                for (let error in response.data.errors) {
                  let message = response.data.errors[error];
                  this.errorMessage = message[0];
                }
              }

              this.$emit('cart-added', data);
            }).catch((error) => {
            this.error = true;
            this.submit = false;

          });
        }
        window.location.href = '/cart';
      },
      initialLoad($state) {
        let parse = JSON.parse(superFilterParams);

        let data = {
          handle: this.handle,
          config: {
            params: {
              sort: null,
              fields: [],
              siteId: "*"
            }
          },
          itemAttributes: this.itemAttributes
        };

        data.config.params.fields = parse.fields;

        if (parse.sort !== undefined) {
          data.config.params.sort = parse.sort;
        }

        if (parse.siteId !== undefined) {
          data.config.params.siteId = parse.siteId;
        }
        this.loading = true;
        data[csrfTokenName] = csrfTokenValue;
        axios.post('/super-filter/fields', qs.stringify(data))
          .then(({data}) => {
            this.config = data.config;
            this.config.params.fields = {...data.config.params.fields, ...parse.fields};

            this.config.params.sort = data.config.params.sort;

            if (data.items.length) {
              this.currentPage++;
              this.items.push(...data.items);

              $state.loaded();
            } else {
              $state.complete();
            }
            this.query = data.query;

            //this.pushState();
            this.loading = false;
          });
      },
      loadCategories() {
        let data = {};
        data[csrfTokenName] = csrfTokenValue;
        data['categorySlug'] = categorySlug;

        axios.post(actionUrl, data).then((response) => {
          this.categories = response.data;
          this.loadingFields = false;
        });
      },
      showProduct(product) {
        this.location = window.location.href;
        window.history.pushState("/", "", "#show");
        this.selectedProduct = product;

        this.$bvModal.show('variant-modal');
      },
      hideModal() {
        window.history.pushState({}, null, this.location);
      },
      onSuggest(value) {
        this.config.params.fields.title = value;

        this.reload();
      },
      onSuggestChange(value) {
        this.config.params.fields.title = value;
      },
      cartAdded() {
        let date = new Date();
        this.time = date.getTime();

        this.loadMultipleCart();
      },
      searchTitle(value) {

        let seg = this.suggest;
        if (typeof value === 'string') {
          seg = value;
        }

        window.location.href = '/products/?fields[title]=' + seg;
      },
      searchBundleTitle(value)
      {
        let seg = this.bundleSuggest;
        if (typeof value === 'string') {
          seg = value;
        }

        window.location.href = '/products/?fields[title]=' + seg;
      }
    },
    created() {

      let urlParams = new URLSearchParams(window.location.search);
      let fieldParams = urlParams.get('fields[title]');
      if (fieldParams !== null) {
        this.suggest = fieldParams;
      }
    },
    watch: {
      "config.params.fields.productCategories": {
        handler: function (value) {
          this.reload();
          this.filterToggle = false;
        },
        deep: true
      }
    },
    computed: {
      getSelectedCategoryName() {
        let category = this.categories.find((cat) => {
          let catId = parseInt(cat.id);
          return catId === parseInt(this.config.params.fields.productCategories);
        });

        return category !== undefined ? category.title : '';
      }
    }
  });

  window.onpopstate = function (event) {
    app.$bvModal.hide('variant-modal');
  };
}
