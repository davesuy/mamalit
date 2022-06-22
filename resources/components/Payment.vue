<template>
  <div>
    <loading :active.sync="loading"
    >
    </loading>
    <div v-if="loading === false">
      <div>
        <div v-if="!loading">
          <multiple-payment @make-payment="makePayment" @update-payment-method="updatePaymentMethod"
                            :carts="carts"></multiple-payment>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "Payment",
    data() {
      return {
        loading: true,
        submit: null,
        carts: {}
      }
    },
    methods: {
      updatePaymentMethod(values) {

        let data = {};
        data[csrfTokenName] = csrfTokenValue;

        let objects = {...data, ...values};

        axios.post(updateCartAction, objects)
          .then((response) => {
            let cart = this.carts.orders.find(obj => obj.order.number === response.data.cart.number);

            cart.order = response.data.cart;
          });
      },
      makePayment(orders) {
        this.submit = true;
        for (let [index, order] of orders.entries()) {

          if (order.payments.selected === null) {
            continue;
          }

          let form = order.formValues;
          let data = {};
          data[csrfTokenName] = csrfTokenValue;

          let formData = {...data, ...form};

          order.loading = true;
          axios.post(payAction, formData)
            .then((response) => {
              if (response.data.success === true) {
                order.success = response.data.success;
                //order.orderSuccess = response.data.cart;
                order.order = response.data.cart;
                console.log(order.order)
              } else {
                order.success = false;
                order.errorMessage = response.data.error;
                order.paymentFormErrors = response.data.paymentFormErrors;
              }

              console.log(response.data);

              order.loading = false;
            });
        }

        this.submit = false;
      }
    },
    mounted() {
      let csrf = {};
      csrf[csrfTokenName] = csrfTokenValue;

      axios.post(multipleCartPayment, csrf)
        .then((response) => {
          // this.orders = response.data.orders;
          // this.multipleOrder = response.data.multipleOrder;
          // this.payments = response.data.payments;
          // this.total = response.data.total;
          this.carts = response.data;
          this.loading = false;
        });
    },
    computed: {
    }
  }
</script>

<style scoped>

</style>
