Sys.setenv("HADOOP_PREFIX"="/usr/local/hadoop/2.5.2")
Sys.setenv("HADOOP_CMD"="/usr/local/hadoop/2.5.2/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"=
             "/usr/local/hadoop/2.5.2/share/hadoop/tools/lib/hadoop-streaming-2.5.2.jar")
library(rmr2)
library(data.table)
system('${HADOOP_CMD} fs -rm -r /user/darrellaucoin/out/')

map=function(k,lines) {
  words.list = strsplit(lines, ' ') 
  words = unlist(words.list)
  return( keyval(words, 1) ) 
}

reduce=function(word, counts) {
  keyval(word, sum(counts)) 
}

mapreduce(input='/user/darrellaucoin/input/War_and_Peace.txt',
          output='/user/darrellaucoin/out',
          input.format="text",
          map=map,
          reduce=reduce
)

count = from.dfs('/user/darrellaucoin/out')
results = as.data.table(count)
setnames(results, c('word', 'count')) 
results[order(results$count, decreasing=T), ]

