// -*- mode: Javascript; -*-

class PictureComprehension {
  constructor(base, target, banner) {
    this.base = base;
    this.target = target;
    this.banner = banner;
  }

  verifyOrder() {
    var correct = true;
    $(this.target).children().each((i, child) => {
      if($(child).data('position') != i) {
        correct = false;
      }
    });
    return correct;
  }

  updateBanner(correct) {
    if(correct) {
      $(this.banner).find(".panel-title").text("Correct!");
      $(this.banner).find(".panel-body").text("The story on the right is in the right order.");
      $(this.banner).find(".panel").removeClass("panel-info");
      $(this.banner).find(".panel").removeClass("panel-danger");
      $(this.banner).find(".panel").addClass("panel-success");
    } else {
      $(this.banner).find(".panel-title").text("Incorrect");
      $(this.banner).find(".panel-body").text("There are mistakes in the order of the story on the right.");
      $(this.banner).find(".panel").removeClass("panel-info");
      $(this.banner).find(".panel").removeClass("panel-success");
      $(this.banner).find(".panel").addClass("panel-danger");
    }
  }

  setup() {
    this.drake = dragula([this.base, this.target]);
    this.drake.on('drop', () => {
      var result = this.verifyOrder();
      this.updateBanner(result);
    })
  }
}
