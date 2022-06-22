<template>
  <div>

    <button :disabled="submit" @click.prevent="submitButton" class="btn btn-sm w-auto">
      <slot></slot>
      {{ text }}
    </button>
      <span v-if="submit" class="loader"></span>
      <span v-if="checked === true && error === false" class="checkmark"></span>
      <span v-if="error === true" class="xmark"></span>
    <div>
      <span v-if="checked === true && error === false"><small>{{ successMessage }}</small> <slot name="success-message"></slot></span>
      <span v-if="error === true">{{ errorMessage }}</span>
    </div>
  </div>
</template>

<script>

  export default {
    name: "SubmitButton",
    props: {
      text: String,
      successMessage: {
        type: String,
        default: ''
      },
      errorMessage: {
        type: String,
        default: ''
      },
      submitting: Boolean,
      hasError: Boolean
    },
    model: {
      prop: 'submitting',
      event: 'clicked'

    },
    data() {
      return {
        submit: false,
        checked: false,
        error: false
      }
    },
    methods: {
      submitButton() {
        this.submit = true;
        this.$emit('clicked', this.submit)
      }
    },
    mounted() {
      this.submit = this.submitting;
      this.error = this.hasError;
    },
    watch: {
      submitting(value) {
        this.submit = value;

        if (value === false) {
          this.checked = true;
          let self = this;
          setTimeout(function() {
            self.checked = false;
            self.error = false;
          },3000);
        }
      },
      hasError(value) {
        this.error = value;
      }
    }
  }
</script>

<style lang="scss" scoped>

  .button {
    font-size: 1.3em;
  }

  .relative {
    position: relative;
  }
  .loader,
  .loader:after {
    border-radius: 50%;
    width: 2em;
    height: 2em;
  }
  .loader {
    position: relative;
    top: 2px;
    display: inline-block;
    margin: 0 auto;
    margin-top: 2px;
    font-size: 10px;
    text-indent: -9999em;
    border-top: .5em solid rgba(94,109,251, 0.2);
    border-right: .5em solid rgba(94,109,251, 0.2);
    border-bottom: .5em solid rgba(94,109,251, 0.2);
    border-left: .5em solid #5e6dfb;
    -webkit-transform: translateZ(0);
    -ms-transform: translateZ(0);
    transform: translateZ(0);
    -webkit-animation: load8 1.1s infinite linear;
    animation: load8 1.1s infinite linear;
  }
  @-webkit-keyframes load8 {
    0% {
      -webkit-transform: rotate(0deg);
      transform: rotate(0deg);
    }
    100% {
      -webkit-transform: rotate(360deg);
      transform: rotate(360deg);
    }
  }
  @keyframes load8 {
    0% {
      -webkit-transform: rotate(0deg);
      transform: rotate(0deg);
    }
    100% {
      -webkit-transform: rotate(360deg);
      transform: rotate(360deg);
    }
  }


  .checkmark{
    display:inline-block;
    margin: 0 .5em;
    &:after{
      /*Add another block-level blank space*/
      content: '';
      display: block;

      /*Make it a small rectangle so the border will create an L-shape*/
      width: 8px;
      height: 17px;

      /*Add a white border on the bottom and left, creating that 'L' */
      border: solid #1f9d55;
      border-width: 0 2px 2px 0;

      /*Rotate the L 45 degrees to turn it into a checkmark*/
      transform: rotate(45deg);
    }
  }

  .xmark {
    background: red;
    width: 25px;
    height: 25px;
    position: relative;
    border-radius: 50%;
    padding: 5px;
    display: inline-block;
    top: 4px;

  }
  .xmark:after {
    content: '';
    height: 15px;
    border-left: 2px solid #fff;
    position: absolute;
    transform: rotate(45deg);
    left: 11px;
  }

  .xmark:before {
    content: '';
    height: 15px;
    border-left: 2px solid #fff;
    position: absolute;
    transform: rotate(-45deg);
    left: 11px;
  }
</style>
