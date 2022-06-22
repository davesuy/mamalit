<template>
  <div>
    <div v-if="carts !== null && loading === false">
      <h4>Deliver to</h4>
      <div class="address-select" v-if="carts.multipleOrder && carts.multipleOrder.shippingAddress">
        <ul class="address-data">

          <li v-if="carts.multipleOrder.shippingAddress.attention"><strong>Att: {{
            carts.multipleOrder.shippingAddress.attention }}</strong></li>
          <li v-if="carts.multipleOrder.shippingAddress.title"><strong>{{ carts.multipleOrder.shippingAddress.title
            }}</strong></li>

          <li>
            <strong v-if="carts.multipleOrder.shippingAddress.firstName">{{
              carts.multipleOrder.shippingAddress.firstName
              }}</strong>
            <strong v-if="carts.multipleOrder.shippingAddress.lastName">{{
              carts.multipleOrder.shippingAddress.lastName
              }}</strong>
          </li>
          <li v-if="carts.multipleOrder.shippingAddress.businessName"><strong>{{
            carts.multipleOrder.shippingAddress.businessName }}</strong></li>
          <li v-if="carts.multipleOrder.shippingAddress.businessTaxId" class="text-grey-dark"><strong>{{
            carts.multipleOrder.shippingAddress.businessTaxId }}</strong></li>
          <li v-if="carts.multipleOrder.shippingAddress.address1">{{ carts.multipleOrder.shippingAddress.address1 }}
          </li>
          <li v-if="carts.multipleOrder.shippingAddress.address2">{{ carts.multipleOrder.shippingAddress.address1 }}
          </li>
          <li>
            <span
              v-if="carts.multipleOrder.shippingAddress.postCode">{{ carts.multipleOrder.shippingAddress.postCode }}</span>
          </li>
          <li v-if="carts.multipleOrder.shippingAddress.countryText">{{
            carts.multipleOrder.shippingAddress.countryText
            }}
          </li>
          <li v-if="carts.multipleOrder.shippingAddress.stateText">{{ carts.multipleOrder.shippingAddress.stateText }}
          </li>
          <li v-if="carts.multipleOrder.shippingAddress.phone">{{ carts.multipleOrder.shippingAddress.phone }}</li>
          <li v-if="carts.multipleOrder.shippingAddress.alternativePhone">{{
            carts.multipleOrder.shippingAddress.alternativePhone }}
          </li>
        </ul>

      </div>
      <div v-else>
        <p>No delivery address selected.</p>
      </div>
    </div>
  </div>
</template>

<script>
  import Loading from 'vue-loading-overlay';

  export default {
    name: "ShippingAddress",
    components: {
      Loading
    },
    props: ['carts'],
    data() {
      return {
        loading: false
      }
    },
    methods: {
    },
    mounted() {
    },
    computed: {

    }
  }
</script>

<style scoped>

</style>
