var N, domain, tick, X, x, Y, chart, sF, sP, p, sampling, res$, i$, to$;
N = Math.pow(10, 3);
domain = {
  min: 0,
  max: 40
};
domain.diff = domain.max - domain.min;
tick = (domain.max - domain.min) / N;
X = (function(){
  var i$, to$, results$ = [];
  for (i$ = 0, to$ = N; i$ <= to$; ++i$) {
    x = i$;
    results$.push(x);
  }
  return results$;
}()).map(function(it){
  return domain.min + it * tick;
});
Y = X.map(function(it){
  return Math.cos(it * Math.PI);
});
chart = c3.generate({
  bindto: '#signal-chart',
  data: {
    type: 'spline',
    xs: {
      signal: 'signal-x',
      sample: 'sample-x'
    },
    columns: [
      ['signal-x'].concat(X.map(function(it){
        return round(it * Math.PI);
      })), ['signal'].concat(Y)
    ]
  }
});
sF = {
  max: 2,
  min: 0.03125
};
$('#s-f-min').html(sF.min + '&pi;');
$('#s-f-max').html('&nbsp;' + sF.max + '&pi;');
sF.diff = sF.max - sF.min;
sP = sF.min + sF.diff;
$('#samp-peri span').text(p = round(sP));
$('#samp-freq span').html("1/" + p + "&pi; Hz = " + round((1 / (p * Math.PI)) / (1 / (2 * Math.PI))) + " fm");
res$ = [];
for (i$ = domain.min, to$ = domain.max; sP < 0 ? i$ >= to$ : i$ <= to$; i$ += sP) {
  x = i$;
  res$.push({
    x: x * Math.PI,
    y: Math.cos(x * Math.PI)
  });
}
sampling = res$;
chart.load({
  columns: [
    ['sample-x'].concat(sampling.map(function(it){
      return round(it.x);
    })), ['sample'].concat(sampling.map(function(it){
      return it.y;
    }))
  ]
});
$('#adjust').change(function(){
  var p, sampling, res$, i$, to$, x;
  sP = sF.min + sF.diff * this.value / 100;
  $('#samp-peri span').text(p = round(sP));
  $('#samp-freq span').html("1/" + p + "&pi; Hz = " + round((1 / (p * Math.PI)) / (1 / (2 * Math.PI))) + " fm");
  res$ = [];
  for (i$ = domain.min, to$ = domain.max; sP < 0 ? i$ >= to$ : i$ <= to$; i$ += sP) {
    x = i$;
    res$.push({
      x: x * Math.PI,
      y: Math.cos(x * Math.PI)
    });
  }
  sampling = res$;
  return chart.load({
    columns: [
      ['sample-x'].concat(sampling.map(function(it){
        return round(it.x);
      })), ['sample'].concat(sampling.map(function(it){
        return it.y;
      }))
    ]
  });
});
function round(it){
  return Math.round(1000 * it) / 1000;
}