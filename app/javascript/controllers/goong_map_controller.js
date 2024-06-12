import { Controller } from "@hotwired/stimulus";
import { GOONG_MAP_ACCESS_TOKEN, GOONG_MAP_API_ACCESS_TOKEN } from "env";

// Connects to data-controller="goong-map"
export default class extends Controller {
  static targets = [
    "map",
    "geocoder",
    "geocoderResult",
    "fullAddress",
    "district",
    "province",
    "latitude",
    "longitude",
  ];

  initialize() {
    window.goongjs.accessToken = GOONG_MAP_ACCESS_TOKEN;
    this.apiAccessToken = GOONG_MAP_API_ACCESS_TOKEN;
  }

  connect() {
    if (this.hasMapTarget) this.#prepareMap();
    if (this.hasGeocoderTarget)
      this.#prepareGeocoder("#" + this.geocoderTarget.id);
    else if (document.getElementById("geocoder"))
      this.#prepareGeocoder("#geocoder");
  }

  disconnect() {
    this.#removeMarker();
  }

  #prepareMap() {
    this.map = new window.goongjs.Map({
      container: this.mapTarget,
      style: "https://tiles.goong.io/assets/goong_map_web.json", // stylesheet location
      center: [106.70105355500004, 10.776553100000058], // starting position [lng, lat]
      zoom: 9, // starting zoom
    });

    // Add zoom and rotation controls to the map.
    this.map.addControl(new window.goongjs.NavigationControl());
  }

  #prepareGeocoder(geocoderElId) {
    this.geocoder = new window.GoongGeocoder({
      accessToken: this.apiAccessToken,
      placeholder: "Nhập địa chỉ cần tìm kiếm...",
    });

    this.geocoder.addTo(geocoderElId);
    this.fullAddressTarget.value &&
      this.geocoder.setInput(this.fullAddressTarget.value);

    // Add geocoder result to container.
    this.geocoder.on("result", (e) => {
      if (this.hasGeocoderResultTarget)
        this.geocoderResultTarget.innerText = JSON.stringify(e.result, null, 2);

      let result = e.result.result;
      this.#updateResultFields(result);

      if (this.hasMapTarget && result.geometry.location) {
        this.#addMarker(
          result.geometry.location.lng,
          result.geometry.location.lat
        );
      }
    });

    // Clear results container when search is cleared.
    this.geocoder.on("clear", () => {
      if (this.hasGeocoderResultTarget)
        this.geocoderResultTarget.innerText = "";
      this.#clearResultFields();
      if (this.hasMapTarget) this.#removeMarker();
    });
  }

  #addMarker(lng, lat) {
    this.currentMarker = new window.goongjs.Marker()
      .setLngLat([lng, lat])
      .addTo(this.map);

    this.map.flyTo({ center: [lng, lat], zoom: 13 });
  }

  #removeMarker() {
    if (this.currentMarker) this.currentMarker.remove();
  }

  #updateResultFields(result) {
    if (this.hasFullAddressTarget)
      this.fullAddressTarget.value = result.formatted_address;
    if (this.hasDistrictTarget)
      this.districtTarget.value = result.compound.district;
    if (this.hasProvinceTarget)
      this.provinceTarget.value = result.compound.province;
    if (this.hasLatitudeTarget)
      this.latitudeTarget.value = result.geometry.location.lat;
    if (this.hasLongitudeTarget)
      this.longitudeTarget.value = result.geometry.location.lng;
  }

  #clearResultFields() {
    if (this.hasFullAddressTarget) this.fullAddressTarget.value = "";
    if (this.hasDistrictTarget) this.districtTarget.value = "";
    if (this.hasProvinceTarget) this.provinceTarget.value = "";
    if (this.hasLatitudeTarget) this.latitudeTarget.value = "";
    if (this.hasLongitudeTarget) this.longitudeTarget.value = "";
  }

  reset() {
    this.geocoder.clear();
    this.element.reset();
  }
}
