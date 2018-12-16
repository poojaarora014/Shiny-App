#################################################
#   Shiny App around the UDPipe NLP workflow    #
#################################################

#Team Name:
# Pooja Arora (RollNo. 11810083)
# Vikash Singh Negi (RollNo. 11810048)

library(udpipe)
library(textrank)
library(lattice)
library(igraph)
library(ggraph)
library(ggplot2)
library(wordcloud)
library(stringr)
library(igraph)
library(ggraph)
library(ggplot2)


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
      checkboxGroupInput("post", label = h3("Part-of-Speech Tags (XPOS)"), 
                         choices = list("Adjective (JJ)" = "adjective", "Noun(NN)" = "noun", 
                                        "Proper Noun (NNP)" = "properNoun", "Adverb (RB)"= "adverb", "Verb (VB)" ="verb"),
                         selected = c("adjective","noun", "properNoun")),
                         hr(),
                        fluidRow(column(3, verbatimTextOutput("value"))),
      
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

                  tabPanel("Cooccurance",

                           plotOutput("cooccurance"))

                  
      ) # end of tabsetPanel
    )# end of main panel
  ) # end of sidebarLayout
)  # end if fluidPage
) # end of UI


