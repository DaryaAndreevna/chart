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
    yAxislist.css({
      height: @graphHeight
      })

    step = Math.ceil(@chartYMax / 5)
    numberOfYCoord = Math.ceil(@chartYMax / step)
    margin = '0 10px 17px 10px'
    if @chartYMax % 5 is 0
      @yLastValue = @chartYMax 
    else 
      margin = '0 10px ' + (17+(5-numberOfYCoord)*10) + 'px 10px'
      for i in [@chartYMax..@chartYMax + step] 
        if i % step is 0
          @yLastValue = i
          break
    for y in [@yLastValue..0] 
      if y % step is 0
        $('<li>' + y + '</li>')
        .css({
          'font-size': '12px'
          margin: margin
          })
        .appendTo(yAxislist)
    yAxislist.appendTo(@graphContainer)

  createXAxis: =>
    width  =  @graphWidth / @xLegend.length
    xAxislist = $('<ul class = "x-axis"></ul>')
    xAxislist.css({
      width: @graphWidth + 30
      margin: '0 30px'
      color: 'white'
      top: @chartHeight * 0.8
      })
    for x in @xLegend 
      $('<li>' + x + '</li>')
        .css({
          width: width
          margin: '10px 0'
          })
        .appendTo(xAxislist)
    xAxislist.appendTo(@graphContainer)


  createGraph:  =>
    @container.css({
      width:  @chartWidth
      height: @chartHeight
      margin: 'auto'
      })
    @barContainer.css({
      width: @graphWidth
      height: @graphHeight
      margin: '0 40px'
      })
    for value,i in @yLegend
      bar = {}
      bar.label  = value
      bar.height = Math.floor(bar.label / @yLastValue * 100) + '%'

      bar.div = $('<div class = "bar fig'+ i + '"></div>').hover(
        () ->
          $(this).find(">:first-child").removeClass('hidden')
        () ->
          $(this).find(">:first-child").addClass('hidden')
      ).appendTo(@barContainer)


      pop = $('<div class = "pop hidden">' + bar.label + '</div>')
        .appendTo(bar.div)

      @bars.push(bar)
      @barContainer.insertAfter(@graphContainer.children().eq(0))


  displayGraph:  =>
    width = Math.floor((@graphWidth) / @bars.length * 0.7)
    marginX = Math.floor((@graphWidth) / @bars.length * 0.16)
    marginY = ((@yLastValue - @chartYMax) / @yLastValue * 50) + '%'
    for bar,i in @bars
      bar.div.css({
        'background-color': @randomColor()
        'vertical-align':'bottom'
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
  popUp:(e) =>
    e.preventDefault()
    e.stopPropagation()
    $(e.target).find(">:first-child").toggleClass("hidden")
    console.log e.target
  resetGraph: () ->