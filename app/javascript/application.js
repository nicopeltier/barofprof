import "@hotwired/turbo-rails"
import "./controllers"
import "preline"
import "@tailwindplus/elements"

// Auto-init Preline components on Turbo navigation
document.addEventListener("turbo:load", () => {
  window.HSStaticMethods?.autoInit && window.HSStaticMethods.autoInit();
});
