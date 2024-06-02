import { Controller } from "@hotwired/stimulus";
import { installEventHandler } from "./mixins/event_handler";

// Connects to data-controller="vendor-boosting"
export default class extends Controller {
  static targets = [
    "level",
    "amount",
    "amountDisplay",
    "newBalance",
    "submit",
    "startTime",
  ];
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

  calculate(level, amount) {
    if (
      isNaN(parseInt(amount, 0)) ||
      parseInt(amount, 0) === 0 ||
      isNaN(this.balanceValue)
    )
      return;

    const newBalance = this.balanceValue - amount;
    const isBalanceInvalid = newBalance < 0 || newBalance >= this.balanceValue;

    this.updateFields(
      level,
      amount,
      newBalance,
      isBalanceInvalid,
      isBalanceInvalid
    );
  }

  updateFields(level, amount, newBalance, showWarning, disableSubmit) {
    this.amountTarget.value = amount;
    this.levelTarget.value = level;
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
    let { levelParam, amountParam } = parentTarget.dataset;
    levelParam = parseInt(levelParam);
    amountParam = parseInt(amountParam);

    // if the radio button is already checked
    if (this.selectPackageValue === levelParam) {
      return;
    }

    parentTarget.ariaChecked = true;
    this.selectPackageValue = levelParam;

    // set all other radio buttons to unchecked
    this.element.querySelectorAll("div[aria-checked]").forEach((radio) => {
      if (radio !== parentTarget) {
        radio.ariaChecked = false;
      }
    });

    // calculate the new balance
    const newBalance = this.balanceValue - amountParam;

    const isBalanceInvalid = newBalance < 0 || newBalance >= this.balanceValue;

    this.updateFields(
      levelParam,
      amountParam,
      newBalance,
      isBalanceInvalid,
      isBalanceInvalid
    );
  };

  toggleStartTime = (event) => {
    if (event.target.checked) {
      this.startTimeTarget.disabled = true;
    } else {
      this.startTimeTarget.disabled = false;
    }
  };
}
