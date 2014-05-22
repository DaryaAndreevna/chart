(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.Chart = (function() {
    function Chart(selector) {
      this.popUp = __bind(this.popUp, this);
      this.randomColor = __bind(this.randomColor, this);
      this.displayGraph = __bind(this.displayGraph, this);
      this.createGraph = __bind(this.createGraph, this);
      this.createXAxis = __bind(this.createXAxis, this);
      this.marginForYCoord = __bind(this.marginForYCoord, this);
      this.createYAxis = __bind(this.createYAxis, this);
      this.createAxis = __bind(this.createAxis, this);
      this.content = __bind(this.content, this);
      this.container = $(selector).addClass("chart");
      this.graphContainer = $('<div>', {
        "class": "graph"
      });
      this.barContainer = $('<div class = "bars"></div>');
      this.xLegend = [];
      this.yLegend = [];
      this.bars = [];
      this.chartYMax = 0;
      this.chartWidth = 400;
      this.chartHeight = 250;
      this.graphWidth = this.chartWidth * 0.80;
      this.graphHeight = this.chartHeight * 0.63;
    }

    Chart.prototype.draw = function(data) {
      this.content(data);
      this.createAxis();
      this.createGraph();
      this.barContainer.insertAfter(this.graphContainer.children().eq(0));
      this.graphContainer.appendTo(this.container);
      return this.displayGraph();
    };

    Chart.prototype.content = function(data) {
      var i, pair, xValue, yValue, _i, _len, _results;
      _results = [];
      for (i = _i = 0, _len = data.length; _i < _len; i = ++_i) {
        pair = data[i];
        if (i !== 0) {
          xValue = pair[0];
          yValue = parseInt(pair[1]);
          this.xLegend.push(xValue);
          this.yLegend.push(yValue);
          if (yValue > this.chartYMax) {
            _results.push(this.chartYMax = yValue);
          } else {
            _results.push(void 0);
          }
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Chart.prototype.createAxis = function() {
      this.createYAxis();
      return this.createXAxis();
    };

    Chart.prototype.createYAxis = function() {
      var margin, step, y, yAxislist, _i, _ref;
      yAxislist = $('<ul class = "y-axis"></ul>');
      step = Math.ceil(this.chartYMax / 5);
      margin = this.marginForYCoord(step);
      for (y = _i = _ref = this.yLastValue; _ref <= 0 ? _i <= 0 : _i >= 0; y = _ref <= 0 ? ++_i : --_i) {
        if (y % step === 0) {
          $('<li>' + y + '</li>').css('margin', margin).appendTo(yAxislist);
        }
      }
      return yAxislist.appendTo(this.graphContainer);
    };

    Chart.prototype.marginForYCoord = function(step) {
      var i, margin, numberOfYCoord, _i, _ref, _ref1;
      numberOfYCoord = Math.ceil(this.chartYMax / step);
      if (this.chartYMax % 5 === 0) {
        this.yLastValue = this.chartYMax;
        margin = '0 10px 17px 10px';
      } else {
        margin = '0 10px ' + (17 + (5 - numberOfYCoord) * 10) + 'px 10px';
        for (i = _i = _ref = this.chartYMax, _ref1 = this.chartYMax + step; _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; i = _ref <= _ref1 ? ++_i : --_i) {
          if (i % step === 0) {
            this.yLastValue = i;
            break;
          }
        }
      }
      return margin;
    };

    Chart.prototype.createXAxis = function() {
      var width, x, xAxislist, _i, _len, _ref;
      width = this.graphWidth / this.xLegend.length;
      xAxislist = $('<ul class = "x-axis"></ul>');
      _ref = this.xLegend;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        x = _ref[_i];
        $('<li>' + x + '</li>').css('width', width).appendTo(xAxislist);
      }
      return xAxislist.appendTo(this.graphContainer);
    };

    Chart.prototype.createGraph = function() {
      var bar, i, pop, value, _i, _len, _ref, _results;
      _ref = this.yLegend;
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        value = _ref[i];
        bar = {};
        bar.label = value;
        bar.height = Math.floor(bar.label / this.yLastValue * 100) + '%';
        bar.div = $('<div class = "bar fig' + i + '"></div>').appendTo(this.barContainer);
        pop = $('<div class = "pop hidden">' + bar.label + '</div>').appendTo(bar.div);
        this.popUp(bar.div);
        _results.push(this.bars.push(bar));
      }
      return _results;
    };

    Chart.prototype.displayGraph = function() {
      var bar, i, marginX, marginY, width, _i, _len, _ref, _results;
      width = Math.floor(this.graphWidth / this.bars.length * 0.7);
      marginX = Math.floor(this.graphWidth / this.bars.length * 0.16);
      marginY = ((this.yLastValue - this.chartYMax) / this.yLastValue * 50) + '%';
      _ref = this.bars;
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        bar = _ref[i];
        bar.div.css({
          'background-color': this.randomColor(),
          'width': width,
          'margin': marginY + ' ' + marginX + 'px'
        });
        _results.push(bar.div.animate({
          height: bar.height
        }, 400));
      }
      return _results;
    };

    Chart.prototype.randomColor = function() {
      var color, i, letters, _i;
      letters = '0123456789ABCDEF'.split('');
      color = '#';
      for (i = _i = 0; _i < 6; i = ++_i) {
        color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
    };

    Chart.prototype.popUp = function(target) {
      return target.hover(function() {
        return $(this).find(">:first-child").removeClass('hidden');
      }, function() {
        return $(this).find(">:first-child").addClass('hidden');
      });
    };

    return Chart;

  })();

}).call(this);
