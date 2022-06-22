<template>
  <div class="addressBox vld-parent">
    <loading :active.sync="loading"
    ></loading>

    <div v-if="loading === false">
      <div class="row">
        <div class="col-sm-6">
          <div class="form-group">
            <label for="address1">Address Line 1 *</label>
            <input type="text" id="address1" class="form-control" name="address1"
                   :class="{ 'form-group--error': $v.address.address1.$error }" v-model.trim="$v.address.address1.$model"
                   value="">
            <template v-if="$v.address.address1.$error">
              <span class="flash block" v-if="!$v.address.address1.required">Field is required.</span>
              <span class="flash block" v-if="!$v.address.address1.minLength">Address 1 must have at least {{$v.address.address1.$params.minLength.min}}</span>
            </template>
          </div>
          <div class="form-group">
            <label for="address2">Address Line 2</label>
            <input type="text" v-model="address.address2" id="address2" class="form-control" name="address2" value="">
          </div>
          <div class="form-group">
            <label>Barangay *</label>
            <input type="text" id="address3" class="form-control" name="address3"
                   :class="{ 'form-group--error': $v.address.address3.$error }" v-model.trim="$v.address.address3.$model"
                   value="">
            <template v-if="$v.address.address3.$error">
              <span class="flash block" v-if="!$v.address.address3.required">Field is required.</span>
              <span class="flash block" v-if="!$v.address.address3.minLength">Barangay must have at least {{$v.address.address3.$params.minLength.min}}</span>
            </template>
          </div>
          <div class="form-group">

              <label>Municipality</label>
              <div>
                <select v-model.trim="$v.address.zipCode.$model" class="form-control" name="zipCode">
                  <option value=null>Choose a Municipality/City</option>
                  <option v-for="(postCode, key) in postCodes" :value="key">{{ postCode }}</option>
                </select>

                <template v-if="$v.address.zipCode.$error">
                  <span class="flash block" v-if="!$v.address.zipCode.required">Field is required.</span>
                </template>
              </div>
          </div>


            <div class="form-group">
              <div v-if="states.length">
                <label>Province:</label>

                <template v-if="states.length === 1">
                  {{ states[0].name }}
                </template>
                <template v-else>
                  <select class="form-control" v-model="address.stateValue">
                    <option v-for="state in states" :value="state.id">{{ state.name }}</option>
                  </select>
                </template>
              </div>
            </div>
            <div class="form-group">
              <div>
                <label>Country: </label>
                <span class="form-control">{{ country.name }}</span>
              </div>
            </div>
          </div>

        <div class="col-sm-6">
          <div class="form-group">
            <label>First Name *</label>
            <input type="text" id="-firstName" class="form-control" name="firstName"
                   :class="{ 'form-group--error': $v.address.firstName.$error }" v-model.trim="$v.address.firstName.$model"
                   value="">
            <template v-if="$v.address.firstName.$error">
              <span class="flash block" v-if="!$v.address.firstName.required">Field is required.</span>
              <span class="flash block" v-if="!$v.address.firstName.minLength">First Name must have at least {{$v.address.firstName.$params.minLength.min}}</span>
            </template>
          </div>
          <div class="form-group">
            <label>Last Name</label>
            <input type="text" id="-lastName" class="form-control" name="lastName"
                   :class="{ 'form-group--error': $v.address.lastName.$error }" v-model.trim="$v.address.lastName.$model"
                   value="">
            <template v-if="$v.address.lastName.$error">
              <span class="flash block" v-if="!$v.address.lastName.required">Field is required.</span>
              <span class="flash block" v-if="!$v.address.lastName.minLength">Last Name must have at least {{$v.address.lastName.$params.minLength.min}}</span>
            </template>
          </div>
          <div class="form-group">
            <label>Phone</label>
            <div>
              <span class="flex py-2">+63</span>
              <input class="form-control d-inline w-75" :class="{ 'form-group--error': $v.address.phone.$error }"
                     v-model.trim="$v.address.phone.$model"
                     type="text" id="phone" name="phone"
                     value="">
            </div>

            <template v-if="$v.address.phone.$error">
              <span class="flash block" v-if="!$v.address.phone.required">Field is required.</span>
              <span class="flash block" v-if="!$v.address.phone.minLength">Phone must have at least {{$v.address.phone.$params.minLength.min}}</span>
              <span class="flash block" v-if="!$v.address.phone.maxLength">Phone must have at most {{$v.address.phone.$params.maxLength.max}}</span>
              <span class="flash block" v-if="!$v.address.phone.numeric">Phone must be a number.</span>
            </template>
          </div>
          <div class="form-group">
            <label>Alternative Phone</label>
            <div>
              <span class="flex py-2">+63</span> <input class="form-control d-inline w-75" type="text" id="alternativePhone"
                                                        :class="{ 'form-group--error': $v.address.alternativePhone.$error }"
                                                        v-model.trim="$v.address.alternativePhone.$model"
                                                        name="alternativePhone"
                                                        value="">
            </div>
            <template v-if="$v.address.alternativePhone.$error">
              <span class="flash block" v-if="!$v.address.alternativePhone.minLength">Phone must have at least {{$v.address.alternativePhone.$params.minLength.min}}</span>
              <span class="flash block" v-if="!$v.address.alternativePhone.maxLength">Phone must have at most {{$v.address.alternativePhone.$params.maxLength.max}}</span>
              <span class="flash block" v-if="!$v.address.alternativePhone.numeric">Phone must be a number.</span>
            </template>
          </div>
          <div class="form-group">
            <label>Notes</label>
            <textarea class="form-control" name="notes" id="notes" cols="30"
                      rows="10"></textarea>
          </div>

          <div class="checkbox-group">
            <input id="makePrimaryShippingAddress" v-model="makePrimaryShippingAddress" name="makePrimaryShippingAddress" type="checkbox" />
            <label for="makePrimaryShippingAddress">
              <span class="check"></span>
              <span class="box"></span>
              Make this the primary shipping address
            </label>
          </div>

        </div>
      </div>
      <input @click="submitAddress" type="button" class="btn btn-primary" value="Save address">
    </div>
  </div>
