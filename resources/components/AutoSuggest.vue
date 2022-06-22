<template>
  <div class="demo">
    <div class="autosuggest-container">
      <vue-autosuggest
        v-model="query"
        :suggestions="filteredOptions"
        @focus="focusMe"
        @click="clickHandler"
        @input="onInputChange"
        @selected="onSelected"
        @keyup.enter="onEnter"
        :get-suggestion-value="getSuggestionValue"
        :input-props="{class: 'form-control', id:'autosuggest__input', placeholder: getPlaceholder}">
        <div slot-scope="{suggestion}" style="display: flex; align-items: center;">
          <div style="{ display: 'flex', color: 'navyblue'}">{{suggestion.item}}</div>
        </div>
      </vue-autosuggest>

      <i class="close" v-if="query !== null && query.trim() !== ''" @click="remove"></i>
    </div>
  </div>
</template>

<script>
  import { VueAutosuggest } from "vue-autosuggest";

  export default {
    components: {
      VueAutosuggest
    },
    model: {
      prop: 'input',
      event: 'change'
    },
    props: {
      input: String,
      actionUrl: String,
      placeholder: String
    },
    data() {
      return {
        query: "",
        selected: "",
        isSelected: false,
        suggestions: [],
        initSuggestions: []
      };
    },
    computed: {
      filteredOptions() {
        return [
          {
            data: this.suggestions.filter(option => {
              return option.toLowerCase().indexOf(this.query.toLowerCase()) > -1;
            })
          }
        ];
      },
      getPlaceholder() {
        return this.placeholder ?? 'What are you looking for?'
      }
    },
    methods: {
      onEnter(ev) {

        if (this.isSelected === false) {
          this.$emit('selected', this.query);
        }

        this.isSelected = false;
      },
      remove() {

        this.onInputChange("");
      },
      clickHandler(item) {
        // event fired when clicking on the input
      },
      onSelected(item) {
        this.isSelected = true;
        if (item !== null) {
          this.selected = item.item;
          this.query = item.item;
        }

        this.$emit('selected', this.query);
      },
      onInputChange(text) {

        this.$emit('change', text);
      },
      /**
       * This is what the <input/> value is set to when you are selecting a suggestion.
       */
      getSuggestionValue(suggestion) {
        return suggestion.item;
      },
      focusMe(e) {
        console.log(e) // FocusEvent
      }
    },
    mounted() {
      this.query = this.input;

      let csrf = {};
      csrf[csrfTokenName] = csrfTokenValue;
      let getActionUrl = suggestionsAction;
      if (this.actionUrl !== undefined) {
         getActionUrl = this.actionUrl;
      }

      axios.post(getActionUrl, csrf)
        .then((response) => {
          this.initSuggestions = response.data.items;
        });
    },
    watch: {
      input: function(value) {
        this.query = value;

        if (value.trim() === '') {
          this.suggestions = [];
        } else {
          this.suggestions = this.initSuggestions;
        }
      }
    }
  }
</script>

<style scoped>
  .demo {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  input {
    width: 260px;
    padding: 0.5rem;
  }

  ul {
    width: 100%;
    color: rgba(30, 39, 46,1.0);
    list-style: none;
    margin: 0;
    padding: 0.5rem 0 .5rem 0;
  }
  li {
    margin: 0 0 0 0;
    border-radius: 5px;
    padding: 0.75rem 0 0.75rem 0.75rem;
    display: flex;
    align-items: center;
  }
  li:hover {
    cursor: pointer;
  }

  .autosuggest-container {
    display: flex;
    justify-content: center;

    position: relative;
  }

  #autosuggest { width: 100%; display: block;}
  .autosuggest__results-item--highlighted {
    background-color: rgba(51, 217, 178,0.2);
  }

  .close {
    position: absolute;
    right: 0;
    top: 0;
    padding: 10px 16px 27px 14px;
    width: 12px;
    height: 12px;
    opacity: 0.8;
  }
  .close:hover {
    opacity: 1;
  }
  .close:before, .close:after {
    position: absolute;
    left: 13px;
    content: ' ';
    height: 12px;
    width: 2px;
    background-color: #333;
  }
  .close:before {
    transform: rotate(45deg);
  }
  .close:after {
    transform: rotate(-45deg);
  }
</style>
