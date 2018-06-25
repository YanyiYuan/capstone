
library(shiny)
source("predict.R")
#Bigram_split2 <- readRDS(file = "Bigram_split2.rds")
#Trigram_split2 <- readRDS(file = "Trigram_split2.rds")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$value <- renderPrint({ input$text })
  #predicted <- WordPredict()
  #output$last_words <- get_last_words(renderPrint({ input$text }),2)
  output$predicted <- renderText({
    as.character(predict(as.character(input$text)))
  })
})
