#= require jquery
$ = jQuery

data = [['Date','#beers'],['01/01/14','7'],['02/01/14','2'],['03/01/14','4'],['05/01/14','6']]

$(document).ready ->
  chart = new Chart '#chart'
  chart.draw(data)


    