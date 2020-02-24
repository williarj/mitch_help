at <- data.frame(group = c(1:8), trait1 = rlnorm(200, 0, 1), trait2 = rlnorm(200, 0, 1))

ranks = rank(at$trait1)#ranks all values by trait1
my_cols = colors(10)#this will pick some ugly colors
val_cols = my_cols[as.numeric(cut(ranks, breaks=10))]#sets the color of each point based on its rank


plot(at$group, at$trait1, pch=20, col=val_cols)
points(at$group+0.25, at$trait2, pch=20, col=val_cols)#trait2 is oddset to the right  abit
