LIMIT = 5

pi-sqrt = Math.sqrt Math.PI
pi-sq   = Math.PI * Math.PI
f = [1]
g = [(1 + pi-sqrt) / 2]

for i from 1 to LIMIT
  f.push f[f.length - 1] + Math.exp(-i * i)
  g.push g[g.length - 1] + pi-sqrt * Math.exp(-1 * pi-sq * i * i)


c3.generate do
  bindto: \#plot
  data: columns:
    * <[f(x)]> ++ f
    * <[g(x)]> ++ g
