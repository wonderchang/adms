$.ajax do
  url: \final/out/linkage/info/01_The-Beatles_It-Won't-Be-Long.json
  success: ->
    it = it.slice 1000
    c3.generate do
      bindto: \#diagram
      data:
        x: \cluster
        columns:
          * <[cluster]> ++ it.map -> it.cluster
          * <[distance]> ++ it.map -> it.threshold
