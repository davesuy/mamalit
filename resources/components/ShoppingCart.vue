<template>
  <div>
    <div class="tt-cart tt-dropdown-obj" :class="{'active': toggle }"  data-tooltip="Cart" data-tposition="bottom">
      <button class="tt-dropdown-toggle" @click="onToggle">
        <i class="icon-f-39"></i>
        <span class="tt-badge-cart"><line-item-count v-if="carts.itemQty !== undefined" :item-qty="carts.itemQty" :time="lineTime"></line-item-count></span>
        <small class="text-center">Cart</small>
      </button>
      <transition>
      <div id="tt-cart-dropdown" class="tt-dropdown-menu" v-show="toggle">
        <div class="tt-mobile-add">
          <h6 class="tt-title">SHOPPING CART</h6>
          <button class="tt-close" @click="onToggle">Close</button>
        </div>
        <div class="tt-dropdown-inner">
          <div class="tt-cart-layout">
            <!-- layout emty cart -->
            <!-- <a href="empty-cart.html" class="tt-cart-empty">
                                    <i class="icon-f-39"></i>
                                    <p>No Products in the Cart</p>
                                </a> -->
            <div class="tt-cart-content">
              <div class="vld-parent">
                <loading :active.sync="loading" :is-full-page="false"
                ></loading>
                <div v-if="carts && loading === false" class="tt-cart-list">
                  <div v-for="cart in carts.orders">
                    <loading :active.sync="cart.updating" :is-full-page="false"
                    ></loading>
                    <div class="tt-item" v-for="(lineItem, index) in cart.order.lineItems">
                      <a :href="lineItem.snapshot.url">
                        <div class="tt-item-img">
                          <img height="40" :src="lineItem.productImage" alt="">
                        </div>
                        <div class="tt-item-descriptions">
                          <h2 class="tt-title">{{ lineItem.description }}</h2>
                          <ul class="tt-add-info">
                            <li>Vendor: {{ cart.site.name }}</li>
                          </ul>
                          <div class="tt-quantity">{{ lineItem.qty }} X</div>
                          <div class="tt-price">{{ lineItem.priceAsCurrency }}</div>
                        </div>
                      </a>
                    </div>
                  </div>
                </div>
                <div class="tt-cart-total-row" v-if="overAllTotal">
                  <div class="tt-cart-total-title">Overall Total:</div>
                  <div class="tt-cart-total-price">{{ carts.currency + overAllTotal.toLocaleString('en-US') }}</div>
                </div>
                <div class="tt-cart-total-row" v-else>
                  <div class="tt-cart-total-title">Your cart is empty.</div>
                </div>
              </div>
              <div class="tt-cart-btn">
                <div class="tt-item">
                  <a href="/cart" class="btn">View Cart</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      </transition>
    </div>
    <div class="mm-open">
    <div class="mm-fullscreen-bg" @click="toggle = false" v-show="toggle === true"></div>
    </div>
  </div>
</template>

<script>
  import Loading from 'vue-loading-overlay';
  import ShippingAddress from '../components/ShippingAddress';
  import MultipleCart from '../mixins/MultipleCart';

  export default {
    name: "ShoppingCart",
    components: {
      Loading,
      ShippingAddress
    },
    mixins: [MultipleCart],
    props: ['time-count'],
    data() {
      return {
        loading: false,
        toggle: false,
        carts: {},
        lineTime: null,
        allTotal: 0
      }
    },
    methods: {
      minusQty()
      {
        if (this.qty > 0) {
          this.qty--;
        } else {
          this.qty = 0;
        }
      },
      onToggle() {
        this.toggle = !this.toggle;
      },
      getSelectedShippingMethod(order) {
        return order.availableShippingMethodOptions[order.shippingMethodHandle] ?? null;
      }
    },
    mounted() {

    },
    computed: {
      overAllTotal() {
        if (this.carts.orders !== undefined && this.carts.orders.length > 0) {
          let total = 0;
          for (let cart of this.carts.orders) {
            total = total + cart.order.totalPrice;
          }

          return total;
        }
      }
    },
    watch: {
      timeCount(value) {
        this.lineTime = value;
      }
    }
  }
</script>

<style scoped>
  .vld-parent {
    min-height: 200px;
  }

  header .tt-dropdown-obj div.tt-dropdown-menu {
    display: block
  }
</style>
