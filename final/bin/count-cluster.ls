require! <[fs]>

#data = JSON.parse fs.read-file-sync '../out/linkage/cluster/01_The-Beatles_It-Wont-Be-Long/500.json'
data = JSON.parse fs.read-file-sync '../out/linkage/cluster/30_Michael-Jackson_Bad/500.json'
#data = JSON.parse fs.read-file-sync '../out/linkage/cluster/31_Michael-Jackson_Black-Or-White/500.json'
console.log 'threshold = '+data.threshold

hash = {}; for c in data.cluster then if hash[c] is undefined then hash[c] = 1 else hash[c]++
count = []; for k, v of hash then count.push cluster: k, value: v
count = count.sort (a, b) -> b.value - a.value

out = []
for cnt in count
  break if cnt.value < 5
  arr = []
  for c, i in data.cluster then if c is parseInt cnt.cluster then arr.push i
  arr = arr.sort (a, b) -> a - b
  arr = arr.map -> it / 100
  period = []; tmp = [arr.0]
  for a, i in arr.slice 1 then if 0.5 > a - tmp[tmp.length - 1] then tmp.push a else period.push tmp; tmp = [a]
  out.push c: cnt.cluster, d: period.map -> [it.0, it[it.length - 1]].to-string!

out.sort (a, b) -> (parseFloat a.d.0) - parseFloat b.d.0
for o, i in out then if 1 < o.d.length <= 5 then console.log i, (o.d * ', ')
