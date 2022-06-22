export default {
  data() {
    return {
      time: null,
      menuToggle: false,
      categoryToggle: false,
      categoryToggleIcon: false,
      desktopCategoryToggle: false,
      accountToggle: false,
      mobileAccountToggle: false,
      filterToggle: false
    }
  },
  methods: {
    onMenuToggle() {
      this.menuToggle = !this.menuToggle
    },
    onCategoryToggle() {
      this.categoryToggle = !this.categoryToggle

      if (this.categoryToggleIcon === true) {
        this.menuToggle = !this.menuToggle;
        this.categoryToggleIcon = !this.categoryToggleIcon;
      }
    },
    onCategoryToggleIcon() {
      this.menuToggle = !this.menuToggle;
      this.categoryToggle = !this.categoryToggle;
      this.categoryToggleIcon = !this.categoryToggleIcon;
    },
    closeOverlay() {
      this.menuToggle = false;
      this.mobileAccountToggle = false;
      this.accountToggle = false;
      this.cartToggle = false;
      this.categoryToggle = false;
      this.filterToggle = false;
    }
  },
  mounted() {
    let date = new Date();
    this.time = date.getTime();

    // Get the element
    let elem = document.querySelector('#category-menu');
    let clone = elem.cloneNode(true);
    let desktopElem = document.querySelector('#desktop-category-menu');
    desktopElem.append(clone);

    let elemAccount = document.querySelector('#desktop-account-menu');
    let cloneAccount = elemAccount.cloneNode(true);
    let desktopElemAccount = document.querySelector('#mobile-account-menu');
    desktopElemAccount.append(cloneAccount);
  },
  computed: {
    overlay() {
      if (this.menuToggle === true || this.mobileAccountToggle === true || this.accountToggle === true || this.filterToggle === true) {
        return true;
      }

      return false;
    }
  },
  watch: {
    time(value) {
      this.time = value;
    }
  }
}
