import { Turbo } from "@hotwired/turbo-rails"
import { Application } from "stimulus"
import ConfirmationController from "./controllers/confirmation_controller"

const application = Application.start()
application.register("confirmation", ConfirmationController)

// Configure Stimulus development experience
application.debug = true
window.Stimulus   = application

export { application }
