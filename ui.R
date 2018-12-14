#################################################
#               Basic Text Analysis             #
#################################################

library(shiny)
library(text2vec)
library(tm)
library(tokenizers)
library(wordcloud)
library(slam)
library(stringi)
library(magrittr)
library(tidytext)
library(dplyr)
library(tidyr)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Shiny App around the UDPipe NLP workflow"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #Input file upload option in UI 
      fileInput("file", "Upload Input Text File(.txt format)"),
      #Model file upload option in UI 
      fileInput("modelFile", "Upload trained udpipe model for different languages"),
      #Check box group to select the 
      checkboxGroupInput("xpos", label = h3("Part-of-Speech Tags (XPOS)"), 
                         choices = list("Adjective (JJ)" = "adjective", "Noun(NN)2" = "noun", 
                                        "Proper Noun (NNP)" = "properNoun", "Adverb (RB)"= "adverb", "Verb (VB)" ="verb"),
                         selected = c("adjective","noun", "properNoun")),
                         hr(),
                        fluidRow(column(3, verbatimTextOutput("value"))),

      textInput("stopw", ("Enter stop words separated by comma(,)"), value = "will,can"),
      
      selectInput("ws", "Weighing Scheme", 
                  c("weightTf","weightTfIdf"), selected = "weightTf"), # weightTf, weightTfIdf, weightBin, and weightSMART.
      
      sliderInput("freq", "Minimum Frequency in Wordcloud:", min = 0,  max = 100, value = 2),
      
      sliderInput("max",  "Maximum Number of Words in Wordcloud:", min = 1,  max = 300,  value = 50),  
      
      numericInput("nodes", "Number of Central Nodes in co-occurrence graph", 4),
      numericInput("connection", "Number of Max Connection with Central Node", 5),
      
      textInput("concord.word",('Enter word for which you want to find concordance'),value = 'good'),
      sliderInput("window",'Concordance Window',min = 2,max = 100,5),
      
      submitButton(text = "Apply Changes", icon("refresh"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  
                  tabPanel("Overview",
                           h4(p("Data input")),
                           p("This app supports only comma separated values (.csv) data file. CSV data file should have headers and the first column of the file should have row names.",align="justify"),
                           p("Please refer to the link below for sample csv file."),
                           a(href="https://github.com/sudhir-voleti/sample-data-sets/blob/master/Segmentation%20Discriminant%20and%20targeting%20data/ConneCtorPDASegmentation.csv"
                             ,"Sample data input file"),   
                           br(),
                           h4('How to use this App'),
                           p('To use this app, click on', 
                             span(strong("Upload data (csv file with header)")),
                             'and uppload the csv data file. You can also change the number of clusters to fit in k-means clustering')),
                  tabPanel("TDM & Word Cloud",
                           verbatimTextOutput("dtmsize"),
                           verbatimTextOutput("dtmsummary"),
                           br(),
                           br(),
                           h4("Word Cloud"),
                           plotOutput("wordcloud",height = 700, width = 700),
                           h4("Weights Distribution of Wordcloud"),
                           verbatimTextOutput("dtmsummary1")),
                  tabPanel("Term Co-occurrence",
                           plotOutput("cog.dtm",height = 700, width = 700)
                  )

                  
      ) # end of tabsetPanel
    )# end of main panel
  ) # end of sidebarLayout
)  # end if fluidPage
) # end of UI


