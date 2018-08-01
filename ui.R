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



# Functions ====

source("Module Quiz.R")

# Data ====

myHeader <- dashboardHeader(disable = TRUE)
mySidebar <- dashboardSidebar(disable = TRUE)
myBody <- dashboardBody(
        
        useShinyjs(),
        
        fluidRow(
                
                box(width=12, background = "blue",
                    
                    div(id="divLogo",
                        img(src = "Project180Logo.PNG", width=0.37*1561, height=0.37*288),
                        style="text-align: center;"
                    )
                ),
                
                box(width =12,
                    
                    tags$h3("Change the World", style = "color: #386cb0; text-align: center;"),
                    tags$h3("One Conversation at a Time", style = "color: #386cb0; text-align: center;"),
                    tags$br(),
                    tags$p("Project 180 believes that passive violence - what we say to one another and how we say it - leads to physical violence",
                           tags$a(href="http://www.innerself.com/Behavior_Modification/violence_12192.htm", "(Arun Ghandi). ", target_="blank"),
                           tags$b("If we don't do a '180' with our words, we will continue to perpetuate physical violence.  "),
                           "Project 180 aims to share the concepts of non-violent communication in a ",tags$b("quick, easy, fun, interactive")," web interface."),
                    tags$br(),
                    tags$b("Main Ideas:"),
                    tags$br(),
                    tags$li(tags$b("Seek to understand and empathize,"), "rather than belittle, insult, blame, mock, disparage, or demean others"),
                    tags$li(tags$b("Seek to meet needs"), "instead of ascertaining 'right' and 'wrong' or 'good' and 'bad'"),
                    tags$li("Come together in", tags$b("humility and respect"))
                )
        ),
        
        fluidRow(
                
                box(width=6, 
                    title = tags$p("Observations", style="color: #386cb0;"),
                    tags$p("Try to make observations instead of evaluations.  Evaluations may imply wrong-doing, assign blame, or induce shame or guilt and do not help people connect!  
                                       Observations that speak to truths are a great starting point because they are empically verifiable and do not assess another persons motives!
                                       See if you can tell the difference between observations and evaluations (below)!"),
                    tags$br(), tags$br(),
                    quizInput("Observation", buttonLabel1 = "Observation", buttonLabel0 = "Evaluation", buttonLabelNext = "Next Question")
                ),

                box(width=6, 
                    title = tags$p("Feelings", style="color: #386cb0;"),
                    tags$p("Feelings are tricky. Many times when we express feelings, we are actually expressing thoughts, blaming, or yielding undue power to another person.
                                       See if you can tell the difference between true feelings and false feelings!"),
                    tags$br(), tags$br(),
                    quizInput("Feeling", buttonLabel1 = "Feeling", buttonLabel0 = "Not a Feeling", buttonLabelNext = "Next Question")
                    
                )
        ),
        
        fluidRow(
                

                box(width=6, 
                    title = tags$p("Needs", style="color: #386cb0;"),
                    tags$p("Our feelings are derived from our met or unmet needs. Therefore, it is important to be aware of our needs and to be able to express them!
                                       Our basic human needs are universal, but sometimes we confuse our needs with strategies to meet our needs.
                                       See if you can distinguish between true needs and false needs!"),
                    tags$br(), tags$br(),
                    quizInput("Need", buttonLabel1 = "Need", buttonLabel0 = "Not a Need", buttonLabelNext = "Next Question")
                    
                ),
                

                            
                box(width=6, 
                    title = tags$p("Requests", style="color: #386cb0;"),
                    tags$p("Once we are self-aware of our feelings and needs, we can make a reasonable, specific request of another.
                                       In doing so, we enrich our lives, as well as the lives of those to whom we make requests!
                                       See if you can distinguish between reasonable, specific requests and vague demands!"),
                    tags$br(), tags$br(),
                    quizInput("Request", buttonLabel1 = "Request", buttonLabel0 = "Not a Request", buttonLabelNext = "Next Question")
                    
                )
        ),
        
        fluidRow(
                
                box(width = 12, title = tags$p("Participate", style="color: #386cb0;"),
                    tags$p("Willing to give non-violent communication a try?  Click the map where you live to join the community!"),
                    leafletOutput("myMap"),
                    tags$br(), tags$br(),
                    plotOutput("pTime")
                    
                )
        ),
        
        fluidRow(
                
                box( width = 12,
                     title = tags$p("Non-Violent Communication Predictor", style="color: #386cb0;"),
                     tags$p("Don't take results from this too seriously!  This is a beta version implementation based on limited data..."),
                     textInput(inputId="myText", label = "Enter Your Text Here..."),
                     tags$br(),tags$br(),
                     infoBoxOutput("myPredict")
                )
                
        ), 
        
        div(id="divAcknowledge", style="text-align: center; color: #386cb0;",
            tags$br(),
            tags$p("Content comes directly from Marshall Roseburg's book 'Nonviolent Communication - A Language of Life'")       
        )
)

dashboardPage(myHeader, mySidebar, myBody)
