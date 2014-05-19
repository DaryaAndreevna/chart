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
        @xLegend.push(pair[0])
        @yLegend.push(pair[1])
        if parseInt(pair[1]) > @chartYMax then @chartYMax = parseInt(pair[1])
  createAxis: =>
    yAxislist = $('<ul class = "y-axis"></ul>')
    yAxislist.css({
      color: 'white'
      height: @graphHeight + 10
      margin: '0'
      })
    step = Math.ceil(@chartYMax / 5)
    number = Math.floor(@chartYMax / step + 1) 
    margin = '0 10px 20px 10px'
    if number is 6
      
      @yLastValue = @chartYMax 
    else 
      #margin = '0 10px ' + (20+(6-number)*10) + 'px 10px'
      for i in [@chartYMax..@chartYMax + 5] 
        if i % 5 is 0
          @yLastValue = i
          break
    console.log [ step, number, margin, @yLastValue]
    for y in [@yLastValue..0] 
      if y % step is 0
        $('<li>' + y + '</li>')
        .css({
          'font-size': '12px'
          #margin: margin + 'px 10px'
          margin: margin
          })
        .appendTo(yAxislist)
    yAxislist.appendTo(@graphContainer)

    width  =  @graphWidth / @xLegend.length
    xAxislist = $('<ul class = "x-axis"></ul>')
    xAxislist.css({
      width: @graphWidth + 30
      margin: '0 30px'
      color: 'white'
      top: @chartHeight * 0.81
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
      console.log @yLastValue

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
    console.log 'margin' + marginY
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