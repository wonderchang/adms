lower-bound = -5
upper-bound =  5

x = []
normal-dist  = []
entropy-dist = []
entropy = 0

for i from lower-bound to upper-bound by 0.1
  x.push i
  normal-dist.push p = (1 / Math.sqrt(2 * Math.PI)) * Math.exp(-i * i / 2)
  if p is 0 then e = 0 else e = -p * (Math.log(p) / Math.log(2))
  entropy-dist.push e
  entropy += e

c3.generate do
  bindto: \#plot-normal
  data:
    x: \x
    columns:
      * <[x]> ++ x
      * ['normal distribution'] ++ normal-dist

c3.generate do
  bindto: \#plot-entropy
  data:
    x: \x
    columns:
      * <[x]> ++ x
      * ['-p log p'] ++ entropy-dist
  color: pattern: <[#ff7f0e]>

$ \#entropy .html "Entropy = #entropy"
