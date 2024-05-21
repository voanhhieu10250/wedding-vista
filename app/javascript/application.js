// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "trix";
import "@rails/actiontext";

import * as ActiveStorage from "@rails/activestorage";

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
