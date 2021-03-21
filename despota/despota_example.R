#example running the despota thing
#This line wont work in R studio, unless you "Source" instead of "Run"
#For this to work you need to change the below line to the full path to despota.R OR
# OR At the top menu in RStudio: Session > Set Working Directory > Source File Location
source("despota.R")

###cluster some random data
hc <- hclust(dist(USArrests)^2, "cen")
hc1 <- hclust(dist(cent)^2, method = "cen", members = table(memb))

#call despota
#there probably wont be any significant ones in here
#since the permutation and h functions are junk right now
res = despota(hc)
print("Significant nodes: ", str(res$data)) 
print("P-values: ", str(res$priorities))


res = despota(hc1)
print("Significant nodes: ", str(res$data)) 
print("P-values: ", str(res$priorities))
