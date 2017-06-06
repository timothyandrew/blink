class @GoalsTree
  constructor: (@container) ->
    @treeview = @container.jstree(
      core:
        check_callback: true
      plugins: ['contextmenu']
      contextmenu:
        items:
          foobar:
            label: "Rename"
            action: @rename
    )
    @treeview.on('ready.jstree', => @treeview.jstree("open_all"))

  rename: (event) =>
    name = prompt("New name?", event.reference.text())
    name = $.trim(name)

    if _.isEmpty(name)
      return

    data = $(event.reference).parent('li').data()
    @treeview.jstree('rename_node', event.reference, "(saving)")
    $.ajax(
      url: "/students/" + data.studentId + "/goals/" + data.id + ".json"
      dataType: "json"
      data:
        goal:
          title: name
      type: "PATCH"
      success: => @treeview.jstree('rename_node', event.reference, name)
      error: => alert("Something went wrong while saving. Please refresh this page!")
    )

