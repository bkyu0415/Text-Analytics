library(sentimentr)
library(tidyverse)
#sentiment(text)
#sentiment_by(text, by = NULL)
#profanity(text)

#dataset in the package
debates <- presidential_debates_2012  


debates_with_pol <- debates %>% 
  get_sentences() %>% 
  sentiment() %>% 
  mutate(polarity_level = ifelse(sentiment < 0.2, "Negative",
                                 ifelse(sentiment > 0.2, "Positive","Neutral")))


debates_with_pol %>% filter(polarity_level == "Negative") %>% View()

#boxplot
debates_with_pol %>% 
  ggplot() + geom_boxplot(aes(y = person, x = sentiment))
#highlight
debates$dialogue %>% 
  get_sentences() %>% 
  sentiment_by() %>% #View()
  highlight()

#density
debates %>% 
  get_sentences() %>% 
  sentiment_by(by = NULL) %>% #View()
  ggplot() + geom_density(aes(ave_sentiment))