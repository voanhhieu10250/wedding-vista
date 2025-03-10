// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "trix";
import "@rails/actiontext";
import * as ActiveStorage from "@rails/activestorage";

import LocalTime from "local-time";
LocalTime.start();

ActiveStorage.start();

// Set the delay for the progress bar to 200ms
const delayInMilliseconds = 200;
Turbo.setProgressBarDelay(delayInMilliseconds);

// Fix for the issue where the user is redirected to the login page inside a turbo-frame
document.addEventListener("turbo:frame-missing", (event) => {
  event.preventDefault();
  // console.log("Frame missing event", event);

  // if the url of the response is /login, then it means the user is not
  // logged in when request was made, so we redirect to the login page
  if (event.detail.response.url.includes("/login"))
    event.detail.visit(event.detail.response.url, { action: "replace" });
});

document.addEventListener("turbo:load", (event) => {
  const timeZoneFields = document.querySelectorAll(
    'input[name="time_zone"], input[name$="[time_zone]"]'
  );

  timeZoneFields.forEach((field) => {
    field.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
  });
});

const allowedImageTypes = [
  "image/png",
  "image/jpg",
  "image/jpeg",
  "image/gif",
  "image/webp",
];
document.addEventListener("trix-file-accept", (event) => {
  if (!allowedImageTypes.includes(event.file.type)) {
    event.preventDefault();
    alert("Only support attachment of png, jpg, jpeg, webp, gif files");
  }

  // Prevent attaching files larger than 10MB
  if (event.file.size > 10000000) {
    event.preventDefault(); // prevent attaching the file to the document.
    alert("Upload file size must be less than 10MB");
  }
});
document.addEventListener("trix-before-initialize", (e) => {
  Trix.config.blockAttributes.default.tagName = "p";
  // Fix trix bug:
  // When press Enter it creates a new paragraph tag instead of inserting a <br> tag inside the current paragraph tag.
  Trix.config.blockAttributes.default.breakOnReturn = true;
  Trix.models.Block.prototype.breaksOnReturn = function () {
    const attr = this.getLastAttribute();
    const config = Trix.config.blockAttributes[attr ? attr : "default"];
    return config ? config.breakOnReturn : false;
  };
  Trix.models.LineBreakInsertion.prototype.shouldInsertBlockBreak =
    function () {
      if (
        this.block.hasAttributes() &&
        this.block.isListItem() &&
        !this.block.isEmpty()
      ) {
        return this.startLocation.offset > 0;
      } else {
        return !this.shouldBreakFormattedBlock() ? this.breaksOnReturn : false;
      }
    };
});
