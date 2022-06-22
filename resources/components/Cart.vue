<template>
  <div>
    <h1 class="tt-title-subpages noborder">SHOPPING CART</h1>
    <loading :active.sync="loading"
    ></loading>
    <div class="tt-shopcart-table-02" v-if="!loading">
      <multiple-cart :carts.sync="carts.orders"></multiple-cart>
      <div class="tt-shopcart-btn">
        <div class="col-left">
          <a class="btn-link" href="/products"><i class="icon-e-19"></i>CONTINUE SHOPPING</a>
        </div>
      </div>

      <div class="tt-shopcart-col">
        <div class="row">
          <div class="col-md-6 col-lg-4">
            <div class="tt-shopcart-box tt-boredr-large">
              <table class="tt-shopcart-table01">

                <tfoot>
                <tr>
                  <th>Overall Total:</th>
                  <td>{{ overAllTotal }}</td>
                </tr>
                </tfoot>
              </table>
              <a href="/checkout" @click.prevent="checkout" class="btn btn-lg"><span class="icon icon-check_circle"></span>PROCEED TO CHECKOUT</a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <b-modal id="min-order" size="xl" hide-footer @hidden="hideModal">
      <h1>Minimum order total should be ₱350 to checkout</h1>

      <button class="btn" variant="outline-danger" block @click="hideModal">Close</button>
    </b-modal>
  </div>
</template>

<script>
  import MultipleCart from '../mixins/MultipleCart';
  export default {
    name: "Cart",
    mixins: [MultipleCart],
    data() {
      return {
        loading: true,
        location: null,
        orders: {},
        multipleOrder: {},
        currency: null,
        currentOrder: {},
        lineItems: {},
        values: []
      }
    },
    methods: {
      hideModal() {
        this.$bvModal.hide('min-order');
        window.history.pushState({}, null, this.location);
      },
      minOrder() {
        this.location = window.location.href;
        window.history.pushState("/", "", "#show");
       this.$bvModal.show('min-order');
        let self = this;
        setTimeout(function() {
          self.$bvModal.hide('min-order');
        }, 2000);
      },
      checkout() {
        if (this.getOverAllTotal() < 350) {
          this.minOrder();
        } else {
          window.location.href = '/checkout';
        }
      },
      getOverAllTotal() {
        if (this.carts.orders.length > 0) {
          let total = 0;
          for (let cart of this.carts.orders) {
            total = total + cart.order.totalPrice;
          }

          return total;
        }
      }
    },
    mounted() {

      let self = this;
      window.onpopstate = function(event) {
        self.$bvModal.hide('min-order');
      };

      if (this.multipleCart) {
        this.loading = false;
      }
    },
    computed: {
      overAllTotal() {
          let total = this.getOverAllTotal();

          if (total !== undefined) {
            return this.carts.currency + total.toLocaleString('en-US');
          }
          return 0;
        }
    }
  }
</script>

<style scoped>

</style>
