# Quiz Module

# Inputs
        



# UI ====

quizInput <- function(id, buttonLabel1, buttonLabel0, buttonLabelNext) {

        ns <- NS(id)
        
        tagList(
               
                inlineCSS(list(.Correct = "color: #1b9e77", .Oops = "color: #d95f02")),
                
                column(width=6,
                       uiOutput(ns("myText")),
                       tags$br(),
                       actionButton(inputId = ns("button1"), label = buttonLabel1),
                       actionButton(inputId = ns("button0"), label = buttonLabel0),
                       actionButton(inputId = ns("buttonNext"), label = buttonLabelNext),
                       plotOutput(ns("pResults"), height = 100)
                ),
                
                column(width=6,
                       tags$br(), tags$br(),
                       shinyjs::hidden(
                               div(id=ns("divExplain"),
                                   uiOutput(ns("mySurveySays")),
                                   uiOutput(ns("myExplain"))
                               )
                       )
                )
        )
}


# Server ====

quiz <- function(input, output, session, df, myCategory) {
       
        myModuleRV <- reactiveValues(surveySays = "", df = NULL, myCorrect = 0, myOops = 0)
        
        myModuleRV$df <- df %>% 
                filter(Category == myCategory) %>% 
                sample_n(1)
        
        observeEvent(input$button1,{
                
                if(myModuleRV$df$TrueFalse == 1){
                        shinyjs::removeClass("mySurveySays", "Oops")
                        shinyjs::addClass("mySurveySays", "Correct")
                        shinyjs::removeClass("myExplain", "Oops")
                        shinyjs::addClass("myExplain", "Correct")
                        myModuleRV$surveySays <- "Correct!"
                        myModuleRV$myCorrect <- myModuleRV$myCorrect + 1
                        
                } else {
                        shinyjs::removeClass("mySurveySays", "Correct")
                        shinyjs::addClass("mySurveySays", "Oops")
                        shinyjs::removeClass("myExplain", "Correct")
                        shinyjs::addClass("myExplain", "Oops")
                        myModuleRV$surveySays <- "Oops! Try again!"
                        myModuleRV$myOops <- myModuleRV$myOops + 1
                }
                
                shinyjs::show(id = "divExplain", anim = TRUE, animType = "slide")
                
        })
        
        observeEvent(input$button0,{
            
                if(myModuleRV$df$TrueFalse == 0){
                        shinyjs::removeClass("mySurveySays", "Oops")
                        shinyjs::addClass("mySurveySays", "Correct")
                        shinyjs::removeClass("myExplain", "Oops")
                        shinyjs::addClass("myExplain", "Correct")
                        myModuleRV$surveySays <- "Correct!"
                        myModuleRV$myCorrect <- myModuleRV$myCorrect + 1
                } else {
                        shinyjs::removeClass("mySurveySays", "Correct")
                        shinyjs::addClass("mySurveySays", "Oops")
                        shinyjs::removeClass("myExplain", "Correct")
                        shinyjs::addClass("myExplain", "Oops")
                        myModuleRV$surveySays <- "Oops! Try again!"
                        myModuleRV$myOops <- myModuleRV$myOops + 1
                }
                
                shinyjs::show(id = "divExplain", anim = TRUE, animType = "slide")
                
        })
        
        observeEvent(input$buttonNext,{
                
                shinyjs::hide(id = "divExplain", anim = TRUE, animType = "slide", time=0)
                myModuleRV$surveySays <- ""
                
                shinyjs::show(id = "divResults", anim = TRUE, animType = "slide")
                
                myModuleRV$df <- df %>% 
                        filter(Category == myCategory) %>% 
                        sample_n(1)
                
        })
        
        output$pResults <- renderPlot({
                
                req(myModuleRV$myCorrect + myModuleRV$myOops > 0)
                
                myCorrect <- myModuleRV$myCorrect
                myOops <- myModuleRV$myOops
                
                myPercent <- round(100 * myCorrect / (myCorrect + myOops), 1)
                dfPercent <- data.frame(Percent = myPercent, Result = 0)
                
                p <- ggplot(data=dfPercent, aes(x=Percent, y=Result))
                p <- p + geom_segment(aes(x=0, xend=Percent, y=Result, yend=Result), col="#1b9e77", size=5)
                p <- p + geom_segment(aes(x=Percent, xend=100, y=Result, yend=Result), col="#d95f02", size=5)
                p <- p + geom_text(aes(x=5, y=Result), label=paste0(myCorrect,"/", myCorrect + myOops, " correct"), hjust=0, col="ghostwhite")
                p <- p + theme_minimal() + xlab("") + ylab("")
                p <- p + theme(axis.text.x=element_blank(),
                               axis.ticks.x=element_blank(),
                               axis.text.y=element_blank(),
                               axis.ticks.y=element_blank(),
                               panel.grid.major = element_blank(), 
                               panel.grid.minor = element_blank())
                print(p)
                
        })
        
        
        output$myText <- renderUI({ myModuleRV$df$Text })
        output$myExplain <- renderUI({ myModuleRV$df$Explanation })
        output$mySurveySays <- renderUI({ myModuleRV$surveySays })
        output$myResults <- renderUI({ as.character(myModuleRV$myCorrect) })
        

}