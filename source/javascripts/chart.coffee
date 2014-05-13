#= require jquery
$ = jQuery

data = [['Date','#beers'],['01/01/14','7'],['02/01/14','2'],['03/01/14','4'],['05/01/14','6']]



$(document).ready ->

  graphContainer  = $('<div>', {"class": "graph"})
  barContainer    = $('<div class = "bars"></div>')
  container = $('#chart')
  container.addClass("chart")
  xLegend = []
  yLegend = []
  bars = []
  chartYMax = 0

  chartWidth = 300
  chartHeight = 250
  graphWidth = chartWidth * 0.80
  graphHeight = chartHeight * 0.63

  content = (data) ->
    for pair,i in data
      unless i is 0
        xLegend.push(pair[0])
        yLegend.push(pair[1])
        if pair[1] > chartYMax then chartYMax = pair[1]

  createAxis = ->
    yAxislist = $('<ul class = "y-axis"></ul>')
    for y in [chartYMax..0] 
      $('<li>' + y + '</li>').appendTo(yAxislist)
    yAxislist.appendTo(graphContainer)

    xAxislist = $('<ul class = "x-axis"></ul>')
    for x in xLegend 
      $('<li>' + x + '</li>').appendTo(xAxislist)
    xAxislist.appendTo(graphContainer)

  createGraph = (data)->
    for pair,i in data
      unless i is 0
        bar = {}
        bar.label  = pair[1]
        bar.height = Math.floor(bar.label / chartYMax * 100) + '%'
        bar.div = $('<div class = "bar fig'+ i + '">' + bar.label + '</div>')
          .appendTo(barContainer)
        bars.push(bar)
    barContainer.insertAfter(graphContainer.children().eq(0))

  displayGraph = (bars) ->
    width = Math.floor((graphWidth) / bars.length * 0.7)
    margin = Math.floor((graphWidth) / bars.length * 0.15)
    for bar,i in bars
      bar.div.css({
        'background-color': getRandomColor()
        'vertical-align':'bottom'
        'width': width
        'margin': '0 ' + margin + 'px'})
      bar.div.animate { 
        height: bar.height
      }, 400
    

  resetGraph = ->

  getRandomColor = -> 
    letters = '0123456789ABCDEF'.split('');
    color = '#';
    for i in [0...6]
        color += letters[Math.floor(Math.random() * 16)];
    color


  content(data)
  createAxis()
  createGraph(data)
  graphContainer.appendTo(container)
  displayGraph(bars)


    