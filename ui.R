#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Word Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("text", label= h3("Type your words:"), value="your input"),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Your input is"),
      h4(textOutput("value")),
      h3("Next word prediction"),
      textOutput("predicted")
      #verbatimTextOutput("cleaned"), verbatimTextOutput("msg"),

    )
  )
))
