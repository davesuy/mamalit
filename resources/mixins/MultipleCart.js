
export default {
  data() {
    return {
      loading: null,
      loadingCart: null,
      multipleOrder: null,
      orders: null,
      currency: null,
      carts: {}
    }
  },
  props: ['multiple-cart'],
  methods: {
    loadMultipleCart() {
      if (this.multipleCart == null) {
        this.loading = true;
        this.loadingCart = true;
        let csrf = {};
        csrf[csrfTokenName] = csrfTokenValue;

        axios.post(multipleCartAction, csrf)
          .then((response) => {
            this.carts = response.data;
            this.loading = false;
            this.loadingCart = false;
            // this.orders        = response.data.orders;
            // this.multipleOrder = response.data.multipleOrder;
            // this.currency      = response.data.currency;

          });
      } else {
        this.carts = this.multipleCart
      }

      if (this.carts.orders) {
        let pathArray = window.location.pathname.split('/');
        if (pathArray[1]) {
          if (pathArray[1] === 'checkout' && this.carts.orders.length === 0) {
            window.location.href = '/products';
          }
        }
      }

    }
  },
  mounted() {
    this.loadMultipleCart();
  }
}