</template>

<script>
  import {required, minLength, maxLength, numeric, minValue} from 'vuelidate/lib/validators'
  import Loading from 'vue-loading-overlay';

  export default {
    name: "AddressForm",
    components: {
      Loading,
    },
    props: {
      addressId: {
        type: Number,
        required: false
      },
      redirect: {
        type: String,
        required: false
      },
      action: {
        type: String,
        required: false
      }
    },
    data() {
      return {
        loading: true,
        back: null,
        actionUrl: null,
        makePrimaryShippingAddress: null,
        address: {
          phone: '',
          alternativePhone: '',
          firstName: '',
          lastName: '',
          address1: '',
          address2: '',
          address3: '',
          stateValue: null,
          zipCode: null,
          countryId: null,
          notes: null
        },
        states: [],
        country: null,
        postCodes: {}
      }
   },
    validations: {
      address: {
        phone: {
          required,
          minLength: minLength(10),
          maxLength: maxLength(11),
          numeric
        },
        alternativePhone: {
          minLength: minLength(10),
          maxLength: maxLength(11),
          numeric
        },
        address1: {
          required,
          minLength: minLength(3)
        },
        address3: {
          required,
          minLength: minLength(3)
        },
        firstName: {
          required,
          minLength: minLength(3)
        },
        lastName: {
          required,
          minLength: minLength(3)
        },
        zipCode: {
          required
        }
      }
    },
    methods: {
      submitAddress(e) {
        this.$v.$touch()
        if (this.$v.$invalid) {
        } else {
          let address  = {
            address: {
              address1: this.address.address1,
              address2: this.address.address2,
              address3: this.address.address3,
              firstName: this.address.firstName,
              lastName: this.address.lastName,
              phone: this.address.phone,
              alternativePhone: this.address.alternativePhone,
              stateValue: this.address.stateValue,
              countryId: this.address.countryId,
              zipCode: this.address.zipCode,
              notes: this.address.notes
            },
            makePrimaryShippingAddress: this.makePrimaryShippingAddress
          };

          if (this.addressId !== null) {
            let addressId = {
              id: this.addressId
            };

            address.address = {...address.address, ...addressId};
          }

          let data = {};
          data[csrfTokenName] = csrfTokenValue;

          let objects = {...data, ...address};

          axios.post(this.actionUrl, objects)
            .then((response) => {
              window.location.href = this.back;
            }).catch((error) => {

          });
        }
      }
    },
    mounted() {
      let data = {};
      data[csrfTokenName] = csrfTokenValue;
      data['addressId'] = this.addressId;

      this.back = this.redirect;
      this.actionUrl = this.action;
      axios.post(getAddress, data)
        .then((response) => {

          this.address = response.data.address;
          this.states = response.data.states;
          this.country = response.data.country;
          this.postCodes = response.data.postCodes;
          this.makePrimaryShippingAddress = response.data.makePrimaryShippingAddress;
          this.loading = false;
      }).catch((error) => {
        this.loading = false;
      });
    }
  }
</script>

<style scoped>

</style>
