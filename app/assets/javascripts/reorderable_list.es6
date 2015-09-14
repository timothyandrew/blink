class ReorderableList {
  constructor(element, url, options) {
    this.element = element;
    this.url = url;
    this.ajaxQueue = options.ajaxQueue || "GenericAjaxQueue";
    this.paramName = options.paramName || "ids";
    console.log(this.url);
  }

  setup() {
    Sortable.create(this.element, {
      store: {
        set: (sortable) => {
          var data = {};
          data[this.paramName] = sortable.toArray();

          sortable.option('disabled', true);
          $.ajaxq (this.ajaxQueue, {
            url: this.url,
            type: 'put',
            dataType: 'json',
            data: data,
            success: function() {
              sortable.option('disabled', false);
              console.info("Reordered successfully.");
            },
            error: function() {
              console.error("Reorder failed.");
              alert("Reorder failed. Refresh and try again.");
            }
          });
        }
      }
    });

  }
}
