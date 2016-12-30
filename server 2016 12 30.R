# Project 2016

# Libraries ====

        library(shiny)
        library(shinyjs)
        library(shinydashboard)
        library(dplyr)
        library(ggplot2)
        library(DT)
        library(leaflet)


# Constants ====

        myFile <- "NVCAnalysis.csv"
        dfParticipants <- read.csv(file = "Participants.csv", stringsAsFactors = FALSE, colClasses = c("numeric","numeric", "character"))
        dfParticipants$date <- as.Date(dfParticipants$date, format="%Y-%m-%d") # Read Directly as Date...

# Functions ====

        # source("Module Quiz.R")

# Data ====

        df1 <- tbl_df(read.csv(myFile, stringsAsFactors = FALSE))
        
# Server

shinyServer(function(input, output, session){
       
        myRV <- reactiveValues(dfParticipants = dfParticipants)
        
# User Flow ====
        
#         observeEvent(input$linkWelcome,{
#                 shinyjs::toggle(id = "divWelcome", anim = FALSE)
#         })
        
        observeEvent(input$linkBackground,{
                shinyjs::show(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
#         observeEvent(input$linkAskYourself,{
#                 shinyjs::hide(id = "divBackground", anim = FALSE)
#                 # shinyjs::show(id = "divAskYourself", anim = FALSE)
#                 shinyjs::hide(id = "divMainIdeas", anim = FALSE)
#                 # shinyjs::hide(id = "divWhatIf", anim = FALSE)
#                 shinyjs::hide(id = "divGrowth", anim = FALSE)
#                 shinyjs::hide(id = "divObsVsEval", anim = FALSE)
#                 shinyjs::hide(id = "divFeeling", anim = FALSE)
#                 shinyjs::hide(id = "divNeed", anim = FALSE)
#                 shinyjs::hide(id = "divRequest", anim = FALSE)
#                 shinyjs::hide(id = "divParticipate", anim = FALSE)
#                 shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
#                 shinyjs::hide(id = "divResources", anim = FALSE)
#         })
        
        observeEvent(input$linkMainIdeas,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::show(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
#         observeEvent(input$linkWhatIf,{
#                 shinyjs::hide(id = "divBackground", anim = FALSE)
#                 # shinyjs::hide(id = "divAskYourself", anim = FALSE)
#                 shinyjs::hide(id = "divMainIdeas", anim = FALSE)
#                 # shinyjs::show(id = "divWhatIf", anim = FALSE)
#                 shinyjs::hide(id = "divGrowth", anim = FALSE)
#                 shinyjs::hide(id = "divObsVsEval", anim = FALSE)
#                 shinyjs::hide(id = "divFeeling", anim = FALSE)
#                 shinyjs::hide(id = "divNeed", anim = FALSE)
#                 shinyjs::hide(id = "divRequest", anim = FALSE)
#                 shinyjs::hide(id = "divParticipate", anim = FALSE)
#                 shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
#                 shinyjs::hide(id = "divResources", anim = FALSE)
#         })
        
        observeEvent(input$linkGrowth,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::show(id = "divWhatIf", anim = FALSE)
                shinyjs::show(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkObsVsEval,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::show(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkFeeling,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::show(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkNeed,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::show(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkRequest,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::show(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkParticipate,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::show(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkParticipate,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::show(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkTextAnalysis,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::show(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkResources,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::show(id = "divResources", anim = FALSE)
                shinyjs::hide(id = "divHelp", anim = FALSE)
        })
        
        observeEvent(input$linkHelp,{
                shinyjs::hide(id = "divBackground", anim = FALSE)
                # shinyjs::hide(id = "divAskYourself", anim = FALSE)
                shinyjs::hide(id = "divMainIdeas", anim = FALSE)
                # shinyjs::hide(id = "divWhatIf", anim = FALSE)
                shinyjs::hide(id = "divGrowth", anim = FALSE)
                shinyjs::hide(id = "divObsVsEval", anim = FALSE)
                shinyjs::hide(id = "divFeeling", anim = FALSE)
                shinyjs::hide(id = "divNeed", anim = FALSE)
                shinyjs::hide(id = "divRequest", anim = FALSE)
                shinyjs::hide(id = "divParticipate", anim = FALSE)
                shinyjs::hide(id = "divTextAnalysis", anim = FALSE)
                shinyjs::hide(id = "divResources", anim = FALSE)
                shinyjs::show(id = "divHelp", anim = FALSE)
        })
        
        delay(500, 
              shinyjs::show(id = "divChange", anim = TRUE, animType = "fade")
        )
        
        delay(1500, 
              shinyjs::show(id = "divConversation", anim = TRUE, animType = "fade")
        )
        
        delay(2500, 
              shinyjs::show(id = "divAskYourself", anim = TRUE, animType = "fade")
        )
        
        
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
                        addTiles() %>% 
                        addCircles() # %>% 
                        # addPopups(lng = ~lng, lat = ~lat, ~as.character(ID))
        })
        
        observeEvent(input$myMap_click,{
                
                # dfParticipants <- read.csv(file = "Participants.csv", stringsAsFactors = FALSE, colClasses = c("numeric","numeric", "character"))
                # dfParticipants$date <- as.Date(dfParticipants$date, format="%Y-%m-%d")
                
                dfTemp <- data.frame(lat = input$myMap_click$lat, lng = input$myMap_click$lng, date = Sys.Date())
#                 dfParticipants <- bind_rows(dfParticipants, dfTemp)
#                 dfParticipants <- dfParticipants %>% filter(!is.na(date) & date > "2016-11-18") # Modify on Launch
#                 write.csv(x = dfParticipants, file = "Participants.csv", row.names = FALSE)
                
                myRV$dfParticipants <- bind_rows(myRV$dfParticipants, dfTemp)
                myRV$dfParticipants <- myRV$dfParticipants %>% filter(!is.na(date) & date > "2016-10-18") # Modify on Launch
                write.csv(x = myRV$dfParticipants, file = "Participants.csv", row.names = FALSE)
                
                leafletProxy("myMap", data = myRV$dfParticipants) %>%
                        clearShapes() %>%
                        addCircles() %>%
                        addCircleMarkers(data = dfTemp, lng = ~lng, lat = ~lat, color = rgb(217, 95, 2, maxColorValue = 255))
                
        })
        
        output$pTime <- renderPlot({
                
                totalPledges <- nrow(myRV$dfParticipants)
                
                dfPlot <- myRV$dfParticipants %>% 
                        group_by(date) %>% 
                        arrange(date) %>% 
                        summarise(N = n()) %>% 
                        mutate(Total = cumsum(N))
                        
                p <- ggplot(dfPlot, aes(x=date, y=Total))
                p <- p + geom_line(col=rgb(31,120, 180, maxColorValue = 255), size=1.5)
                p <- p + theme_minimal() + ylab("Total Participants") + xlab("")
                p <- p + theme(text = element_text(size=18))
                p <- p + ggtitle(paste(totalPledges, "Total Pledges as of", as.character(Sys.Date())))
                p

        })
       
        
#         output$test <- renderPrint({
#                 print(input$myMap_click)
#         })
        
       
        
})
        
        
        
        
        
        

# 