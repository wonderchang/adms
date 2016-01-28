var LIMIT, piSqrt, piSq, f, g, i$, i;
LIMIT = 5;
piSqrt = Math.sqrt(Math.PI);
piSq = Math.PI * Math.PI;
f = [1];
g = [(1 + piSqrt) / 2];
for (i$ = 1; i$ <= LIMIT; ++i$) {
  i = i$;
  f.push(f[f.length - 1] + Math.exp(-i * i));
  g.push(g[g.length - 1] + piSqrt * Math.exp(-1 * piSq * i * i));
}
c3.generate({
  bindto: '#plot',
  data: {
    columns: [['f(x)'].concat(f), ['g(x)'].concat(g)]
  }
});