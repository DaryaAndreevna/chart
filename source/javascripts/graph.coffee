class window.Chart
  constructor: (selector) ->
    @container = $(selector).addClass("chart")
    @graphContainer  = $('<div>', {"class": "graph"})
    @barContainer    = $('<div class = "bars"></div>')

    @xLegend = []
    @yLegend = []
    @bars = []
    @chartYMax = 0

    @chartWidth = 300
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
        if pair[1] > @chartYMax then @chartYMax = pair[1]
  createAxis: =>
    yAxislist = $('<ul class = "y-axis"></ul>')
    yAxislist.css({
      color: 'white'
      height: @graphHeight
      margin: '0'
      })
    for y in [@chartYMax..0] 
      $('<li>' + y + '</li>').appendTo(yAxislist)
    yAxislist.appendTo(@graphContainer)

    padding = @graphWidth * 0.01
    xAxislist = $('<ul class = "x-axis"></ul>')
    xAxislist.css({
      width: @graphWidth + 30
      margin: '0 30px'
      color: 'white'
      top: @chartHeight * 0.81
      })
    for x in @xLegend 
      $('<li>' + x + '</li>')
        .css('padding':'0 ' + padding + 'px')
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
      bar.height = Math.floor(bar.label / @chartYMax * 100) + '%'
      bar.div = $('<div class = "bar fig'+ i + '">' + bar.label + '</div>')
        .appendTo(@barContainer)
      @bars.push(bar)
      @barContainer.insertAfter(@graphContainer.children().eq(0))
  displayGraph:  =>
    width = Math.floor((@graphWidth) / @bars.length * 0.7)
    margin = Math.floor((@graphWidth) / @bars.length * 0.16)
    for bar,i in @bars
      bar.div.css({
        'background-color': @randomColor()
        'vertical-align':'bottom'
        'width': width
        'margin': '0 ' + margin + 'px'})
      bar.div.animate { 
        height: bar.height
      }, 400
  randomColor:  =>
    letters = '0123456789ABCDEF'.split('');
    color = '#';
    for i in [0...6]
      color += letters[Math.floor(Math.random() * 16)];
    color
  resetGraph: () ->