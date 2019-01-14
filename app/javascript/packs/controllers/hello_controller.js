import { Controller } from "stimulus"
export default class extends Controller {
  initialize() {
    this.nameElement.value = this.name
  }

  log(event) {
    console.log(this.nameElement.value)
  }

  paste(event) {
    event.preventDefault();
    alert('whaaat');
  }

  get name() {
    if (this.data.has("name")) {
      return this.data.get("name")
    }
    else {
      return "Default User"
    }
  }

  get nameElement() {
    return this.targets.find("name");
  }
}
