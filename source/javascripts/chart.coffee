#= require jquery
$ = jQuery

data = [['Date','#beers'],
        ['01/01/14','7'],
        ['02/01/14','2'],
        ['03/01/14','4'],
        ['04/01/14','3'],
        ['05/01/14','4'],
        ['06/01/14','25']]

$(document).ready ->
  chart = new Chart '#chart'
  chart.draw(data)


    