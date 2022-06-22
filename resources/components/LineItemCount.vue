<template>

    <span class="badge">{{ qty }}</span>

</template>

<script>
  export default {
    name: "LineItemCount",
    props: ['time', 'item-qty'],
    data() {
      return {
        qty: 0
      }
    },
    methods: {
      getQty() {
        let csrf = {};
        csrf[csrfTokenName] = csrfTokenValue;

        axios.post(lineItemCountAction, csrf)
          .then((response) => {
            this.qty = response.data.qty;
          });
      },
      doPoll() {
        this.getQty();
        // let that = this;
        // setTimeout(function() {
        //   that.doPoll();
        // }, 15000);
      }
    },
    mounted() {
      if (this.itemQty != null) {
        this.qty = this.itemQty;
      } else {
        this.doPoll();
      }
    },
    watch: {
      time(value) {
        console.log('line item qty change')
        this.getQty();
      }
    }
  }
</script>

<style scoped>

</style>
