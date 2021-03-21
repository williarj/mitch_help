

#cluster = the hclust object you are testing for clusters
#m = the number of permutations to run at each node
#alpha = the significance value to reject H0 for a node
#h = the distance function used to estimate the height of a subtree starting at a given node
#returns a PriorityQueue where the attributes hold results for significant nodes
# result$data = a list of nodes that were significant (as dendrograms)
# result$priorities = the p-values calculated by this method
# this is an ugly way to return, change it to something better, need a node ID number or something?
despota <- function(cluster, m = 10, alpha = 0.05, h = dumb_h){
  library(liqueueR) #for PriorityQueue
  root = as.dendrogram(cluster) #make a dendrogram for traversal
  distances = cophenetic(cluster) #get the distance matrix for calculating h later... maybe?
  aggregationLevelsToVisit = PriorityQueue$new()
  detectedClusters = PriorityQueue$new()
  currentNode = root
  k = 1
  
  
  while(! pq$empty()){#this will skip the last one, but thats fine
    if (!is.leaf(currentNode)){#skips leaf nodes
     # print("CN", str(currentNode))
      test = permutation_test(currentNode, h, m) #get the significance for this node
      Lk = currentNode[[1]]
      Rk = currentNode[[2]]
      if (test <= alpha){
        detectedClusters = detectedClusters$push(currentNode, test)
      }
      else {
        aggregationLevelsToVisit$push(Lk, h(Lk))#add to list as sort according to h(Lk)
        aggregationLevelsToVisit$push(Rk, h(Rk))#add to list as sort according to h(Rk)
      }
    }
    currentNode = aggregationLevelsToVisit$pop()
    k = k + 1
  }
  detectedClusters
}

#nobs(dendrogram) -> returns the number of leaves in a subtree

#from the paper: Let h(.) be the metric
# used in the hierarchical classification process which depends on the distance
# function between two objects (i.e. Euclidean, Manhattan, etc.)and on the
# aggregation method for computing the distance between two clusters (i.e.
# Single linkage, Complete linkage, Ward method, etc.)2.
#
#that means you can change this based on your needs
#right now it just returns a random number
#TODO: MAKE THIS DO WHAT YOU WANT
dumb_h <- function(node){
  runif(1)
}

#library(pvclust)

#does a permutation test on a given subtree
#requires the 'h' distance function and 
#number of permutations to do ('m')
permutation_test <- function(node, h, m){
  library(seriation)
  root = node
  
  #at a leaf node, no permutations to do
  if(is.leaf(root) || is.null(root)){
    print("GOT A NULL OR LEAF NODE")
    return (NA)#hopefully this never happens
  }
  
  Lm = node[[1]]
  RM = node[[2]]
  
  true_r = calculate_rck(root, Lm, Rm, h)
  r_distribution = c()
  for (i in c(1:m)){
    #permute across Lk and Rk, preserving cardinality of clusters
    #this doesn't do that right now, just a totally random permutation
    current_permutation = permute_subtree(root)
    Lm = current_permutation[[1]]#left child
    Rm = current_permutation[[2]]#right child
    
    #might affect h(node) used by calculate_rck
    r = calculate_rck(current_permutation, Lm, Rm, h)
    r_distribution = c(r_distribution, r)
  }
  
  p = sum(r_distribution<=true_r)
  return(p)
}

#This takes a tree and permutes it
#should swap nodes around and end up with the same
#number on the left and right of the root as the base tree
#TODO:MAKE THIS DO WHAT YOU WANT
permute_subtree <- function(dendrogram){
  #this needs to keep the number of kids in the left
  #and rigth subtrees the same as they start
  #this is wrong right now
  p = dendrogram#permute(dendrogram, sample(nobs(dendrogram))) #this permute currently breaks
  return(p)
}

#calculates the 'clustering cost' of a given tree topology
calculate_rck <- function(root, Lk, Rk, h){
  r = abs(h(Lm) - h(Rm))/(h(node) - min(h(Lm), h(Rm)))
  if (is.na(r))##FOR TESTING ONLY
    r = 1
  return(r)
}
