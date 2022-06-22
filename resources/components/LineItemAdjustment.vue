<template>
  <div v-if="lineItem">
    <div class="item">
      <div v-if="lineItem.onSale">
        <div class="row border-bottom mt-2">
          <small class="col-sm-5">Price:</small>
          <div class="col-sm-5">
            <span class="font-weight-light">{{ lineItem.priceAsCurrency }}</span>
          </div>
        </div>
        <div class="row border-bottom mt-2">
          <small class="col-sm-5">Sale Off:</small>
          <div class="col-sm-5">
            <span class="font-weight-light">{{ lineItem.saleAmountAsCurrency }}</span>
          </div>
        </div>
        <div class="row border-bottom mt-2">
          <small class="col-sm-5">Sale Price:</small>
          <div class="col-sm-5">
            <span class="font-weight-light">{{ lineItem.salePriceAsCurrency }}</span>
          </div>
        </div>
        <div class="row border-bottom mt-2">
          <small class="col-sm-5">Sale Price Subtotal:</small>
          <div class="col-sm-5">
            <span class="font-weight-light">{{ lineItem.subtotalAsCurrency }}</span>
          </div>
        </div>
      </div>
      <div v-else>
        <div class="row border-bottom mt-2">
          <small class="col-sm-5">Price:</small>
          <div class="col-sm-5">
            <span class="font-weight-light">{{ lineItem.priceAsCurrency }}</span>
          </div>
        </div>
        <div class="row border-bottom mt-2">
          <small class="col-sm-5">Subtotal:</small>
          <div class="col-sm-5">
            <span class="font-weight-light">{{ lineItem.subtotalAsCurrency }}</span>
          </div>
        </div>
      </div>
      <div class="row border-bottom mt-2" v-if="lineItem.saleAmount > 0 && lineItem.snapshot.sales">
        <small class="col-sm-5" v-if="index === 0">Sales Applied:</small>
        <div class="col-sm-5"><span v-for="sale in lineItem.snapshot.sales">{{ sale.name }} </span></div>
      </div>
    </div>
<!--    <div v-if="adjustment.amount > 0" v-for="adjustment in lineItem.adjustments" class="adjustment">-->
<!--      <div class="row border-bottom mt-2">-->
<!--        <div class="col-sm-5">-->
<!--&lt;!&ndash;          <small>{{ adjustment.type }}</small>&ndash;&gt;-->
<!--          <small>{{ adjustment.name }}</small>-->
<!--          <small v-if="adjustment.isEstimated">-->
<!--            <i class="text-sm text-grey-dark">Estimated</i>-->
<!--            <template v-if="adjustment.description.trim() !== ''">({{ adjustment.description }})</template>-->
<!--          </small>-->
<!--        </div>-->
<!--      <div class="col-sm-5">{{ adjustment.amountAsCurrency }}</div>-->
<!--      </div>-->
<!--    </div>-->
    <div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "LineItemAdjustment",
    props: ['line-item'],
    watch: {
      "lineItem.qty": function (value) {
      }
    }
  }
</script>

<style scoped>

</style>
