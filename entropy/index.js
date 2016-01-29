var lowerBound, upperBound, x, normalDist, entropyDist, entropy, i$, i, p, e;
lowerBound = -5;
upperBound = 5;
x = [];
normalDist = [];
entropyDist = [];
entropy = 0;
for (i$ = lowerBound; i$ <= upperBound; i$ += 0.1) {
  i = i$;
  x.push(i);
  normalDist.push(p = (1 / Math.sqrt(2 * Math.PI)) * Math.exp(-i * i / 2));
  if (p === 0) {
    e = 0;
  } else {
    e = -p * (Math.log(p) / Math.log(2));
  }
  entropyDist.push(e);
  entropy += e;
}
c3.generate({
  bindto: '#plot-normal',
  data: {
    x: 'x',
    columns: [['x'].concat(x), ['normal distribution'].concat(normalDist)]
  }
});
c3.generate({
  bindto: '#plot-entropy',
  data: {
    x: 'x',
    columns: [['x'].concat(x), ['-p log p'].concat(entropyDist)]
  },
  color: {
    pattern: ['#ff7f0e']
  }
});
$('#entropy').html("Entropy = " + entropy);