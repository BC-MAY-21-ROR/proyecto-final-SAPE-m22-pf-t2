import { Controller } from "stimulus";

export default class extends Controller {
  closeAlert(event) {
    let element = event.target;
    while (element.nodeName !== "BUTTON") {
      element = element.parentNode;
    }
    element.parentNode.parentNode.removeChild(element.parentNode);
  }
}
