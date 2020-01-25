#makes two offset histograms 
#y-values should be between 0 and 8
#x-values should be the bin for the corresponding bar to be drawn in
offset_histogram <- function(data, data_x, data2, data2_x, num_partitions_x=9, color1 = "white", color2="red", LAB="A", LAB_OFFSET=-0.5, ymax=8){
  xlims=c(0,num_partitions_x)
  ylims=c(0,ymax)
  #each bin is 1 unit wide, for reference
  width = 0.4 #width of bar
  offset = 0.25 #offset between bars
  
  #set up empty plot
  plot(c(), c(), 
       xlim=xlims, ylim=ylims, xaxt='n', yaxt='n', bty='n',
       ylab="Population frequency", 
       xlab="Consanguinity (G)")
  #plot data
  #+offset here puts bar in middle of bin
  rect(data_x+offset, 0, data_x+width+offset, data, col=color1, border="black", lwd=2)
  #plot data2
  rect(data2_x+2*offset, 0, data2_x+width+2*offset, data2, col=color2, border="black", lwd=2)
  
  #sets ticks between values on x-axis
  axis(1, at = (0:num_partitions_x), labels=FALSE, tick=TRUE, lwd=2)
  #labels the numbers on the x-axis
  axis(1, at= (0:(num_partitions_x-1))+0.5, labels=seq(0,0.5, .5/(num_partitions_x-1)), tick=FALSE)
  #build y-axis
  axis(2, at=seq(0,ymax,2),  las=1, lwd=2)
  
  mtext(LAB, at=c(LAB_OFFSET))
}

##set up panels
par(mfcol=c(3,2))

############PANEL A
data = c(0.1,0.3,0.1)*5
data_x = c(1,2,3)
data2 = c(0.2,0.4,0.1)*5
data2_x = c(2,3,4)
offset_histogram(data, data_x, data2, data2_x, 9, "white", "red", "A")

###PANEL B
data = c(0.1,0.3,0.1)*5
data_x = c(1,2,3)
data2 = c(0.2,0.4,0.1)*5
data2_x = c(2,3,4)
offset_histogram(data, data_x, data2, data2_x, 17, "white", "blue", "B", LAB_OFFSET = -0.75)

##PANEL C
plot(c(0, 1), c(0.3, 1), col="black", lwd=3, type='l', ylim=c(0,1),
     xaxt='n', yaxt='n', ylab="Percieved relatedness", xlab="Consanguinity(G)", bty='n')
points(c(0, 1), c(0.1, .8), col="blue", lwd=3, type='l')
axis(1, at=c(0, 1), labels=FALSE, lwd=2)
axis(2, at=c(0,1), labels=FALSE, lwd=2)
mtext("C", at=c(-0.05))


############PANEL D
data = c(0.1,0.3,0.1)*5
data_x = c(1,2,3)
data2 = c(0.2,0.4,0.1)*5
data2_x = c(2,3,4)
offset_histogram(data, data_x, data2, data2_x, 9, "white", "red", "D")

###PANEL E
data = c(0.1,0.3,0.1)*5
data_x = c(1,2,3)
data2 = c(0.2,0.4,0.1)*5
data2_x = c(2,3,4)
offset_histogram(data, data_x, data2, data2_x, 17, "white", "blue", "E", LAB_OFFSET = -0.75)

####PANEL F
plot(c(0, 1), c(0.3, 1), col="black", lwd=3, type='l', ylim=c(0,1),
     xaxt='n', yaxt='n', ylab="Percieved relatedness", xlab="Consanguinity(G)", bty='n')
points(c(0, 1), c(0.5, .8), col="red", lwd=3, type='l')
axis(1, at=c(0, 1), labels=FALSE, lwd=2)
axis(2, at=c(0,1), labels=FALSE, lwd=2)
mtext("F", at=c(-0.05))



