
library(shiny)
shinyUI( fluidPage(     fluidRow(
                                        column(12, h1("TEXT MINING EXAMPLE", align="center"))
                                 ),
                        fluidRow(
                                        column(12, p(  
                                                      "This shiny app shows a text mining example by interactive 
                                                      graphs of the most frequent terms among some tweets. The 
                                                      tweets dataset we worked on is a sample of 100 tweets extract 
                                                      from 10000 tweets downloaded via Twitter's API using as search keyword
                                                      the ashtag #Parisattacks. tweets were preprocessed to extract lexical terms
                                                      and to build a term frequency table on wich the graphs are based. 
                                                        Users can control the number of terms displayed via the proper 
                                                      slider and with another slider, users can choose theyr preferred 
                                                      colors for the plots. The two tabs over the plot allows to 
                                                      switch between a barchart and a word cloud.",
                                                      style = "font-family: 'times'; font-si11pt"
                                                     ),
                                                    p( "WARNING: max number of terms is limited to avoid words overlapping!",
                                                       style="font-family: 'times'; font-si14pt")
                                                )
                                                    
                                                
                                
                                ),
                        fluidRow(
                                        column(12,
                                                tabsetPanel(
                                                                tabPanel("Barchart", plotOutput("bar_chart")), 
                                                                tabPanel("WordCloud", plotOutput("word_cloud"))
                                                            )
                                                )
                                 ),
                        fluidRow(
                                        column(6, 
                                               sliderInput("n_token", "Number of terms to display", min=3, max=15, step=1, round=0, value = 20)
                                                ), 
                                        column(6,       
                                                sliderInput("color", "Color Control", min=1, max=6, step=1, round=0, value = 1)
                                                )
                                 )
                   ) ## end of fluidpage ##
        ) ## end of shinyui ##