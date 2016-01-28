import sys, numpy, scipy
import scipy.cluster.hierarchy as hier
import scipy.spatial.distance as dist
import time
import json
import subprocess
import matplotlib
matplotlib.use('Agg')

# The method list see http://docs.scipy.org/doc/scipy/reference/generated/scipy.cluster.hierarchy.linkage.html#scipy.cluster.hierarchy.linkage
method = 'complete'
# The metric list see http://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.distance.pdist.html#scipy.spatial.distance.pdist
metric = 'correlation'
# filename '00_The-Beatles_I-Saw-Her-Standing-There'
fn = sys.argv[1]

mdn = '../out/linkage/matrix'
fdn = '../out/linkage/figure'
ecode = subprocess.call('mkdir -p '+mdn, shell=True)
ecode = subprocess.call('mkdir -p '+fdn, shell=True)

print "Get the complete linkage matrix"
print 'Method: '+method+', metric: '+metric
print "Loading data ..."
t0 = time.time()
X = numpy.genfromtxt('../out/mfcc/'+fn, delimiter=',')

t1 = time.time()
spend = round(t1 - t0, 3)
print " ... "+str(spend)+" s, done"

print "Calculating the linkage ..."
Y = dist.pdist(X, metric=metric)
Z = numpy.round(hier.linkage(Y, method), 10)
t2 = time.time()
spend = round(t2 - t1, 3)
print " ... "+str(spend)+" s, done"

print "Saving the result ..."
numpy.savetxt(mdn+'/'+fn, Z, delimiter=',')
t3 = time.time()
spend = round(t3 - t2, 3)
print " ... "+str(spend)+" s, Created "+mdn+'/'+fn

print "Plotting the dendrogram ..."
hier.dendrogram(Z)
matplotlib.pyplot.savefig(fdn+'/'+fn+'.png')
t4 = time.time()
spend = round(t4 - t3, 3)
print " ... "+str(spend)+" s, Created "+fdn+'/'+fn+'.png'

