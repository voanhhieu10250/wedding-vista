import { Controller } from "@hotwired/stimulus";
import { installEventHandler } from "./mixins/event_handler";

// Connects to data-controller="vendor-spending"
export default class extends Controller {
  static targets = ["limit", "amount", "amountDisplay", "newBalance", "submit"];
  static values = { balance: Number, selectedPackage: Number };

  initialize() {
    installEventHandler(this);
  }

  connect() {
    this.handleEvent("click", {
      on: this.element,
      with: this.selectPackage,
      delegation: true,
    });
  }

  calculate() {
    const limitValue = this.limitTarget.value.replace(/\D/g, "");
    this.limitTarget.value = limitValue;

    if (!limitValue) {
      this.updateFields(0, this.balanceValue, false, true);
      return;
    }

    const limit = parseInt(limitValue, 10);
    if (isNaN(limit) || isNaN(this.balanceValue)) return;

    const total = limit * 300000;
    const newBalance = this.balanceValue - total;
    const isBalanceInvalid = newBalance < 0 || newBalance >= this.balanceValue;

    this.updateFields(total, newBalance, isBalanceInvalid, isBalanceInvalid);
  }

  updateFields(amount, newBalance, showWarning, disableSubmit) {
    this.amountTarget.value = amount;
    this.amountDisplayTarget.innerHTML = this.formatWithCommas(amount);
    this.newBalanceTarget.innerHTML = this.formatWithCommas(newBalance);
    this.newBalanceTarget
      .closest("p")
      .classList.toggle("text-red-500", showWarning);
    this.submitTarget.disabled = disableSubmit;
  }

  formatWithCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

  selectPackage = (event, parentTarget) => {
    let { limitParam, amountParam } = parentTarget.dataset;
    limitParam = parseInt(limitParam);
    amountParam = parseInt(amountParam);

    // if the radio button is already checked, fallback to the default behavior
    if (this.selectPackageValue === limitParam) {
      parentTarget.ariaChecked = false;
      this.selectPackageValue = null;
      this.limitTarget.disabled = false;
      this.calculate();
      return;
    }

    parentTarget.ariaChecked = true;
    this.selectPackageValue = limitParam;

    // set all other radio buttons to unchecked
    this.element.querySelectorAll("div[aria-checked]").forEach((radio) => {
      if (radio !== parentTarget) {
        radio.ariaChecked = false;
      }
    });

    // disable the input field
    this.limitTarget.disabled = true;

    // update the limit and amount fields
    this.limitTarget.value = limitParam;

    // calculate the new balance
    const newBalance = this.balanceValue - amountParam;

    const isBalanceInvalid = newBalance < 0 || newBalance >= this.balanceValue;

    this.updateFields(
      amountParam,
      newBalance,
      isBalanceInvalid,
      isBalanceInvalid
    );
  };
}
