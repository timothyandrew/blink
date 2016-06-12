class @NumberParser
  constructor: (@field, @displayField, @submitButton) ->
    @field.keydown(@verify)
    @submitButton.disable()

  refresh: =>
    @verify()

  verify: =>
    if @field.val().match(/^\d+-\d+$/)
      @displaySuccess()
    else
      @displayError('Not in the correct format')

  displayError: =>
    @displayField.html("<div class='text-danger'>Not in the correct format, sorry!</div>")

  displaySuccess: =>
    @displayField.html("<div class='text-success'>Looks good!</div>")

