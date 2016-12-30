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
                )
        ),
        
        fluidRow(
                
                # Welcome ====
                
                column(width=10,
                       
                       div(id="divWelcome", style="text-align: center;",
                           
                           shinyjs::hidden(
                                   div(id="divChange",
                                       tags$h3("Change the World", style = "color: #386cb0;")
                                   )
                           ),
                           
                           shinyjs::hidden(
                                   div(id="divConversation",
                                       tags$h3("One Conversation at a Time", style = "color: #386cb0;")
                                   )
                           ),
                           
                           shinyjs::hidden(
                                   div(id="divAskYourself", style="text-align: center; color: #386cb0;",
                                       tags$h3("Ask yourself", tags$i("'Is it better to be right?  Or better to be kind?'")),
                                       tags$br(), tags$br()
                                       #                                        tags$h3(tags$i("How do you know you are 'right'?", style = "color: #386cb0;")),
                                       #                                        tags$h3(tags$i("How do you know you are being 'kind'?", style = "color: #386cb0;")),
                                       #                                        tags$h3(tags$i("Are you willing to acknowledge that you might be wrong?", style = "color: #386cb0;")),
                                       #                                        tags$h3(tags$i("Would you rather connect with someone who is 'right' or someone who is 'kind'?", style = "color: #386cb0;"))
                                       #                                        
                                   )
                           )
                           
                       ),
                       
                       shinyjs::hidden(
                               div(id="divBackground", style="text-align: center;",
                                   tags$br(),tags$br(),tags$br(),tags$br(),
                                   tags$p('Coming soon...')
                               )
                       ),
                       
                       
                       
                       shinyjs::hidden(
                               div(id="divMainIdeas", style="text-align: center;",
                                   tags$br(),tags$br(),tags$br(),tags$br(),
                                   tags$b("Main Idea #1"), tags$br(),
                                   tags$b("Main Idea #2"),
                                   tags$p("etc...")
                                   
                               )
                       ),
                       
                       shinyjs::hidden(
                               div(id="divGrowth", style="text-align: center;",
                                   tags$br(),tags$br(),
                                   plotOutput("pTime")
                                   
                               )
                       ),
                       
                       #                        shinyjs::hidden(
                       #                                div(id="divWhatIf", style="text-align: center;",
                       #                                    tags$br(),tags$br(),tags$br(),tags$br(),
                       #                                    tags$p("This will be network simulation to demonstrate how NVC could spread through the population"),
                       #                                    tags$p("Coming soon...")
                       #                                )
                       #                        ),
                       
                       shinyjs::hidden(
                               div(id="divObsVsEval", style="text-align: left;",
                                   
                                   box(width=12, title = "Observations",
                                       tags$p("Try to make observations instead of evaluations.  Evaluations may imply wrong-doing, assign blame, or induce shame or guilt and do not help people connect!  
                                          Observations that speak to truths are a great starting point because they are empically verifiable and do not assess another persons motives!
                                          See if you can tell the difference between observations and evaluations (below)!"),
                                       tags$br(), tags$br(),
                                       quizInput("Observation", buttonLabel1 = "Observation", buttonLabel0 = "Evaluation", buttonLabelNext = "Next Question")
                                   )
                               )
                       ),
                       
                       shinyjs::hidden(
                               div(id="divFeeling", style="text-align: left;",
                                   
                                   box(width=12, title = "Feelings",
                                       tags$p("Feelings are tricky. Many times when we express feelings, we are actually expressing thoughts, blaming, or yielding undue power to another person.
                                              See if you can tell the difference between true feelings and false feelings!"),
                                       tags$br(), tags$br(),
                                       quizInput("Feeling", buttonLabel1 = "Feeling", buttonLabel0 = "Not a Feeling", buttonLabelNext = "Next Question")
                                   )
                                   
                               )
                       ),
                       
                       shinyjs::hidden(
                               div(id="divNeed", style="text-align: left;",
                                   
                                   box(width=12, title = "Needs",
                                       tags$p("Our feelings are derived from our met or unmet needs. Therefore, it is important to be aware of our needs and to be able to express them!
                                                Our basic human needs are universal, but sometimes we confuse our needs with strategies to meet our needs.
                                                See if you can distinguish between true needs and false needs!"),
                                       tags$br(), tags$br(),
                                       quizInput("Need", buttonLabel1 = "Need", buttonLabel0 = "Not a Need", buttonLabelNext = "Next Question")
                                   )
                                   
                               )
                       ),
                       
                       shinyjs::hidden(
                               div(id="divRequest", style="text-align: left;",
                                   
                                   box(width=12, title = "Requests",
                                       tags$p("Once we are self-aware of our feelings and needs, we can make a reasonable, specific request of another.
                                                In doing so, we enrich our lives, as well as the lives of those to whom we make requests!
                                                See if you can distinguish between reasonable, specific requests and vague demands!"),
                                       tags$br(), tags$br(),
                                       quizInput("Request", buttonLabel1 = "Request", buttonLabel0 = "Not a Request", buttonLabelNext = "Next Question")
                                   )
                                   
                               )
                       ),
                       
                       shinyjs::hidden(
                               div(id="divParticipate", style="text-align: center;",
                                   box(width = 12, title = "Participate",
                                       tags$p("Willing to give non-violent communication a try?  Click the map where you live to join the community!"),
                                       leafletOutput("myMap")
                                   )
                               )
                       ),
                       
                       shinyjs::hidden(
                               div(id="divTextAnalysis", style="text-align: center;",
                                   tags$br(),tags$br(),tags$br(),tags$br(),
                                   tags$p("This will be a tool that allows users to enter text and get an NVC rating"),
                                   tags$p("Coming Soon...")
                               )
                       ),
                       
                       shinyjs::hidden(
                               
                               div(id="divResources", style="text-align: center;",
                                   
                                   tags$br(),tags$br(),tags$br(),tags$br(),
                                   
                                   tags$p("All materials attributable to Marshall Rosenburg's books and YouTube videos unless otherwise noted.
                                          Project 180 simply attempts to make his ideas and teachings quickly and easily available in an interactive, educational, and fun way."),
                                   
                                   tags$br(), tags$br(),
                                   
                                   tags$p("Standing on the shoulders of giants..."),
                                   tags$br(),
                                   tags$a("Marshall Rosenburg Non-Violent Communication - Part I (9:35)", target="_blank", href="https://www.youtube.com/watch?v=-dpk5Z7GIFs"),
                                   tags$br(),
                                   tags$a("Marshall Rosenburg Non-Violent Communication - Part II (5:47)", target="_blank", href="https://www.youtube.com/watch?v=XbgxFgAN7_w&t=30s"),
                                   tags$br(),
                                   tags$a("Marshall Rosenburg Non-Violent Communication - Part III (4:25)", target="_blank", href="https://www.youtube.com/watch?v=L8fbxPAXBPE&t=10s"),
                                   tags$br(),
                                   tags$a("Marshall Rosenburg 2012 San Francisco Workshop (3:05:57 and Worth It)", target="_blank", href="https://www.youtube.com/watch?v=YwXH4hNfgPg&t=2742s")
                                   
                               )
                       ),
                       
                       shinyjs::hidden(
                               
                               div(id="divHelp",
                                   
                                   tags$br(),tags$br(),
                                   
                                   tags$p("Want to help?  Project 180 is looking for the following..."),
                                   tags$br(), 
                                   tags$ul(
                                           tags$li("Content: Project 180 originated from an imperfect couple enjoying breakfast in a Days Inn hotel near New Haven CT.
                                                   Feel free to challenge, correct, and/or make suggestions to improve the content!"),
                                           tags$li("An R shiny server:  
                                                   Project 180 is currently hosted compliments of", tags$a(href="https://www.shinyapps.io/", "shiny apps at R Studio,", target="_blank"), 
                                                   "but is limited to a maximum 5 hours of total free usage per month!"),
                                           tags$li("Aesthetics and Ease of Use: Project 180 was initiated by a statistician, not a web designer!  All suggestions are welcome!"),
                                           tags$li("Machine Learning: Project 180 would like to upgrade the text analysis model that suggests to users whether or not their language is nonviolent!")
                                   ),
                                   tags$br(),
                                   textInput(inputId = "mySuggestion","Enter your suggestions here..."),
                                   tags$br(),
                                   tags$p("Or contribute via", tags$a(href="https://github.com/statsmith/Project180", "Github", targer="_blank"))
                               )
                       )
                       
                ),
                
                # Inputs ====              
                column(width=2,
                       
                       
                       actionLink(inputId = "linkBackground", label = "Background"),
                       tags$br(),tags$br(),
                       #                        actionLink(inputId = "linkAskYourself", label = "Ask Yourself"),
                       #                        tags$br(),tags$br(),
                       actionLink(inputId = "linkMainIdeas", label = "Main Ideas"),
                       tags$br(),tags$br(),
                       #                        actionLink(inputId = "linkWhatIf", label = "What If..."),
                       #                        tags$br(),tags$br(),
                       actionLink(inputId = "linkGrowth", label = "See the Growth"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkObsVsEval", label = "Try It - Observations"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkFeeling", label = "Try It - Feelings"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkNeed", label = "Try It - Needs"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkRequest", label = "Try It - Requests"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkParticipate", label = "Pledge to Participate"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkTextAnalysis", label = "Text Analysis"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkResources", label = "Resources"),
                       tags$br(),tags$br(),
                       actionLink(inputId = "linkHelp", label = "Help Us!")
                       
                )
                
        ), # End Fluid Row
        
        div(id="divAcknowledge", style="text-align: center; color: #386cb0;",
            tags$br(), tags$br(), tags$br(),
            tags$p("Project 180 started as a respose to the rhetoric observed during the 2016 presidential election.  
                                  The content comes directly from Marshall Roseburg's book 'Nonviolent Communication - A Language of Life'")       
        )
)

               

dashboardPage(myHeader, mySidebar, myBody)
