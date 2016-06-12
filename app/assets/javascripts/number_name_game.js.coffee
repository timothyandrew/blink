class @NumberNameGame
  constructor: (@container, numbers) ->
    @numbers = numbers
    @number_names = _.clone(@numbers)

    @stagedNumber = null
    @stagedNumberName = null

    @translator = new T2W("EN_US")
    @render()

  render: =>
    # Numbers
    @container.find('.numbers').html('')
    @container.find('.numbers').append("<h2>Numbers</h2>")
    _.each(@numbers, (number) =>
      @container.find('.numbers').append("<a class='btn number'>#{number}</a>")
    )

    # Number Names
    @container.find('.number-names').html('')
    @container.find('.number-names').append("<h2>Number Names</h2>")
    _.each(@number_names, (number_name) =>
      @container.find('.number-names').append("<a class='btn number-name' data-number='#{number_name}'>#{@translator.toWords(number_name)}</a>")
    )

    # Staged
    if @stagedNumber
      @container.find(".staging-numbers").html("<a class='btn number'>#{@stagedNumber}</a>")

    if @stagedNumberName
      @container.find(".staging-number-names").html("<a class='btn number-name'>#{@translator.toWords(@stagedNumberName)}</a>")

    # Result
    if @stagedNumber == @stagedNumberName && @stagedNumber != null && @stagedNumberName != null
      @container.find('.result').html("<span class='text-success'>Correct!")
    else if @stagedNumber != @stagedNumberName && @stagedNumber != null && @stagedNumberName != null
      @container.find('.result').html("<span class='text-danger'>Wrong!")

    # Hook Up Events
    @container.find('.numbers a').click(@stageNumber)
    @container.find('.number-names a').click(@stageNumberName)

  stageNumber: (event) =>
    @numbers.push @stagedNumber if @stagedNumber
    @stagedNumber = parseInt($(event.target).text())
    @numbers = _.without(@numbers, @stagedNumber)
    @render()

  stageNumberName: (event) =>
    @number_names.push @stagedNumberName if @stagedNumberName
    @stagedNumberName = $(event.target).data('number')
    @number_names = _.without(@number_names, @stagedNumberName)
    @render()
