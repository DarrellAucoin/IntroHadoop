Sys.setenv("HADOOP_PREFIX"="/usr/local/hadoop/2.5.2")
Sys.setenv("HADOOP_CMD"="/usr/local/hadoop/2.5.2/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/usr/local/hadoop/2.5.2/share/hadoop/tools/lib/hadoop-streaming-2.5.2.jar")

library(rmr2) 
library(data.table)

#Setup variables
p = 10
num.obs = 2000
beta.true = 1:(p+1)
# Make our X matrix
X = cbind(rep(1,num.obs), matrix(rnorm(num.obs * p), ncol = p))
y = X %*% beta.true + rnorm(num.obs)
X.index = to.dfs(cbind(y, X))
rm(X, y, num.obs, p)
############################
map.XtX = function(., Xi) {
  Xi = Xi[,-1] #For the reduce phase, we need to get rid of y values in Xi
  keyval(1, list(t(Xi) %*% Xi))
}

map.Xty = function(., Xi) {
  yi = Xi[,1] # Retrieve the y values
  Xi = Xi[,-1] #For the reduce phase, we need to get rid of y values in Xi
  keyval(1, list(t(Xi) %*% yi))
}

Sum = function(., YY) {
  keyval(1, list(Reduce('+', YY)))
}
# The key here doesn't matter, as long it is is the same for every
# value

XtX = values(from.dfs(
      mapreduce(input = X.index,
        map = map.XtX,
        reduce = Sum,
        combine = TRUE)))[[1]]

Xty = values(from.dfs(
      mapreduce(
        input = X.index,
        map = map.Xty,
        reduce = Sum,
        combine = TRUE)))[[1]]
beta.hat = solve(XtX, Xty)
print(beta.hat)