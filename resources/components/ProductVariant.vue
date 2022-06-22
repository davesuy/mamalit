<template>
  <div class="tt-modal-quickview desctope" v-if="variants">
    <div class="row">
      <div class="col-12 col-md-5 col-lg-6">
        <div v-if="variants.items" class="tt-mobile-product-slider arrow-location-center">
          <carousel :space-padding="10" :navigation-enabled="true" :per-page="1" :mouse-drag="true" ref="carousel">
            <template v-for="image in productImages">
              <slide class="text-center">
                <img class="productImage" :src="image.url"/>
              </slide>
            </template>
          </carousel>
        </div>
      </div>
      <div class="col-12 col-md-7 col-lg-6">
        <div class="tt-product-single-info">
          <div class="tt-add-info">
            <ul>


            </ul>              <template v-if="getAttribute('hasUnlimitedStock') === false">
            <li>Availability:
              <span v-if="outOfStock()">Out of stock</span>
              <span v-else>{{ getAttribute('stock') }} in Stock</span>
            </li>
          </template>

          </div>
          <select class="form-control my-10" v-if="variants.items !== undefined && variants.items.length > 1" v-model="variants.selected">
            <option v-for="item in variants.items"
                    :value="item.id">{{ item.title }}
            </option>
          </select>
          <h2 class="tt-title" v-else>{{ getAttribute('title') }}</h2>

          <div class="tt-price">
            <span class="new-price">{{ getAttribute('price') }}</span>
            <span class="old-price"></span>
          </div>
          <div v-html="getAttribute('body')" class="tt-wrapper">
          </div>
          <div class="tt-wrapper">
            <div class="row">
              <div class="col-sm-12 mb-2 col-lg-6">
                <div class="tt-input-counter style-01">
                  <span @click="minusQty" class="minus-btn"></span>
                  <input class="qty" type="number" v-model="qty"/>
                  <span @click="qty++" class="plus-btn"></span>
                </div>
              </div>
              <div class="col-sm-12 col-lg-6">
                <submit-button @clicked="addCart" :has-error="error"
                               success-message="Item added"
                               :error-message="errorMessage"
                               text="Add to Cart"
                               v-model="submit">
                  <i class="icon-f-39"></i>
                  <template slot="success-message">
                   | <a href='/cart'><strong>View Cart</strong></a>
                  </template>
                </submit-button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

  import SubmitButton from "../components/SubmitButton";
  import { Carousel, Slide } from 'vue-carousel';

  export default {
    name: "ProductVariant",
    components: {
      SubmitButton,
      Carousel,
      Slide
    },
    props: {
      variants: Object
    },
    data() {
      return {
        qty: 1,
        submit: false,
        error: false,
        errorMessage: "Something is wrong."
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
      getAttribute(handle) {
        let item = this.selectedVariant();
        if (item) {
          return item[handle];
        }
        return null;
      },
      selectedVariant() {
        if (this.variants.items !== undefined) {
          return this.variants.items.find(obj => obj.id === this.variants.selected);
        }
        return null;
      },
      outOfStock() {
        let item = this.selectedVariant();
        return item.stock <= 0 && item.hasUnlimitedStock === false;
      },
      addCart() {
        let selected = this.selectedVariant();
        let data = {
          qty: this.qty,
          purchasableId: selected.id,
          siteId: selected.siteId
        };

        data[csrfTokenName] = csrfTokenValue;

        this.submit = true;
        this.error = false;

        axios.post(updateCartAction, data)
          .then((response) => {
              this.submit = false;

              if (response.data.success === false) {
                this.error = true;

                for (let error in response.data.errors) {
                  let message = response.data.errors[error];
                  this.errorMessage = message[0];
                }
              }

            this.$emit('cart-added', data);
          }).catch((error) => {
            this.error = true;
            this.submit = false;

          });
      }
    },
    computed: {
      productImages() {
        let selectedImages = this.getAttribute('productImages');

        if (selectedImages !== null && selectedImages.length <= 0) {
          let first = this.variants.items[0];
          selectedImages = first.productImages;
        }

        return selectedImages;
      }
    },
    mounted() {
      setTimeout(this.$refs.carousel.computeCarouselWidth, 300)
    }
  }
</script>

<style scoped>
  .qty {
    width: 5rem
  }

  .productImage {
    max-width: 200px;
  }

  .tt-product-single-info select {
    margin-bottom: 1em;
  }
</style>
