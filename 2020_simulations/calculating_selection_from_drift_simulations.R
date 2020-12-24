#s = pAt*Pat+1/(Pat*PAt+1) - 1

#size p0 p1 p2 p3 p4 p5 p6 p7 p8
#size s1 s2 s3 s4 s5 s6 s7 s8 
#aggregate(by=size, fun=mean)
#plot(s)

#pi refers to allele frequency in generation i (e.g. p0 = generation 0)
#si refers to the strength of selection from generation i-1 to generation i (e.g. s1 is the strength from generation 0 to generation 1)

#simulate the random draws from a binomial
d = data.frame(size=rep(c(10,100,1000,10000), 10), p0=0.08)

for (i in c(1:8)){
  name = paste("p", i, sep="")
  d = cbind(d, p=rbinom(nrow(d), size=d$size, prob=d[,i+1])/d$size)
  colnames(d)[i+2] = name
  
}

#calculate s after each draw
s = data.frame(size=d$size)

for (i in c(1:8)){
  name = paste("s", i, sep="")
  s = cbind(s, (d[,i+2]*(1-d[,i+1]))/((1-d[,i+2])*d[,i+1]) - 1)
  colnames(s)[i+1] = name
}

#aggregate the data
a_mean = aggregate(s, by=list(s$size), FUN=mean, na.rm=T)
names(a_mean) = c("G1", "size", "mean s1", "mean s2", "mean s3", "mean s4", "mean s5", "mean s6", "mean s7", "mean s8")
a_var = aggregate(s, by=list(s$size), FUN=var, na.rm=T)
names(a_mean) = c("G1", "size", "var s1", "var s2", "var s3", "var s4", "var s5", "var s6", "var s7", "var s8")


#plot stuff
boxplot(d[,2:10], main="p over time")
boxplot(s[,2:9], main="s over time")

results = data.frame()

for (N in unique(d$size)){
  sdata = as.matrix(s[s$size==N,2:9])
  m = mean(sdata, na.rm=T)
  v = var(as.vector(sdata), na.rm=T)
  results = rbind(results, c(N, m, v))
}

names(results) = c("Pop Size", "mean s", "var s")
results = cbind(results, a_mean[,3:10])
results
     