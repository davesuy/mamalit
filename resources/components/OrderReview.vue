<template>
  <div class="tt-shopcart-col">
    <div class="vld-parent">
      <h3 class="tt-title">Order Review</h3>
      <loading :active.sync="loading" :is-full-page="false"
      ></loading>
      <div v-if="carts !== null && loading === false">
        <div class="order-review tt-shopcart-box mt-8 vld-parent" v-for="cart in carts.orders">
          <loading :active.sync="cart.updating" :is-full-page="false"
          ></loading>
          <div v-if="cart.paymentResult !== null">
            <div v-if="cart.paymentResult === true">
              <h4 class="tt-title">Payment Successful</h4>
            </div>
            <div v-if="cart.paymentResult === false">
              <h4 class="tt-title">Payment error</h4>
            </div>
          </div>
          <div v-else>
            <h4 class="tt-title mt-0">{{ cart.site.name }}</h4>
            <a v-if="carts.user" href="/checkout/addresses">Edit</a>
            <p>
              <strong class="font-weight-bold">Shipping method:</strong>
              <template
                v-if="cart.order.availableShippingMethodOptions">
                <span
                  v-if="getSelectedShippingMethod(cart.order)">{{ getSelectedShippingMethod(cart.order).name }}</span>
                <span v-else>No shipping method selected.</span>
              </template>
            </p>

            <h4 class="tt-title">Items</h4>
            <ul class="tt-list-parameters list-group list-unstyled">
              <li class="mb-2" v-for="(lineItem, index) in cart.order.lineItems">

                <div class="text-left">
                  <span>{{ lineItem.description }} x {{ lineItem.qty }}</span>
                </div>
                <div class="text-right item-sale">
                  <div v-if="lineItem.onSale">
                    <strong>{{ lineItem.priceAsCurrency }}</strong>
                    <br>
                    <strong class="font-weight-bold">Sale Off:</strong> <span>{{ lineItem.saleAmountAsCurrency }}</span>
                    <br>
                    <strong class="font-weight-bold">Sale Price</strong> <span>{{ lineItem.salePriceAsCurrency }}</span>
                    <br>
                    <strong class="font-weight-bold">Sale Price Subtotal:</strong> {{ lineItem.subtotalAsCurrency }}
                  </div>
                  <div v-else>
                    <strong class="font-weight-bold">Price:</strong> <span>{{ lineItem.priceAsCurrency }}</span>
                    <br/>
                    <strong class="font-weight-bold">Price Subtotal:</strong> <span>{{ lineItem.subtotalAsCurrency }}</span>
                  </div>
                  <div v-if=" lineItem.saleAmount > 0 && lineItem.snapshot.sales">
                    <strong class="font-weight-bold" v-if="index === 0">Sales Applied:</strong>
                    <span v-for="sale in lineItem.snapshot.sales">
                  {{ sale.name }}
                </span>
                  </div>
                </div>
                <!--            <div v-for="adjustment in lineItem.adjustments" class="adjustment">-->
                <!--              <div v-if="adjustment.amount > 0">-->
                <!--                <strong>{{ adjustment.type }} : {{ adjustment.name }} <small>{{ adjustment.description }}</small></strong>-->
                <!--&lt;!&ndash;                <div v-if="adjustment.isEstimated">&ndash;&gt;-->
                <!--                  <i class="text-sm text-grey-dark">Estimated</i> <span class="text-right float-right">{{ adjustment.amountAsCurrency }}</span>-->
                <!--&lt;!&ndash;                </div>&ndash;&gt;-->
                <!--              </div>-->
                <!--            </div>-->
              </li>
<!--              <li v-for="adjustment in cart.order.orderAdjustments">-->
<!--                <strong class="font-weight-bold">{{ adjustment.name }}</strong> <span-->
<!--                class="float-right">{{ adjustment.amountAsCurrency }}-->
<!--                <template v-if="adjustment.description.trim() !== ''">({{ adjustment.description }})</template></span>-->
<!--              </li>-->
              <li>
                <strong class="font-weight-bold" :class="{'strike-text': carts.isFirstOrder}">Service and Delivery:</strong> <span :class="{'strike-text': carts.isFirstOrder}" class="float-right">{{ cart.order.totalShippingCostAsCurrency }}</span>
                <small v-if="carts.isFirstOrder">Free Delivery</small>
              </li>
              <li>
                <strong class="font-weight-bold">Total:</strong> <span class="float-right">{{ cart.order.totalPriceAsCurrency }}</span>
              </li>
            </ul>
          </div>
        </div>
        <div class="tt-shopcart-box tt-boredr-large">
          <table class="tt-shopcart-table01">
            <tfoot>
            <tr>
              <th class="p-0"><small>Sub Total:</small></th>
              <td class="p-0"><small>{{ overAllTotal('subTotal') }}</small></td>
            </tr>
            <tr>
              <th class="p-0"><small :class="{'strike-text': carts.isFirstOrder}">Service and Delivery Fee Total:</small></th>
              <td class="p-0"><small :class="{'strike-text': carts.isFirstOrder}">{{ overAllTotal('deliveryTotal') }}</small> <small v-if="carts.isFirstOrder">Free Delivery</small></td>
            </tr>
            <tr v-if="overAllTotal('totalDiscount') !== 0">
              <th class="p-0"><small>Discount:</small></th>
              <td class="p-0"><small>{{ carts.currency }} {{ overAllTotal('totalDiscount') }}</small></td>
            </tr>
            <tr>
              <th :class="{'strike-text': carts.isFirstOrder}">Overall Total:</th>
              <td :class="{'strike-text': carts.isFirstOrder}">{{ overAllTotal() }}</td>
            </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Loading from 'vue-loading-overlay';
  import ShippingAddress from '../components/ShippingAddress';

  export default {
    name: "OrderReview",
    components: {
      Loading,
      ShippingAddress
    },
    props: ['multiple-cart'],
    data() {
      return {
        loading: false,
        carts: {}
      }
    },
    methods: {
      getSelectedShippingMethod(order) {
        return order.availableShippingMethodOptions[order.shippingMethodHandle] ?? null;
      },
      overAllTotal(key = 'total') {
        if (this.carts.orders !== undefined && this.carts.orders.length > 0) {
          let total = 0;
          let subTotal = 0;
          let totalDiscount = 0;
          let deliveryTotal = 0;
          for (let cart of this.carts.orders) {
            total = total + cart.order.totalPrice;
            subTotal = subTotal + cart.order.itemSubtotal;
            totalDiscount = totalDiscount + cart.order.totalDiscount;
            deliveryTotal = deliveryTotal + cart.order.totalShippingCost;
          }

          let cost = {
            total: this.carts.currency + total.toLocaleString('en-US'),
            subTotal: this.carts.currency + subTotal.toLocaleString('en-US'),
            totalDiscount: totalDiscount,
            deliveryTotal: this.carts.currency + deliveryTotal.toLocaleString('en-US')
          };

          return cost[key];
        }
      }
    },
    mounted() {
      if (this.multipleCart == null) {
        this.loading = true;
        let csrf = {};
        csrf[csrfTokenName] = csrfTokenValue;

        axios.post(multipleCartAction, csrf)
          .then((response) => {
            this.carts = response.data;
            this.loading = false;
          });
      } else {
        this.carts = this.multipleCart
      }
    },
    computed: {}
  }
</script>

<style scoped>
  .vld-parent {
    min-height: 200px;
  }
</style>
