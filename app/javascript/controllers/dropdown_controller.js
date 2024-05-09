import { Controller } from "@hotwired/stimulus"
import { installEventHandler } from "./mixins/event_handler"
import { useClickOutside } from "stimulus-use"

{/* 
  <details class="c-dropdown" data-controller="dropdown">
    <summary role="button">
      ...
    </summary>

    <div role="menu" data-dropdown-target="menu" aria-orientation="vertical" tabindex="-1">
      <a href="#" role="menuitem" tabindex="-1">...</a>
      <a href="#" role="menuitem" tabindex="-1">...</a>
      <a href="#" role="menuitem" tabindex="-1">...</a>
    </div>
  </details> 
*/}

export default class extends Controller {
  static targets = ['menu']

  initialize () {
    installEventHandler(this)
  }

  connect () {
    useClickOutside(this)
  }

  clickOutside(event) {
    // event.preventDefault() // Prevents any default behavior when clicking outside the dropdown
    this.element.removeAttribute('open')
  }
}
