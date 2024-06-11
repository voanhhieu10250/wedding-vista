import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import AutoSubmit from '@stimulus-components/auto-submit'
application.register('auto-submit', AutoSubmit)

export { application }
