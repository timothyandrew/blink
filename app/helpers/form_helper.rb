module FormHelper
  def label_with_popover(name, title, popover_content)
    label_tag name, title, title: "Help | #{title}", data: {toggle: "popover", content: popover_content,
                                                            trigger: "hover click", placement: "top"}

  end
end
