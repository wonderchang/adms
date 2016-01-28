$.ajax({
  url: 'final/out/linkage/info/01_The-Beatles_It-Won\'t-Be-Long.json',
  success: function(it){
    it = it.slice(1000);
    return c3.generate({
      bindto: '#diagram',
      data: {
        x: 'cluster',
        columns: [
          ['cluster'].concat(it.map(function(it){
            return it.cluster;
          })), ['distance'].concat(it.map(function(it){
            return it.threshold;
          }))
        ]
      }
    });
  }
});