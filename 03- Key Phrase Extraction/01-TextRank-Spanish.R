#https://www.r-bloggers.com/an-overview-of-keyword-extraction-techniques/
#https://medium.com/datadriveninvestor/rake-rapid-automatic-keyword-extraction-algorithm-f4ec17b2886c
library(udpipe)
library(textrank)
library(dplyr)
## First step: Take the Spanish udpipe model and annotate the text. Note: this takes about 3 minutes
data(brussels_reviews)
comments <- subset(brussels_reviews, language %in% "es")
ud_model <- udpipe_download_model(language = "spanish")
ud_model <- udpipe_load_model(ud_model$file_model)
x <- udpipe_annotate(ud_model, x = comments$feedback)
x <- as.data.frame(x)

stats <- keywords_rake(x = x, 
                       term = "token", group = c("doc_id", "paragraph_id", "sentence_id"),
                       relevant = x$upos %in% c("NOUN", "ADJ"),
                       ngram_max = 4)
head(subset(stats, freq > 3))