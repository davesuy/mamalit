<template>
  <div>
    <div v-if="orders.length > 0" v-for="(order, orderIndex) in orders">
      <div class="vld-parent" v-if="order.order.lineItems.length > 0">
        <loading :active.sync="order.loading" :is-full-page="false"
        ></loading>
        <h4 class="mt-3">Store: {{ order.site.name }}</h4>


            <div class="row mb-3 py-3 border" v-for="(lineItem, index) in order.order.lineItems">
              <div class="col-12 col-md-5">
                <div class="row">
                  <div class="col-6 col-md-5">
                    <div class="tt-product-img">
                    <img v-if="lineItem.productImage" :src="lineItem.productImage">
                    </div>
                  </div>
                  <div class="col-6 col-md-7">
                    <h2 class="tt-title">
                      <a href="#">{{ lineItem.description }}</a>
                    </h2>

                  </div>
                </div>
              </div>
              <div class="col-sm-12 col-md-7">
                <div class="row">
                <div class="col-12 col-md-5">
                    <div class="my-2 tt-input-counter style-01 float-sm-right float-md-left">
                      <span @click="minusQty(order.order, lineItem, orderIndex)" class="minus-btn"></span>
                      <input v-model="lineItem.qty" type="number" @change="updateCart(order.order, lineItem, orderIndex)" size="5">
                      <span @click="addQty(order.order, lineItem, orderIndex)"  class="plus-btn"></span>
                    </div>
                  <br />
                  <label class="error-text" v-if="lineItem.error">{{ lineItem.error }}</label>
                </div>
                <div class="col-10 col-md-5">
                    <div class="tt-price">
                      <line-item-adjustment :line-item="lineItem"></line-item-adjustment>
                    </div>
                </div>
                <div class="col-2 col-md-1">
                  <a @click.prevent="removeItem(order.order, lineItem, orderIndex)"
                     v-model="lineItem.remove" class="tt-btn-close"></a>
                </div>
                </div>
              </div>
            </div>


<!--            <tr  v-if="adjustment.amount > 0" v-for="(adjustment, index) in order.order.orderAdjustments" class="adjustment">-->
<!--              <td colspan="2">-->

<!--              <td>{{ adjustment.type }}</td>-->
<!--              <td>-->
<!--                <strong>{{ adjustment.name }}</strong>-->
<!--                <div v-if="adjustment.isEstimated">-->
<!--                  <small class="text-sm text-grey-dark">Estimated</small>-->
<!--                </div>-->
<!--                <br><template v-if="adjustment.description.trim() !== ''">({{ adjustment.description }})</template>-->
<!--              </td>-->
<!--              <td class="text-right">{{ adjustment.amountAsCurrency }}</td>-->
              <div class="row">
                <div class="col-sm-12 col-md-8"></div>
                <div class="col-sm-12 col-md-4">

                  <div class="text-right align-text-top">
<!--                    <h6>Item Sub Total: {{ order.order.itemSubtotalAsCurrency }}</h6>-->
                    <ul class="list-unstyled">
                      <li v-if="order.order.totalDiscount">Total Discount: {{ order.order.totalDiscountAsCurrency }}</li>
                      <li v-if="order.order.totalShippingCost">Total Delivery: {{ order.order.totalShippingCostAsCurrency }}</li>
                      <li v-if="order.order.totalTax !== 0">Total Tax: {{ order.order.totalTaxAsCurrency }}</li>
                      <li v-if="order.order.totalTaxIncluded !== 0">Total Tax (inc): {{ order.order.totalTaxIncludedAsCurrency }}</li>
                    </ul>
                    <h4>Total: {{ order.order.totalPriceAsCurrency }}</h4>
                  </div>
                </div>
              </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Loading from 'vue-loading-overlay';
  import _ from 'lodash';
  import LineItemAdjustment from '../components/LineItemAdjustment';

  export default {
    name: "MultipleCart",
    components: {
      Loading,
      LineItemAdjustment
    },
    props: ['carts'],
    data() {
      return {
        orders: {},
        isLoading: false
      }
    },
    methods: {
      addQty(order, lineItem, orderIndex) {
        lineItem.qty++;

        this.updateCart(order, lineItem, orderIndex, 'add');
      },
      minusQty(order, lineItem, orderIndex)
      {
        if (lineItem.qty > 0) {
          lineItem.qty--;
        } else {
          lineItem.qty = 0;
        }
        this.updateCart(order, lineItem, orderIndex, 'minus');
      },
      updateCartShipping: _.debounce(function (order, orderIndex) {
        let data = {};
        data[csrfTokenName] = csrfTokenValue;

        data['orderNumber'] = order.number;
        data['siteId'] = order.siteId;
        data['shippingMethodHandle'] = order.shippingMethodHandle;
        this.orders[orderIndex].loading = true;
        axios.post(updateCartAction, data)
          .then((response) => {
            this.orders[orderIndex].order = response.data.cart;
            this.orders[orderIndex].loading = false;
          });
      }, 1000),
      removeItem(order, lineItem, orderIndex) {
        lineItem.remove = 1;
        this.updateCart(order, lineItem, orderIndex);
      },
      updateCart: _.debounce(function (order, lineItem, orderIndex, method = null) {
        // this.$emit('update', {
        //   order: order,
        //   index: index,
        //   ref: ref
        // });
        let data = {
          lineItems: {}
        };
        data[csrfTokenName] = csrfTokenValue;

        let lineItemId = lineItem.id;
        // data['lineItems'][lineItemId] = {
        //   qty: lineItem.qty,
        //   purchasableId: lineItem.purchasableId,
        //   orderId: order.id
        // };
        data['orderNumber'] = order.number;
        data['siteId'] = order.siteId;
        data['lineItems'][lineItemId] = lineItem;
        data['shippingMethodHandle'] = order.shippingMethodHandle;
        this.orders[orderIndex].loading = true;

        axios.post(updateCartAction, data)
          .then((response) => {
            if (response.data.success === true) {


              let lineItems = this.orders[orderIndex].order.lineItems;

              this.orders[orderIndex].order = response.data.cart;

              for (let [index, item] of lineItems.entries()) {
                // Merge to add productImage
                let cartLineItem = this.orders[orderIndex].order.lineItems.find(obj => obj.id === item.id);
                if (typeof cartLineItem !== "undefined") {

                  cartLineItem.productImage = item.productImage

                }
              }
            } else {

              let cartLineItem = this.orders[orderIndex].order.lineItems.find(obj => obj.id === lineItem.id);

              if (method !== null  && method === 'add' && cartLineItem !== null) {
                cartLineItem.qty = cartLineItem.snapshot.maxQty;
                cartLineItem.error = "Max quantity for this item is " + cartLineItem.qty;
              }
            }


            this.orders[orderIndex].loading = false;
          });
      }, 1000)
    },
    mounted() {
      this.orders = this.carts;
    }
  }
</script>

<style scoped>

</style>
