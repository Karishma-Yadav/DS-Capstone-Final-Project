library(shiny)
library(shinydashboard)

suppressPackageStartupMessages({
  library(tidyverse)
  library(stringr)
})

#' Source ngram matching function
source("ngram.R")


shinyApp(
  ui <- dashboardPage(
    
    dashboardHeader(title = "Next Word Prediction App", titleWidth = 350),
    
    dashboardSidebar(width = 350,
                     sidebarMenu(
                       menuItem("Welcome", tabName = "welcome"),
                       menuItem("Instruction", tabName = "instruction"),
                       menuItem("Prediction", tabName = "prediction"),
                       menuItem("Top Quadgrams", tabName = "quadgrams"),
                       menuItem("Top Trigrams", tabName = "trigrams"),
                       menuItem("Top Bigrams", tabName = "bigrams")
                       
                     )),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "welcome",
                h1("Welcome To The Next Word Prediction Shiny App"),
                br(),
                br(),
                h2("This Shiny app takes a phrase (multiple words) as input in a 
                           text box input and outputs a prediction of the next word."),
                a("Source Code", href = "https://github.com/Karishma-Yadav/DS-Capstone-Final-Project")
        ),
        
        tabItem(tabName = "instruction",
                h2("Instructions:"), 
                h5("1. Enter a word or words in the text box."),
                h5("2. The predicted next word prints below it in blue."),
                h5("3. No need to hit enter of submit."),
                h5("4. A question mark means no prediction, typically due to mis-spelling"),
        ),
        
        tabItem(tabName = "prediction",
                textInput("user_input", h3("Your Input:"), value = "Your words"),
                h3("Predicted Next Word:"),
                h4(em(span(textOutput("ngram_output"), style="color:BLUE")))
        ),
        
        tabItem(tabName = "quadgrams",br(),br(),
                img(src = "quadgrams.png", height = 500, width = 700)
        ),
        
        tabItem(tabName = "trigrams",br(),br(),
                img(src = "trigrams.png", height = 500, width = 700)
        ),
        
        tabItem(tabName = "bigrams",br(),br(),
                img(src = "bigrams.png", height = 500, width = 700)
        )
        
      )
    )
  ),
  
  #' Define server logic required to draw a histogram
  server <- function(input, output) {
    
    output$ngram_output <- renderText({
      ngrams(input$user_input)
    })
    
  }
)
#' Run the application 
shinyApp(ui = ui, server = server)
