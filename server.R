# Project 180

# Libraries ====

        library(shiny)
        library(shinyjs)
        library(shinydashboard)
        library(dplyr)
        library(ggplot2)
        library(DT)
        library(leaflet)
        library(tm)
        library(caret)
        library(randomForest)


# Constants ====

        myFile <- "NVCAnalysis.csv"
        dfParticipants <- read.csv(file = "Participants.csv", stringsAsFactors = FALSE, colClasses = c("numeric","numeric", "character"))
        dfParticipants$date <- as.Date(dfParticipants$date, format="%Y-%m-%d") # Read Directly as Date...

# Functions ====

        source("fPredict.R")

# Data ====

        df1 <- tbl_df(read.csv(myFile, stringsAsFactors = FALSE))
        
# Server

shinyServer(function(input, output, session){
       
        myRV <- reactiveValues(dfParticipants = dfParticipants, iJoined = 0)
        
# User Flow ====
        
        
        
# Observation vs Evaluation ====
        
        callModule(quiz, "Observation", df = df1, myCategory = "Observation")
        callModule(quiz, "Feeling", df = df1, myCategory = "Feeling")
        callModule(quiz, "Need", df = df1, myCategory = "Need")
        callModule(quiz, "Request", df = df1, myCategory = "Request")
        
        
# Leaflet Map ====
        
        output$myMap <- renderLeaflet({
                
                # dfParticipants <- read.csv(file = "Participants.csv", stringsAsFactors = FALSE, colClasses = c("numeric","numeric", "character"))
                
                # Use leaflet() here, and only include aspects of the map that
                # won't need to change dynamically (at least, not unless the
                # entire map is being torn down and recreated).
                leaflet(data = myRV$dfParticipants) %>% 
                        # addProviderTiles("CartoDB.Positron") %>% 
                        addTiles() %>%
                        addCircleMarkers(radius = 5) # %>% 
                        # addPopups(lng = ~lng, lat = ~lat, ~as.character(ID))
        })
        
        observeEvent(input$myMap_click,{
                
                req(myRV$iJoined == 0)
                
                dfTemp <- data.frame(lat = input$myMap_click$lat, lng = input$myMap_click$lng, date = Sys.Date())

                myRV$dfParticipants <- bind_rows(myRV$dfParticipants, dfTemp)
                myRV$dfParticipants <- myRV$dfParticipants %>% filter(!is.na(date) & date > "2016-10-18") # Modify on Launch
                write.csv(x = myRV$dfParticipants, file = "Participants.csv", row.names = FALSE)
                
                leafletProxy("myMap", data = myRV$dfParticipants) %>%
                        clearShapes() %>%
                        addCircles() %>%
                        addCircleMarkers(data = dfTemp, lng = ~lng, lat = ~lat, color = rgb(217, 95, 2, maxColorValue = 255))
                
                myRV$iJoined <- 1
                
        })
        
        output$pTime <- renderPlot({
                
                totalPledges <- nrow(myRV$dfParticipants)
                
                dfPlot <- myRV$dfParticipants %>% 
                        group_by(date) %>% 
                        arrange(date) %>% 
                        summarise(N = n()) %>% 
                        mutate(Total = cumsum(N))
                
                p <- ggplot(dfPlot, aes(x=date, y=Total))
                p <- p + geom_line(col=rgb(31,120, 180, maxColorValue = 255), size=1)
                p <- p + theme_minimal() + ylab("Total Participants") + xlab("")
                p <- p + theme(text = element_text(size=15))
                p <- p + expand_limits(y=0)
                p

        })
        
        # output$myPredict <- renderPlot({  # Originally Continuous,,,
        #         
        #         req(input$myText)
        #         
        #         myPredict <- fPredict(input$myText)
        #         myPredict[[1]]
        #         
        # })
        
        output$myPredict <- renderInfoBox({
                
                req(input$myText)
                
                myPredict <- fPredict(input$myText)
                
                if(myPredict == 0){
                       
                        infoBox(
                                "Oops!",
                                "Probably Not NVC - Try Again!",
                                icon = icon("thumbs-down"),
                                color = "orange"
                        )
                         
                } else {
                        infoBox(
                                "Hurray!",
                                "Looks Good!",
                                icon = icon("thumbs-up"),
                                color = "green"
                        ) 
                }
        }) 
                
                
#         output$test <- renderPrint({
#                 print(input$myMap_click)
#         })
        
       
        
})
        
        
        
        
        
        

# 