// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import { Application } from "@hotwired/stimulus";
eagerLoadControllersFrom("controllers", application)
const application = Application.start();
export { application };
