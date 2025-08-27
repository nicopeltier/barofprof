import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  connect() {
    window.HSStaticMethods?.autoInit && window.HSStaticMethods.autoInit();
  }
}
