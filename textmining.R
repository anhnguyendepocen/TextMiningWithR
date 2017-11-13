Needed <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", 
    "cluster", "igraph", "fpc")
install.packages(Needed, dependencies = TRUE)

install.packages("Rcampdf", repos = "http://datacube.wu.ac.at/", type = "source")
cname <- file.path(getwd(),"texts")
cname
dir(cname)
library(tm)
docs <- VCorpus(DirSource(cname))   
summary(docs)
inspect(docs[1])
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, PlainTextDocument)
DocsCopy <- docs
#docs <- tm_map(docs, removeWords, stopwords("english"))   
docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs, stripWhitespace)
for (j in seq(docs))
{
  docs[[j]] <- gsub("head phone", "head_phone", docs[[j]])
  docs[[j]] <- gsub("headphone jack", "headphone_jack", docs[[j]])
  docs[[j]] <- gsub("iphone x", "iphone_x", docs[[j]])
  docs[[j]] <- gsub("note 8", "note_8", docs[[j]])
  docs[[j]] <- gsub("finger print", "fingerprint", docs[[j]])
  docs[[j]] <- gsub("one plus", "oneplus", docs[[j]])
  docs[[j]] <- gsub("iphone 8", "iphone8", docs[[j]])	
  docs[[j]] <- gsub("wireless charging", "wireless_charging", docs[[j]])
  docs[[j]] <- gsub("stereo speakers", "stereo_speakers", docs[[j]])
  docs[[j]] <- gsub("front facing", "front_facing", docs[[j]])
  }
#docs <- tm_map(docs, removeWords, c("google", "samsung","iphone","pixel","apple"))
docs <- tm_map(docs, PlainTextDocument)
#preprocessing done
dtm <- DocumentTermMatrix(docs)
dtm
inspect(dtm)
freq <- colSums(as.matrix(dtm))   
length(freq)
ord <- order(freq)
m <- as.matrix(dtm)   
dim(m)
#write.csv(m, file="DocumentTermMatrix.csv")
dtms <- removeSparseTerms(dtm, 0.2) # This makes a matrix that is 20% empty space, maximum.   
dtms
inspect(dtms)
freq <- colSums(as.matrix(dtm))
freq
head(table(freq), 20) # The ", 20" indicates that we only want the first 20 frequencies. Feel free to change that number.
tail(table(freq), 20)
freq <- colSums(as.matrix(dtms))   
freq
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)   
head(freq, 14)
findFreqTerms(dtm, lowfreq=500)
wf <- data.frame(word=names(freq), freq=freq)   
head(wf)
library(ggplot2)
png(filename="WordFreq.png")
p <- ggplot(subset(wf, freq>1000), aes(x = reorder(word, -freq), y = freq)) +
          geom_bar(stat = "identity") + 
          theme(axis.text.x=element_text(angle=45, hjust=1))
p
findAssocs(dtm, c("note8"), corlimit=0.05)
install.packages("wordcloud")
library(RColorBrewer) 
library(wordcloud)
set.seed(142)   
wordcloud(names(freq), freq,  min.freq=800,scale=c(5,0.8), colors=brewer.pal(8, "Dark2"))
findAssocs(dtms, c("samsung"), corlimit=0.10)           