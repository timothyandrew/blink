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
    var context = _.extend({index: this.index}, this.data, attributes);

    // Hack to accomodate Rails setting `errors` to `{}` when there are no errors.
    // Handlebars can't look for `empty`, so we need to null it out.
    if(_.isEmpty(context.errors)) {
      context.errors = null;
    } else {
      context.errors = this.transformErrors(context.errors);
    }

    var template = HandlebarsTemplates[this.template](context);
    this.index++;
    $(this.fields).append(template);
  }

  addItems(items) {
    _.each(items, _.bind(this.addItem, this));
  }

  removeAll() {
    $(this.fields).html("");
  }

  setup() {
    $(this.addField).click(_.bind(this.addItem, this));
    return this;
  }

  // TODO: Make errors it's own entity.
  transformErrors(errors) {
    return _.mapObject(errors, (error_messages, attr) => {
      return "" + _.titleize(attr) + ": " + error_messages.join(", ");
    });
  }
}
