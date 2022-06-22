<template>
  <div>
    <loading :active.sync="loading">
      <h3 class="inline-block" slot="before">Loading Delivery...</h3>
    </loading>

    <div v-if="loading === false" class="row">
      <loading :active="continueTo === false">
        <h3 class="inline-block" slot="before">Calculating Delivery...</h3>
      </loading>
      <div class="col-sm-12 col-md-8">
        <div>
          <h2>Delivery</h2>
<!--          <template v-for="item in carts.shipping">-->
<!--            <div class="shipping-select">-->
<!--              <label class="radio">-->
<!--                <input v-model="carts.shippingMethodHandle" type="radio"-->
<!--                       :value="item.handle"/>-->
<!--                <span class="outer"><span class="inner"></span></span>-->
<!--                <strong>{{ item.name }}</strong>-->
<!--              </label>-->
<!--            </div>-->
<!--          </template>-->
          <div v-for="(cart, index) in carts.orders">
            <div v-if="cart.order.availableShippingMethodOptions !== null && cart.order.lineItems.length > 0">
              <h2>{{ cart.site.name }}
                <template v-if="getSelectedShippingMethod(cart.order) !== null">
                  <small :class="{'strike-text': carts.isFirstOrder}">{{ getSelectedShippingMethod(cart.order).name }}
                    {{ getSelectedShippingMethod(cart.order).priceAsCurrency }}
                  </small> <small v-if="carts.isFirstOrder">Free Delivery</small>
                </template>
                <template v-else>
<!--                  <small>No shipping method selected.</small>-->
                  <small>Calculating...</small>
                </template>
<!--                <a @click="showChange(cart)">Change</a>-->
              </h2>
              <template v-if="cart.hide === false" v-for="item in cart.order.availableShippingMethodOptions">
                <div class="shipping-select">
                  <label>
                    <input @change="chooseShipping(cart, index)" type="radio"
                           v-model="cart.order.shippingMethodHandle" :value="item.handle"/>
                    <strong>{{ item.name }}</strong>

                    <span class="price">{{ item.priceAsCurrency }}</span>
                  </label>
                </div>
              </template>
            </div>
          </div>
          <p>
            <input type="button" class="btn-lg"  :class="{'btn-secondary': !canContinue, 'btn-primary': canContinue}"  onclick="window.location='/checkout/payment';"
                   :disabled="!canContinue" value="Continue to payment"/>
          </p>
        </div>
        <hr />
        <div class="row">
          <div class="col-sm-12">
            <h4>Coupon Code</h4>
          </div>
          <div class="col-sm-6">
            <input type="text" v-model="couponCode" class="form-control" name="coupon" value="" />
            <div class="contact-form" v-if="errors">
              <label class="error" v-for="error in errors"> {{ error[0] }}</label>
            </div>
          </div>
          <div class="col-sm-6">
            <input type="button" class="btn btn-primary" @click="applyCoupon" value="Apply Coupon" />
          </div>
        </div>
      </div>
      <div class="col-sm-12 col-md-4 vld-parent">
        <shipping-address :carts="carts"></shipping-address>
        <order-review :multiple-cart.sync="carts"></order-review>
      </div>
    </div>
  </div>

</template>

<script>
  import Loading from 'vue-loading-overlay';
  import _ from 'lodash';
  import ShippingAddress from '../components/ShippingAddress';

  export default {
    name: "Shipping",
    components: {
      Loading,
      ShippingAddress
    },
    data() {
      return {
        loading: true,
        carts: {
          shippingMethodHandle: null
        },
        currentOrder: {},
        values: [],
        continueTo: false,
        couponCode: null,
        errors: []
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
      chooseShipping: _.debounce(function (cart, index) {
        this.updateShipping(cart, index);
      }, 2000),
      updateShipping: function (cart, index) {
        let data = {};
        data['shippingMethodHandle'] = cart.order.shippingMethodHandle;
        data['siteId'] = cart.site.id;
        data[csrfTokenName] = csrfTokenValue;

        this.carts.orders[index].updating = true;
        axios.post(updateCartAction, data)
          .then((response) => {
            this.carts.orders[index].order = response.data.cart;
            this.carts.orders[index].updating = false;
            this.continueTo = true;
          }).catch((error) => {
          this.carts.orders[index].updating = false;
        });
      },
      applyCoupon: function () {


        if (this.carts.orders.length > 0) {

           for (let [index, cart] of this.carts.orders.entries()) {
             let data = {};
             data['orderNumber'] = cart.order.number;
             data['couponCode'] = this.couponCode;
             data['siteId'] = cart.site.id;
             data[csrfTokenName] = csrfTokenValue;

             this.carts.orders[index].updating = true;
             axios.post(updateCartAction, data)
               .then((response) => {

                 let cart = this.carts.orders.find(obj => obj.order.number === response.data.cart.number);

                 cart.order = response.data.cart;
                 cart.updating = false;

                 if (response.data.errors != null) {
                   this.errors = response.data.errors;
                 } else {
                   this.errors = [];
                 }

                 this.couponCode = response.data.cart.couponCode;
                 this.continueTo = true;
               }).catch((error) => {
               this.carts.orders[index].updating = false;
             });
           }
        }

      },
      getSelectedShippingMethod(order) {
        return order.availableShippingMethodOptions[order.shippingMethodHandle] ?? null;
      },
    },
    mounted() {
      let data = {};
      data[csrfTokenName] = csrfTokenValue;
      data['availableShipping'] = true;

      axios.post(multipleCartActionShipping, data)
        .then((response) => {
          this.carts = response.data;
          if (this.carts.orders.length > 0) {
            for (let [index, cart] of this.carts.orders.entries()) {
              this.couponCode = cart.order.couponCode;
            }
          }
          this.loading = false;
        });
    },
    computed: {
      isUpdating() {
        if (this.carts.orders !== undefined && this.carts.orders.length > 0) {
          for (let [index, cart] of this.carts.orders.entries()) {
            if (cart.updating === true) {
              return true;
            }
          }
        }

        return false;
      },
      canContinue() {
        if (this.isUpdating === false && this.continueTo === true) {
          return true
        }

        return false;
      }
    },
    watch: {
      'carts.shippingMethodHandle': {
        handler: _.debounce(function (value) {
          if (this.carts.orders !== undefined && this.carts.orders.length > 0) {

            for (let [index, cart] of this.carts.orders.entries()) {
              cart.order.shippingMethodHandle = value;

              this.updateShipping(cart, index);
            }
          }
        }, 2000),
        immediate: false
      }
    }
  }
</script>

<style scoped>
  .disabled {
    cursor: not-allowed;
    color: gray
  }
</style>
