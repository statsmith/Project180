# Predict NVC




fPredict <- function(myText){
        
        dfPredict <- read.csv("dfPredict.csv", stringsAsFactors = TRUE)
        
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
                dfPredict[[i]] <- as.factor(dfPredict[[i]])
        }
      
        print(getwd())
        
        load(file = "myFit.RData")
        
        myPredict <- predict(myFit, dfPredict)

# Originally Treated as Continuous Variable,,,
        
        # myPredict <- round(predict(myFit, dfPredict),2)
        
        # dfPredict <- data.frame(Predict = myPredict, Result = 0)
        # 
        # p <- ggplot(data=dfPredict, aes(x=Predict, y=Result, label=Predict))
        # p <- p + geom_segment(aes(x=0, xend=Predict, y=Result, yend=Result), col="#1b9e77", size=5)
        # p <- p + geom_segment(aes(x=Predict, xend=1, y=Result, yend=Result), col="#d95f02", size=5)
        # # p <- p + geom_text(aes(x=0.5, y=Result), hjust=0, col="ghostwhite")
        # p <- p + theme_minimal() + ylab("")
        # p <- p + xlab(paste("Non-Violent Score = ",myPredict, "Out of 1.00"))
        # p <- p + theme(axis.text.x=element_blank(),
        #                axis.ticks.x=element_blank(),
        #                axis.text.y=element_blank(),
        #                axis.ticks.y=element_blank(),
        #                panel.grid.major = element_blank(), 
        #                panel.grid.minor = element_blank())
        # 
        # return(list(p, myPredict))
        
# Now binary...
        
        as.numeric(as.character(myPredict))
          
}
