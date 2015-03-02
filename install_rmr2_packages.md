# Install rmr2 Packages
The following is taken from [rdatamining](http://www.rdatamining.com/tutorials/r-hadoop-setup-guide)  

## Install GCC, git

### Mac
__GCC__ This is installed with command line tools after the installation of xcode:

```
$ xcode-select --install
```

git git can be installed via their [download site](http://git-scm.com/downloads)

## Setting Environment Settings for R

Either run the following code in R, each time you need to do a Hadoop job:  

```
#The Hadoop installation directory
Sys.setenv("HADOOP_PREFIX"="/usr/local/hadoop/2.*")
#The location for Hadoop executable
Sys.setenv("HADOOP_CMD"="/usr/local/hadoop/2.*/bin/hadoop")
#The location of hadoop streaming jar file
Sys.setenv("HADOOP_STREAMING"="/usr/local/hadoop/2.*/share/hadoop/tools/lib/hadoop-streaming-2.*.jar") 
```

or include the following into ~/.bashrc file

```
export HADOOP_PREFIX=${HADOOP_HOME}
export HADOOP_CMD=${HADOOP_HOME}/bin/hadoop 
export HADOOP_STREAMING=${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-*.jar
```

## Install Dependent Packages

In R, run the following command:  

```
install.packages(c("rJava", "Rcpp", "RJSONIO", "bitops", "digest",
                    "functional", "stringr", "plyr", "reshape2", "dplyr",
                    "R.methodsS3", "caTools", "Hmisc", "data.table", "rjson", "bit64"))
```

The installation paths they should be in should be in `/Library/Frameworks/R.framework/Versions/3.1/Resources/library`  

If it is within a user specific account, RHadoop will likely fail.

## Install RHadoop Packages: rhdfs, rmr2, plyrmr

Download these packages from [here](https://github.com/RevolutionAnalytics/RHadoop/wiki). Then install these packages:

```
install.packages("~/Downloads/rhdfs_1.0.8.tar.gz", repos = NULL, type = "source")
install.packages("~/Downloads/rmr2_3.2.0.tar.gz", repos = NULL, type = "source")
install.packages("~/Downloads/plyrmr_0.4.0.tar.gz", repos = NULL, type = "source") 
```