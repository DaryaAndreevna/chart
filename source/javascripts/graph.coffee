class window.Chart
  constructor: (selector) ->
    @container = $(selector).addClass("chart")
    @graphContainer  = $('<div>', {"class": "graph"})
    @barContainer    = $('<div class = "bars"></div>')

    @xLegend = []
    @yLegend = []
    @bars = []
    @chartYMax = 0

    @chartWidth = 400
    @chartHeight = 250
    @graphWidth = @chartWidth * 0.80
    @graphHeight = @chartHeight * 0.63

  draw: (data) ->
    @content(data)
    @createAxis()
    @createGraph()
    @graphContainer.appendTo(@container)
    @displayGraph()

  content: (data) =>
    for pair,i in data
      unless i is 0
        xValue = pair[0]
        yValue = parseInt(pair[1])
        @xLegend.push(xValue)
        @yLegend.push(yValue)
        if yValue > @chartYMax then @chartYMax = yValue

  createAxis: =>
    @createYAxis()
    @createXAxis()

  createYAxis: =>
    yAxislist = $('<ul class = "y-axis"></ul>')
    step = Math.ceil(@chartYMax / 5)
    margin = @marginForYCoord(step)
    for y in [@yLastValue..0] 
      if y % step is 0
        $('<li>' + y + '</li>')
        .css('margin',margin)
        .appendTo(yAxislist)
    yAxislist.appendTo(@graphContainer)

  marginForYCoord: (step) =>
    numberOfYCoord = Math.ceil(@chartYMax / step)
    if @chartYMax % 5 is 0
      @yLastValue = @chartYMax 
      margin = '0 10px 17px 10px'
    else 
      margin = '0 10px ' + (17+(5-numberOfYCoord)*10) + 'px 10px'
      for i in [@chartYMax..@chartYMax + step] 
        if i % step is 0
          @yLastValue = i
          break
    margin

  createXAxis: =>
    width  =  @graphWidth / @xLegend.length
    xAxislist = $('<ul class = "x-axis"></ul>')
    for x in @xLegend 
      $('<li>' + x + '</li>')
        .css('width', width)
        .appendTo(xAxislist)
    xAxislist.appendTo(@graphContainer)

  createGraph:  =>
    for value,i in @yLegend
      bar = {}
      bar.label  = value
      bar.height = Math.floor(bar.label / @yLastValue * 100) + '%'
      bar.div = $('<div class = "bar fig'+ i + '"></div>')
        .appendTo(@barContainer)
      pop = $('<div class = "pop hidden">' + bar.label + '</div>')
        .appendTo(bar.div)

      @popUp(bar.div)
      @bars.push(bar)
      @barContainer.insertAfter(@graphContainer.children().eq(0))

  displayGraph:  =>
    width = Math.floor((@graphWidth) / @bars.length * 0.7)
    marginX = Math.floor((@graphWidth) / @bars.length * 0.16)
    marginY = ((@yLastValue - @chartYMax) / @yLastValue * 50) + '%'
    for bar,i in @bars
      bar.div.css({
        'background-color': @randomColor()
        'width': width
        'margin': marginY + ' ' + marginX + 'px'})
      bar.div.animate { 
        height: bar.height
      }, 400
  
  randomColor:  =>
    letters = '0123456789ABCDEF'.split('');
    color = '#';
    for i in [0...6]
      color += letters[Math.floor(Math.random() * 16)];
    color

  popUp: (target) =>
    target.hover(
      () ->
        $(this).find(">:first-child").removeClass('hidden')
      () ->
        $(this).find(">:first-child").addClass('hidden'))

    