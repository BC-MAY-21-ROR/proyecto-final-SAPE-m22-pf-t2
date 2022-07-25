import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  openDropdown() {
    let element = this.element;
    const dropdown = document.getElementById('avatar-dropdown');
    while (element.nodeName !== 'BUTTON') {
      element = element.parentNode;
    }
    Popper.createPopper(element, dropdown, {
      placement: 'bottom-start',
    });
    dropdown.classList.toggle('hidden');
    dropdown.classList.toggle('block');
  }
}
