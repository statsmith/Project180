# Bag of Words, N-Gram, Random Forest ... TBD

# Libraries

library(dplyr)
library(tm)
library(caret)

# library(lubridate)
# library(ggplot2)
# library(plotly)
# library(DT)
# library(stringr)
# 
# library(forcats)

# library(qdap)



# Constants

mySeed <- 19950916
set.seed(mySeed)


# Data

# For Easy Develop

myDir <- "C:\\Your\\Directory\\Here"
setwd(myDir)

myFile <- "NVCAnalysis.csv"
df1 <- tbl_df(read.csv(myFile, stringsAsFactors = FALSE)) %>% 
        select(Text, TrueFalse) %>% 
        filter(!is.na(TrueFalse))


# Clean Data

df1$Text <- gsub(pattern = '[[:punct:]]', replacement = " ", x = df1$Text)
df1$Text <- gsub("^\\s+|\\s+$", "", df1$Text)  # Trim Lead and Trail White Space From http://stackoverflow.com/questions/2261079/how-to-trim-leading-and-trailing-whitespace-in-r
df1$Text <- tolower(df1$Text)


# Document Term Matrix

myCorpus <- VCorpus(VectorSource(df1$Text))
myDTM <- DocumentTermMatrix(myCorpus)
mDTM <- as.matrix(myDTM)
mNVC <- matrix(df1$TrueFalse)
colnames(mNVC)[1] <- "TrueFalseNVC"

df2 <- data.frame(cbind(mDTM, mNVC))

# Training Data

inTrain <- createDataPartition(mNVC, p = 0.7, list = FALSE)
dfTrain <- tbl_df(df2[inTrain,])

# Test Data

dfTest <- tbl_df(df2[-inTrain,])


# Run Once to Save dfPredict

# dfPredict <- dfTest[1,]
# for(i in 1:ncol(dfPredict)){
#         dfPredict[1,i] <- 0
# }
# write.csv(dfPredict, "dfPredict.csv", row.names = FALSE)



# Random Forest

# Run Once...

# myFit <- train(TrueFalseNVC ~ ., data=dfTrain, method="rf", prox=TRUE)
# myFit

# save(myFit, file = "myFit.RData")

load(file = "myFit.RData")

myPredict <- predict(myFit, dfTest)

plot(myPredict, dfTest$TrueFalseNVC)
table(round(myPredict,0), dfTest$TrueFalseNVC)/nrow(dfTest)

# # New Text
mDTMNew <- matrix(NA, nrow=1, ncol = ncol(mDTM))
colnames(mDTMNew) <-  colnames(mDTM)
dfPredict <- tbl_df(data.frame(mDTMNew))



# Load dfPredict

read.csv("dfPredict.csv", stringsAsFactors = FALSE)

myText <- "you idiot"
myText <- gsub(pattern = '[[:punct:]]', replacement = " ", x = myText)
myText <- gsub("^\\s+|\\s+$", "", myText)  # Trim Lead and Trail White Space From http://stackoverflow.com/questions/2261079/how-to-trim-leading-and-trailing-whitespace-in-r
myText <- tolower(myText)

myWords <- unlist(strsplit(myText, " "))

for (i in 1:ncol(dfPredict)){
        if(colnames(dfPredict)[i] %in% myWords){
                dfPredict[1,i] <- 1
        } else {
                dfPredict[1,i] <- 0
        }
}

predict(myFit, dfPredict)



