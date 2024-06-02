import { Controller } from "@hotwired/stimulus";
import { GOONG_MAP_ACCESS_TOKEN } from "env";

// Connects to data-controller="goong-non-interactive-map"
export default class extends Controller {
  static values = {
    lng: Number,
    lat: Number,
  };
  initialize() {
    goongjs.accessToken = GOONG_MAP_ACCESS_TOKEN;
  }

  connect() {
    if (!this.hasLngValue || !this.hasLatValue) {
      return;
    }

    let map = new goongjs.Map({
      container: this.element,
      style: "https://tiles.goong.io/assets/goong_map_web.json",
      center: [this.lngValue, this.latValue],
      zoom: 16,
      interactive: false,
    });

    new goongjs.Marker().setLngLat([this.lngValue, this.latValue]).addTo(map);
  }
}
