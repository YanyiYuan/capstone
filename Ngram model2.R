## Ngram model
#Data Sampling
blogsSample <- sample(blogs, length(blogs)*0.1, replace = FALSE)
newsSample <- sample(news, length(news)*0.1, replace = FALSE)
twitterSample <- sample(twitter, length(twitter)*0.1, replace = FALSE)

Sample <- c(blogsSample,newsSample,twitterSample)

Sample <- c(blogsSample,newsSample,twitterSample)
#Remove non ASCII characters
Sample<- unlist(strsplit(Sample, split=" "))

Index<- grep("Sample", iconv(Sample, "latin1", "ASCII", sub="Sample"))
Sample<- Sample[ - Index]

Sample<- paste(Sample, collapse = " ")

#Convert Character to Corpus
Sample_corpus<- Corpus(VectorSource(Sample))

#Convert characters to lower case
Sample_corpus<- tm_map(Sample_corpus, tolower)

#Remove punctuation
Sample_corpus<- tm_map(Sample_corpus, removePunctuation)

#Remove numbers
Sample_corpus<- tm_map(Sample_corpus, removeNumbers)

#Remove white space
Sample_corpus <- tm_map(Sample_corpus, stripWhitespace)

Sample_txt <- Sample_corpus[[1]]$content
Sample_txt <- txt.to.words(Sample_txt)

Unigram<-data.frame(table(make.ngrams(Sample_txt, ngram.size = 1)))
Bigram<-data.frame(table(make.ngrams(Sample_txt, ngram.size = 2)))
Trigram<-data.frame(table(make.ngrams(Sample_txt, ngram.size = 3)))


#Order by the frequency of one, two and three ngrams

Unigram <- Unigram[order(Unigram$Freq,decreasing = TRUE),]
Bigram <- Bigram[order(Bigram$Freq,decreasing = TRUE),]
Trigram <- Trigram[order(Trigram$Freq,decreasing = TRUE),]

## split bigram and trigram
Bigram_split <- Bigram %>% separate(Var1, c("n-1", "n"))
Trigram_split <- Trigram %>% separate(Var1, c("n-2", "n-1","n"))

setwd("C:/Users/me/Documents/Coursera/capstone/Data_Science_Capstone_Ngram_Model")
write.table(Bigram_split,"Bigram_split.txt",sep="\t",row.names=FALSE)
write.table(Trigram_split,"Trigram_split.txt",sep="\t",row.names=FALSE)

##############################
#######Input #################

n_2 <- "settle"
n_1 <- "the"


Tri_Pred_tot <- Trigram_split[which(Trigram_split$`n-2`==n_2 & Trigram_split$`n-1`==n_1),]
Tri_Pred1 <- Tri_Pred_tot$n[1]
Tri_Pred2 <- Tri_Pred_tot$n[2]
Tri_Pred3 <- Tri_Pred_tot$n[3]

Bi_Pred_tot <- Bigram_split[which(Bigram_split$`n-1`==n_1),]
Bi_Pred1 <- Bi_Pred_tot$n[1]
Bi_Pred2 <- Bi_Pred_tot$n[2]
Bi_Pred3 <- Bi_Pred_tot$n[3]

c(Tri_Pred1, Tri_Pred2, Tri_Pred3, Bi_Pred1, Bi_Pred2, Bi_Pred3)


##########if word not found
if ( c(Tri_Pred1, Tri_Pred2, Tri_Pred3, Bi_Pred1, Bi_Pred2, Bi_Pred3)==c(NA,NA,NA,NA,NA,NA)) {
  
  txt = paste(n_2,n_1,sep=" ")
  blogs3gram <- blogs[grep(txt,blogs)]
  news3gram <- news[grep(txt,news)]
  twitter3gram <- twitter[grep(txt,twitter)] 
  
  All3gram <- c(blogs3gram,news3gram,twitter3gram)
  
  All3gram <- txt.to.words(All3gram)
  All3gram<-data.frame(table(make.ngrams(All3gram, ngram.size = 3)))
  All3gram_split <- All3gram %>% separate(Var1, c("n-2", "n-1","n"))
  
  
  
}



#Quiz 2 - Week 3
n_last <- c("account","matter","case","incident")
for (i in 1: 4){
print(n_last[i])
print(Tri_Pred_tot[which(Tri_Pred_tot$n == n_last[i]),])
print(Bi_Pred_tot[which(Bi_Pred_tot$n == n_last[i]),])
}




### question 2 ####
txt = "time to take a"
txt_2= "Holland"
#blogs[grep(txt,blogs)]
#news[grep(txt,news)]
#twitter[grep(txt,twitter)]

a<- grep(txt,twitter)
b<-grep(txt_2,twitter)
twitter[intersect(a,b)]

a<- grep(txt,blogs)
b<-grep(txt_2,blogs)
blogs[intersect(a,b)]

a<- grep(txt,news)
b<-grep(txt_2,news)
news[intersect(a,b)]



### question 10 Adam Sandler's

txt = "settle the"
blogs[grep(txt,blogs)]
news[grep(txt,news)]
twitter[grep(txt,twitter)]
