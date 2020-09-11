#!/bin/sh

######You can just type commands as you would run them in the terminal here
let REPLICATES=5 #number of replicates to run, each replicate will have one of each treatment
let i=0

mkdir output #makes an output folder
#this script will OVERWRITE old output in the output folder if you re-run it

# ((i=1;i<REPLICATES;i++));
while ((i<REPLICATES));
do
 echo "Doing run $i"
 #runs a "control" simulation, mean = 5.5, variance = 2.1, for 10 focal males
 #probability of all interactions is the same
 #normal distirbution  
 Rscript guppy_simulation.R 5.5 2.1 10 output/control_${i}.csv -p 1 1 1 1 1 -d rnorm -l Control
 
 #runs a Treatment1 simulation, mean = 10, variance = 5, for 10 focal males
 #interactions with r = 0.375 and r= 0.5 are higher
 #lognormal distribution
 Rscript guppy_simulation.R 10 5 1 output/treatment1_${i}.csv -p 1 1 1 2 2 -d rlnorm -l Treatment1

 #runs a Treatment2 simulation, mean = 10, variance = 10, for 10 focal males
 #interactions for r=0 are triple the others
 # normal distribution
 Rscript guppy_simulation.R 10 10 10 output/treatment2_${i}.csv -p 3 1 1 1 1 -d rnorm -l Treatment2

 #this code will combine the output from the three treatments into one CSV for analysis
 #This CAN break if the simulations are slow
 #you should always verify that the "replicate" files have the correct number of lines
 head -1 control_${i}.csv > output/replicate_${i}.csv

 tail -n +2 -q output/control_${i}.csv >> output/replicate_${i}.csv 
 tail -n +2 -q output/treatment1_${i}.csv >> output/replicate_${i}.csv 
 tail -n +2 -q output/treatment2_${i}.csv >> output/replicate_${i}.csv 

 let i++

done


#If you uncomment this line it will auto delete all the control/treatment intermediate csv's and only leave you with the final "replicate" csv's
#if you want to keep them then just leave this commented
#rm output/control* output/treatment* 

