# Network Game

library(ndtv)
library(network)
library(networkDynamic)

data(short.stergm.sim)
short.stergm.sim 
head(as.data.frame(short.stergm.sim))

render.d3movie(short.stergm.sim, displaylabels=TRUE) 

# Create ====

myDir <- "C:/Users/HFDSS103/OD/Shared with Me/Misc/Project180"
setwd(myDir)


nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

net3 <- network(links,  vertex.attr=nodes, matrix.type="edgelist", 
                loops=F, multiple=F, ignore.eval = F)

net3 %v% "media.type"
net3 %v% "col" <- c("gray70", "tomato", "gold")[net3 %v% "media.type"]


vs <- data.frame(onset=0, terminus=50, vertex.id=1:17)
es <- data.frame(onset=1:52, terminus=rep(52,52), 
                 head=as.matrix(net3, matrix.type="edgelist")[,1],
                 tail=as.matrix(net3, matrix.type="edgelist")[,2])

net3.dyn <- networkDynamic(base.net=net3, edge.spells=es, vertex.spells=vs)

plot(net3.dyn, vertex.cex=(net3 %v% "audience.size")/7, vertex.col="green")

filmstrip(net3.dyn, displaylabels=F, mfrow=c(1, 5),
          slice.par=list(start=0, end=49, interval=10, 
                         aggregate.dur=10, rule='any'))




# My Network ====

library(dplyr)
library(tidyr)
library(ndtv)
library(network)
library(networkDynamic)



nNodes <- 5 # Total playas
nLinks <- 3 # Average links per node
myNVC0 <- 0.1 # Percent NVCers at Time 0
myProb <- 0.5 # Likelihood convert node to NVC
myTerminus <- 10 # Number of Iterations (Terminus)
# myVersions <- 10 
# myIterations <- 10

# Starting Conditions ====

        myNodes <- tbl_df(data.frame(
                id = seq(1, nNodes, 1),
                NVC = floor(runif(nNodes, min = 0, max = 1 + myNVC0)),
                onset = 0, terminus = myTerminus
        ))
        
        myLinks <- tbl_df(data.frame(
                from  = sample(myNodes$id, size = nNodes * nLinks, replace = TRUE),
                to = sample(myNodes$id, size = nNodes * nLinks, replace = TRUE)
        ))

        myLinks <- left_join(myLinks, myNodes, by = c("from" = "id")) %>% unique()


# Iterations ====

# Do NVC
        
        for (i in 1:myTerminus){
                
                # Find Out Who's Doing NVC
                myNVCNodes <- myNodes %>% filter(NVC == 1)
                myNVCNodes <- myNVCNodes$id
                
                
                
                # ID Potential Links / Influence
                myNVCLinks <- myLinks %>% filter(from %in% myNVCNodes)
                
                # Assign Random Prob of Convert to NVC
                myNewNVCLinks <- myNVCLinks %>% 
                        mutate(convert = runif(n())) %>% 
                        mutate(NVC = ifelse(convert < myProb, 1, 0)) %>% 
                        filter(NVC == 1) %>% 
                        select(-convert) %>% 
                        distinct()
                
                myNewNVCNodes <- unique(myNewNVCLinks$to)
                myNewNVCNodes <- myNewNVCNodes[!myNewNVCNodes %in% myNVCNodes]
                
                
                
                # Update New NVC Nodes
                
                if(length(myNewNVCNodes) > 0){
                        
                        myNodes <- 
                                myNodes %>%     
                                mutate(terminus = ifelse(id %in% myNewNVCNodes, i, terminus)) %>%  # i from do loop...
                                bind_rows(tbl_df(data.frame(id = myNewNVCNodes, NVC = 1, onset = i, terminus = myTerminus)))  
                        
                        
                        
                        # Update New NVC Links
                        
                        myLinks <- myLinks %>% 
                                mutate(terminus = ifelse(from %in% myNewNVCNodes, i, terminus)) %>%  # i from do loop...
                                bind_rows(myNewLinks <- myLinks %>% 
                                                  filter(from %in% myNewNVCNodes) %>% 
                                                  mutate(NVC = 1, onset = i, terminus = myTerminus)
                                )
                }
                
        }
        
