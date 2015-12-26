

## LOAD tweets corpus (txt files from directory ".\mycorpus) ##
## the loaded corpus is already tidy: removed extra whitespaces, removed punctuation, removed url's, lower case, removed numbers, removed stopwords, stemmed! ##
library(twitteR); library(tm); library(xlsx); library(wordcloud); library(IDPmisc)
myCorpus <- VCorpus(DirSource("mycorpus", encoding = "UTF-8"))

## build term-document matrix ##
myCorpus <- tm_map(myCorpus, PlainTextDocument)
myTdm <- TermDocumentMatrix(myCorpus, control=list(wordLengths=c(3,Inf)))
m <- as.matrix(myTdm)
wordFreq <- sort(rowSums(m), decreasing=T)
col_ors = c( "red", "yellow", "limegreen", "cyan", "blue", "magenta")


shinyServer(

            function(input, output) {

                                      ## barchart most frequent terms ##

                                      output$bar_chart <- renderPlot({
                                             
                                                                      sorted_tF = sort(wordFreq[1:input$n_token], decreasing=F )
                                              
                                                                       color_hsv = col2hsv(col_ors[input$color])
                                             
                                                                       pal_ette = hsv(h=color_hsv[1], s=color_hsv[2], v=color_hsv[3], alpha = 0.5+0.5*sorted_tF/max(sorted_tF))

                                                                       barplot( sorted_tF, horiz=T, col="white", axisnames=F )

                                                                       midpointsx <- as.numeric(sorted_tF)/2

                                                                       midpointsy <- barplot( sorted_tF, horiz = T, plot=F )

                                                                       text(x=midpointsx, y=midpointsy, labels = names(sorted_tF), col = pal_ette)
                                                                       })

                                      # WORD CLOUD ##

                                      set.seed(375) # to make it reproducible ##

                                      output$word_cloud <- renderPlot({

                                              sorted_tF = sort(wordFreq[1:input$n_token], decreasing=F )

                                                                        color_hsv = col2hsv(col_ors[input$color])
                                              
                                                                        pal_ette = hsv(h=color_hsv[1], s=color_hsv[2], v=color_hsv[3], alpha = 0.5+0.5*sorted_tF/max(sorted_tF))

                                                                        wordcloud(
                                                                                  words=names(wordFreq), 
                                                                                  freq=wordFreq, 
                                                                                  max.words = input$n_token, 
                                                                                  random.order=F, 
                                                                                  colors = pal_ette
                                                                                 )
                                                                        })
                                     } 
            ) 
                
