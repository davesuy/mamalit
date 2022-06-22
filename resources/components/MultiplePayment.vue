<template>
  <div>
    <h1>Payment</h1>
    <div class="row">
      <div class="col-sm-4">
        <div class="form-group">
        <select class="form-control" @change="updatePayment" v-model="gateways.selected">
          <option :value="payment.value" v-for="payment in gateways.items">{{ payment.label }}</option>
        </select>
        </div>
        <div v-for="payment in gateways.items">
          <form ref="mainForm" id="main-form" v-if="gateways.selected === payment.value">
            <div v-if="selectedPayment !== null && selectedPayment.handle === 'creditOrDebitCard'">
              <div class='form-row'>
                <div class='col-xs-12 form-group required'>
                  <label class='control-label'>Card Number</label>
                  <input v-model="cardDetails.number" autocomplete='off' class='form-control card-number' size='40' type='text'>
                </div>
              </div>
              <div class='form-row'>
                <div class='col-xs-4 form-group expiration required'>
                  <label class='control-label'>Expiration</label>
                  <input v-model="cardDetails.month" class='form-control card-expiry-month' placeholder='MM' size='2' type='text'>
                </div>
                <div class='col-xs-4 form-group expiration required'>
                  <label class='control-label'>&nbsp;</label>
                  <input  v-model="cardDetails.year" class='form-control card-expiry-year' placeholder='YYYY' size='4' type='text'>
                </div>
                <div class='col-xs-4 form-group cvc required'>
                  <label class='control-label'>CVC</label>
                  <input v-model="cardDetails.cvc" autocomplete='off' class='form-control card-cvc' placeholder='ex. 311' size='3' type='text'>
                </div>
              </div>
            </div>
          </form>
        </div>
        <div v-if="paymentButton">
          <p>
            <input type="button" class="btn btn-lg" @click.prevent="submitForm()" value="Make Payment"/>
          </p>
        </div>
      </div>
      <div class="col-sm-8">
        <shipping-address :carts="carts"></shipping-address>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12 vld-parent">
        <order-review v-if="paymentSuccess === null" :multiple-cart.sync="carts"></order-review>


        <loading :active.sync="paymentLoading"
                 :is-full-page="false"
        >
          <h3 class="inline-block" slot="before">Processing Payment...</h3>
        </loading>
        <template v-if="paymentSuccess === true">
          <h4>Payment Successful</h4>

          <h5>Your order is being processed. Please expect a call for confirmation.</h5>
          <h5>Your reference number is <strong class="lead">{{ carts.multipleOrder.id }}</strong></h5>
          <h5>You can view your orders <a class="lead" href="/my-orders">HERE</a></h5>

        </template>
        <h4 v-if="paymentSuccess === false">
          <span v-if="paymentErrorResponse !== null">{{ paymentErrorResponse }}</span>
          <span v-else>Payment Failed. Authentication failed or cancelled.</span>
        </h4>

        <div v-if="paymentButton">
          <p>
            <input type="button" class="btn btn-lg" @click.prevent="submitForm()" value="Make Payment"/>
          </p>
        </div>
      </div>
    </div>
    <!-- The modal -->
    <b-modal id="3ds-modal" size="xl">
      <iframe id="3ds-iframe" :src="iframe" style="overflow:hidden;min-height: 380px; height:100%;width:100%" height="100%"
              width="100%"></iframe>
    </b-modal>

  </div>
</template>

