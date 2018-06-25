
require(tm)
require(stylo)
#setwd("C:/Users/me/Documents/Coursera/capstone/Data_Science_Capstone_Ngram_Model")

predict <- function(x) {
  #"clean" incoming string
  word_input <- tolower(x)
  word_split <- strsplit(word_input," ")
  nwords <- length(word_split[[1]])
  Bigram_split2 <- readRDS(file = "./Bigram_split2.rds")
  Trigram_split2 <- readRDS(file = "./Trigram_split2.rds")
  
  
  if (nwords == 1){
    n_1 <- word_split[[1]][nwords]
    
    Bi_Pred_tot <- Bigram_split2[which(Bigram_split2$`n.1`==n_1),]
    Bi_Pred1 <- Bi_Pred_tot$n[1]
    output <- as.character(Bi_Pred1)
    output
  }
  
  else if (nwords > 1){
    n_1 <- word_split[[1]][nwords]
    n_2 <- word_split[[1]][nwords-1]
    
    #Bigram_split2 <- read.table("Bigram_split.txt",sep="\t",header=TRUE)
    #
    
    Tri_Pred_tot <- Trigram_split2[which(Trigram_split2$`n.2`==n_2 & Trigram_split2$`n.1`==n_1),]
    Tri_Pred1 <- Tri_Pred_tot$n[1]

    Bi_Pred_tot <- Bigram_split2[which(Bigram_split2$`n.1`==n_1),]
    Bi_Pred1 <- Bi_Pred_tot$n[1]
    
    if (is.na(Tri_Pred1) ){
    output <- paste(Bi_Pred1)
    }
    else output <- paste(Tri_Pred1)
  }
  
 

}
