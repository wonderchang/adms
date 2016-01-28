import sys, numpy, scipy
import scipy.cluster.hierarchy as hier
import json
import subprocess
from copy import *

MIN_THRESHOLD = 0

# The method list see http://docs.scipy.org/doc/scipy/reference/generated/scipy.cluster.hierarchy.linkage.html#scipy.cluster.hierarchy.linkage
method = 'complete'
# The metric list see http://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.distance.pdist.html#scipy.spatial.distance.pdist
metric = 'euclidean'
# filename '00_The-Beatles_I-Saw-Her-Standing-There'
fn = sys.argv[1]
tfn = deepcopy(fn)

src = method+'-'+metric
cdn = '../out/linkage/cluster/'+tfn
idn = '../out/linkage/info'
print cdn

e = subprocess.call('mkdir -p '+cdn, shell=True)
e = subprocess.call('mkdir -p '+idn, shell=True)

linkFn = '../out/linkage/matrix/'+fn
linkage = numpy.genfromtxt(linkFn, delimiter=',')

leaves = hier.leaves_list(linkage)
distance = linkage[:,2]
plot = []

print "Collecting each cluster result from "+src+' linkage ...'

for i in list(reversed(range(0, len(distance) - 1, 1))):
  threshold = (distance[i+1] + distance[i]) / 2
  if threshold < MIN_THRESHOLD:
    break
  cluster = hier.fcluster(linkage, threshold, criterion='distance')
  num = len(numpy.unique(cluster))
  out = { 'num': num, 'fid': leaves.tolist(), 'cluster': cluster.tolist(), 'threshold': threshold }
  fp = open(cdn+'/'+str(num)+'.json', 'w')
  fp.write(json.dumps(out))
  fp.close()
  print 'Threshold: '+str(threshold)+", "+str(num)+" clusters, created "+cdn+'/'+str(num)+'.json'
  plot.append({ 'cluster': num, 'threshold': threshold })

fp = open(idn+'/'+fn+'.json', 'w')
fp.write(json.dumps(plot))
fp.close()
print 'Create '+idn+'/'+fn+'.json'