<script>
  import ShippingAddress from '../components/ShippingAddress';

  export default {
    name: "MultiplePayment",
    props: ['carts', 'payments'],
    components: {
      ShippingAddress
    },
    data() {
      return {
        orders: {},
        isLoading: false,
        gateways: {},
        submit: null,
        iframe: null,
        paymentIntentId: null,
        clientKey: null,
        apiKey: null,
        paymentLoading: false,
        paymentSuccess: null,
        paymentResponse: null,
        paymentErrorResponse: null,
        selectedPayment: null,
        cardDetails: {
          number: null,
          month: null,
          year: null,
          cvc: null
        }
      }
    },
    methods: {
      showChange(order) {
        if (order.hide === true) {
          order.hide = false;
        } else {
          order.hide = true;
        }
      },
      updatePayment(cart) {

          for (let cart of this.orders) {
            cart.payments.selected = this.gateways.selected;

            let data = {
              orderNumber: cart.order.number,
              siteId: cart.order.siteId
            };

            if (cart.payments.selected !== null) {
              let selected = cart.payments.selected.split(":");

              this.selectedPayment = cart.payments.items.find(obj => obj.value === cart.payments.selected);

              let type = selected[0];
              data[type] = selected[1];
            }

            this.$emit('update-payment-method', data);
          }
      },
      submitForm() {
        this.paymentLoading = true;
        let formValues = {};


        //let form = document.querySelector('#form' + cart.order.number);
        let form = document.querySelector('#main-form');
        //let obj = serialize(form);
        let obj = this.cardDetails;
        let orders = {};
        for (let [index, order] of this.orders.entries()) {
          //    orders[index]['number'] = order.order.number;
          //  orders[index]['siteId'] = order.site.id;

          orders[index] = {
            number: order.order.number,
            siteId: order.site.id
          };
        }

        let orderData = {
          cancelUrl: cancelUrl,
          redirect: redirectUrl
        };

        formValues = {...orderData, ...obj};

        let paymentFormValues = {};
        paymentFormValues['cardDetails'] = formValues;
        paymentFormValues['orders'] = orders;

        let data = {};
        data[csrfTokenName] = csrfTokenValue;
        data['paymentMethod'] = this.gateways.selected;


        let formData = {...data, ...paymentFormValues};
        if (this.selectedPayment.handle === "creditOrDebitCard") {
          this.submitCardPayment(formData);
        } else {
          this.submitPayment(formData);
        }


        this.submit = 0;

        // this.processPayment();
      },
      submitPayment(formData) {
        let self = this;
        axios.post(paymentAction, formData, {
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }
        }).then((response) => {
          this.paymentLoading = false;

          if (response.data.success === true) {
            this.paymentSuccess = true;
          } else {
            this.paymentSuccess = false;
          }

        }).catch(function (error) {
          // self.paymentLoading = false;
          self.paymentErrorResponse = error.response.data.error;
          self.paymentSuccess = false;
        });
      },
      submitCardPayment(formData) {
        let self = this;
        axios.post(payCardAction, formData, {
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }
        }).then((response) => {
          this.paymentLoading = false;

          if (response.data.data.attributes !== undefined) {
            let attributes = response.data.data.attributes;
            this.clientKey = response.data.paymentIntentClientKey;
            this.paymentIntentId = response.data.paymentIntentId;
            this.apiKey = response.data.apiKey;

            if (attributes.status !== undefined) {
              if (attributes.status === 'awaiting_next_action') {
                this.iframe = attributes.next_action.redirect.url;
                this.$bvModal.show('3ds-modal');
              }

              if (attributes.status === 'succeeded') {
                this.paymentSuccess = true;
              }
            }
          }

          if (response.data.success === true) {
            this.paymentSuccess = true;
          }
        }).catch(function (error) {
          self.paymentLoading = false;
          self.paymentErrorResponse = error.response.data.error;
          self.paymentSuccess = false;
        });
      },
      processPayment() {
        for (let [index, order] of this.orders.entries()) {

          if (order.payments.selected === null) {
            continue;
          }

          let form = {
            orderNumber: order.order.number,
            siteId: order.site.id
          };

          let data = {};
          data[csrfTokenName] = csrfTokenValue;

          let formData = {...data, ...form};
          order.updating = true;

          //order.loading = true;
          axios.post(payAction, formData)
            .then((response) => {
              if (response.data.success === true) {
                order.paymentResult = response.data.success;
                //order.orderSuccess = response.data.cart;
                order.order = response.data.cart;

              } else {
                order.paymentResult = false;
                order.errorMessage = response.data.error;
                order.paymentFormErrors = response.data.paymentFormErrors;
              }

              // console.log(response.data);
              order.updating = false;
              //order.loading = false;
              this.submit++;
            });
        }
      },
      getSelectedPayment(cart) {
        return cart.payments.items.find(obj => obj.value === cart.payments.selected);
      },
      completePayMongo() {
        let data = {};
        data[csrfTokenName] = csrfTokenValue;
        axios.post(payMongoPayment, data)
          .then((response) => {
            if (response.data.success === true) {

            } else {

            }

          });
      },
      overAllTotal() {
        if (this.carts.orders !== undefined && this.carts.orders.length > 0) {
          let total = 0;
          for (let cart of this.carts.orders) {
            total = total + cart.order.totalPrice;
          }

          return this.carts.currency + total;
        }
      }
    },
    created() {
      this.orders = this.carts.orders;
      this.gateways = this.carts.payments;

      let str = 'Client error: `POST https://api.paymongo.com/payment_intents` resulted in a `400 Bad Request` response: {"errors":[{"code":"parameter_below_minimum","detail":"The value for amount cannot be less than 10000.","source":{"point (truncated...)"}';


      let self = this;
      window.addEventListener(
        'message',
        ev => {

          if (ev.data === '3DS-authentication-complete') {
            // 3D Secure authentication is complete. You can requery the payment intent again to check the status.
            axios.get(
              'https://api.paymongo.com/v1/payment_intents/' + self.paymentIntentId + '?client_key=' + self.clientKey,
              {
                headers: {
                  // Base64 encoded public PayMongo API key.
                  Authorization: `Basic ${window.btoa(self.apiKey)}`
                }
              }
            ).then(function (response) {
              self.$bvModal.hide('3ds-modal');
              var paymentIntent = response.data.data;
              var paymentIntentStatus = paymentIntent.attributes.status;

              if (paymentIntentStatus === 'succeeded') {
                self.paymentSuccess = true;

                let data = {};
                data[csrfTokenName] = csrfTokenValue;
                axios.post(payMongoPayment, data)
                  .then((response) => {
                    if (response.data.success === true) {

                    } else {

                    }

                  });
                // You already received your customer's payment. You can show a success message from this condition.
              } else if (paymentIntentStatus === 'awaiting_payment_method') {
                // The PaymentIntent encountered a processing error. You can refer to paymentIntent.attributes.last_payment_error to check the error and render the appropriate error message.
                self.paymentSuccess = false;
              }

            }).catch(function (error) {
              console.log(error.response);

            })
          }
        }, false
      );

    },
    watch: {
      // "gateways.selected": {
      //   handler: function () {
      //     for (let cart of this.orders) {
      //       cart.payments.selected = this.gateways.selected;
      //       this.updatePayment(cart);
      //     }
      //   }
      // }
    },
    computed: {
      paymentButton() {

        if (this.paymentSuccess === true) {
          return false;
        }

        for (let [index, cart] of Object.entries(this.orders)) {
          if (cart.payments.selected !== null) {
            return true;
          }
        }

        return false;
      },
      isUpdating() {
        if (this.orders !== undefined && this.orders.length > 0) {
          for (let [index, cart] of this.orders.entries()) {
            if (cart.loading === true) {
              return true;
            }
          }
        }

        return false;
      },
      overAllTotalPaid() {
        if (this.orders !== undefined && this.orders.length > 0) {
          let total = 0;
          for (let cart of this.orders) {
            total = total + cart.order.totalPaid;
          }

          return this.carts.currency + total;
        }
      }
    }
  }
</script>

<style scoped>

</style>
