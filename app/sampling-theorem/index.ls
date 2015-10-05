N = Math.pow 10, 3
domain = min: 0, max: 40
domain.diff = domain.max - domain.min
tick = (domain.max - domain.min) / N
X = (for x to N then x).map -> domain.min + it * tick
Y = X.map -> Math.cos it * Math.PI

chart = c3.generate do
  bindto: \#signal-chart
  data:
    type: \spline
    xs:
      signal: \signal-x
      sample: \sample-x
    columns:
      * <[signal-x]> ++ X.map -> round it * Math.PI
      * <[signal]> ++ Y

s-f = max: 2, min: 0.03125
$ \#s-f-min .html s-f.min+'&pi;'
$ \#s-f-max .html '&nbsp;'+s-f.max+'&pi;'
s-f.diff = s-f.max - s-f.min
s-p = s-f.min + s-f.diff
$ '#samp-peri span' .text p = round s-p
$ '#samp-freq span' .html "1/#p&pi; Hz = #{round (1/(p*Math.PI))/(1/(2*Math.PI))} fm"
sampling = for x from domain.min to domain.max by s-p
  x: x * Math.PI
  y: Math.cos x * Math.PI
chart.load do
  columns:
    * <[sample-x]> ++ sampling.map -> round it.x
    * <[sample]> ++ sampling.map -> it.y

$ \#adjust .change ->
  s-p := s-f.min + s-f.diff * this.value / 100
  $ '#samp-peri span' .text p = round s-p
  $ '#samp-freq span' .html "1/#p&pi; Hz = #{round (1/(p*Math.PI))/(1/(2*Math.PI))} fm"
  sampling = for x from domain.min to domain.max by s-p
    x: x * Math.PI
    y: Math.cos x * Math.PI
  chart.load do
    columns:
      * <[sample-x]> ++ sampling.map -> round it.x
      * <[sample]> ++ sampling.map -> it.y

function round then (Math.round 1000 * it) / 1000
