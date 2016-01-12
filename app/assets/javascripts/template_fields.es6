// -*- mode: Javascript; -*-

class TemplateFields {
  constructor(fields, addField, template, data) {
    this.fields = fields;
    this.addField = addField;
    this.data = data || {};
    this.template = template
    this.index = 1;
  }

  addItem(attributes) {
    var template = HandlebarsTemplates[this.template](_.extend({index: this.index}, this.data, attributes));
    this.index++;
    $(this.fields).append(template);
  }

  addItems(items) {
    _.each(items, _.bind(this.addItem, this));
  }

  setup() {
    $(this.addField).click(_.bind(this.addItem, this));
    return this;
  }
}
