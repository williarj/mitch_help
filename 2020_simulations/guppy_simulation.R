#================INPUTS THAT YOU MIGHT NEED TO CHANGE======================
#read in a csv listing: Treatment, Male ID, Mean Behaviors, Variance Behaviors, in that order, should have a header
input_file = "/Users/williarj/Documents/science/mitch_help/2020_simulations/sample_sim_input.csv"
output_file = "/Users/williarj/Documents/science/mitch_help/2020_simulations/out.csv"
#the probabilities of interacting with each of the 5 rivals
probs = c(1/5, 1/5, 1/5, 1/5, 1/5)
#'m being lazy here, so if you want different distributions just run this again on a different set of inputs and change the distribution
sampling_dist = rnorm #Change this to rlnorm if you want lognormal, or any distribution that takes a mean and sd as input


library(argparser)

#reads in command line arguments if run as an Rscript
if (interactive() == FALSE){
  p = arg_parser("Male behavior simulator")
  p = add_argument(p, "input_file", help="A csv listing: Treatment, Male ID, Mean Behaviors, Variance Behaviors, in that order, should have a header.")
  p = add_argument(p, "output_file", help="The name of the csv output file to produce.")
  p = add_argument(p, "--probs", help="The probabilities of interacting with each of the 5 rivals. These are normalized, so they do not need to sum to 1.", nargs=5)
  p = add_argument(p, "--dist", help="The name of the sampling distribution to pull number of behaviors from (e.g. rnorm, rlnorm), bust be a distribution with a mean and sd argument.")
  argv = parse_args(p)

  #sets up the command line-provided input
  input_file = argv$input_file
  output_file = argv$output_file
  if (length(argv$probs)>1) probs = argv$probs
  if (!is.na(argv$dist)) sampling_dist = argv$dists
  
  print(probs)
}




#================CODE STUFF===================
input = read.csv(input_file, header=T)
names(input) = c("Treatment", "ID", "Mean", "Variance")
relatedness = c(0, 0.125, 0.25, 0.375, 0.5) #rival relateness values for output

#for each male sample the number of behaviors from a normal
#TODO: change distribution for each treatment
#Round to the nearest integer
#note, that this makes 0's less likely than they should be, floor would avoid this
#the 'pmax' here ensures that all values are 0 or higher
sampled_behaviors = pmax(0, round(do.call(sampling_dist, args=list(nrow(input),input$Mean, input$Variance))))


#for each resulting sample sample from a multinomial to see how many interactions happened with each male
sampling <- function(behaviors){
  rmultinom(1, size = behaviors, prob=probs)
}
allocated_behaviors = lapply(sampled_behaviors, sampling)
allocated_behaviors = as.vector(do.call(rbind, allocated_behaviors)) #this turns all the lists into one big vector

#output the CSV with Treatment, Male ID, Relatedness (this is effectively rival male ID), Num behaviors
#set up the base dataframe
output_base = data.frame(Treatment = rep(input$Treatment, each = 5), ID=rep(input$ID, each=5), Relatedness=relatedness, Num_Behaviors = allocated_behaviors)
write.csv(output_base, output_file, row.names=FALSE)