# End Repeat

myNet <- network(myLinks,  vertex.attr=myNodes, matrix.type="edgelist", 
                loops=F, multiple=F, ignore.eval = F)
myNet[,]

myNet %v% "NVC"
myNet %e% "NVC"

myNet %v% "col" <- c("green", "blue", "green", "green", "green")
myNet %v% "col" <- c("green", "blue")[myNet %v% "NVC"]
myNet %v% "col"

plot(myNet, vertex.col="col")

# vs <- data.frame(onset=0, terminus=myTerminus, vertex.id=1:nNodes)
# 
# es <- data.frame(onset=0, terminus=sample(1:10, nNodes, replace = TRUE), 
#                  head=as.matrix(myNet, matrix.type="edgelist")[,1],
#                  tail=as.matrix(myNet, matrix.type="edgelist")[,2])



# myNetDyn <- networkDynamic(base.net=myNet, )
# myNetDyn <- networkDynamic(base.net=myNet, edge.spells=es, vertex.spells=vs)
myNetDyn <- networkDynamic(base.net=myNet, edge.spells=as.matrix(myLinks[,c(1,2,4,5)]), vertex.spells=as.matrix(myNodes[,c(1,3,4)]))


plot(myNetDyn, vertex.cex=(myNet %v% "NVC"), vertex.col="green")


filmstrip(myNetDyn, displaylabels=F, mfrow=c(2, 5),
          slice.par=list(start=0, end=myTerminus, interval=1, 
                         aggregate.dur=1, rule='any'))



render.d3movie(myNetDyn, displaylabels=FALSE) 


# More Learning ====


triangle <- network.initialize(3) # create a toy network
add.edge(triangle,1,2) # add an edge between vertices 1 and 2
add.edge(triangle,2,3) # add a more edges

activate.edges(triangle,at=1) # turn on all edges at time 1 only
activate.edges(triangle,onset=2, terminus=3,
                 e=get.edgeIDs(triangle,v=1,alter=2))
add.edges.active(triangle,onset=4, length=2,tail=3,head=1)


plot(triangle)

as.data.frame.networkDynamic(triangle)
df1 <- as.data.frame.networkDynamic(triangle)
networkDynamic(df1)


myNetwork <- network.initialize(2) # Starting Network




library(dplyr)

df2 <- df1 %>% select(onset, terminus, tail, head)


# read in tab-delimited example input file
# timeData<-read.csv(inputFile,sep = "\t",stringsAsFactors = FALSE)
# check that it was loaded correctly
timeData <- df2

# convert the date formats into a numeric time (milliseconds)
# timeData$onset<-as.numeric(as.POSIXct(timeData$onset,format='%m/%d/%Y'))
# timeData$terminus<-as.numeric(as.POSIXct(timeData$terminus,format='%m/%d/%Y'))

# create a table of email address to map to numeric ids
emails<-unique(c(timeData$head,timeData$tail))

#covert ids
timeData$head<- match(timeData$head,emails)
timeData$tail<- match(timeData$tail,emails)

# convert to networkDynamic object
enronDyn<-networkDynamic(edge.spells=timeData)

render.d3movie(enronDyn, displaylabels=FALSE) 

# 
# # copy in the network names
# network.vertex.names(enronDyn)<-emails
# 
# # load ndtv library
# library(ndtv)
# 
# # compute the animation at 30-day interval
# compute.animation(enronDyn,slice.par=list(start=967705200,end=989305200,interval=2592000,aggregate.dur=2592000,rule='latest'))
# # render out the animation
# render.animation(enronDyn)
# ani.replay()


