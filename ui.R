#################################################
#   Shiny App around the UDPipe NLP workflow    #
#################################################

#Team Name:
# Pooja Arora (RollNo. 11810083)
# Vikash Singh Negi (RollNo. 11810048)


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
      fileInput("modelFile", "Upload trained udpipe model"),

      #Check box group to select the xpos for english
      checkboxGroupInput("post", label = h3("Part-of-Speech Tags (XPOS)"), 
                         choices = list("Adjective (JJ)" = "JJ", "Noun(NN)" = "NN", 
                                        "Proper Noun (NNP)" = "NNP", "Adverb (RB)"= "RB", "Verb (VB)" ="VB"),
                         selected = c("JJ","NN", "NNP")),
                         hr(),
      
      #Check box group to select the upos for non-english
      checkboxGroupInput("upost", label = h3("Part-of-Speech Tags (UPOS) for non-english"), 
                         choices = list("Adjective (ADJ)" = "ADJ", "Noun(NOUN)" = "NOUN", 
                                        "Proper Noun (PRON)" = "PRON", "Adverb (RB)"= "RB", "Verb (VERB)" ="VERB"),
                         selected = c("ADJ","NOUN", "PRON")),
      hr(),
                        fluidRow(column(3, verbatimTextOutput("value"))),
      
      submitButton(text = "Apply Changes", icon("refresh"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  
                  tabPanel("Overview",
                           h4(p("Data input")),
                           p("This app supports only text file as input file",align="justify"),
                           p("This app supports all language udipipe model, presently tested on English, Hindi and Spanish language only",align="justify"),
                           p("Please refer to the link below for sample text file."),
                           a(href="https://github.com/poojaarora014/Shiny-App/blob/master/data/amazon%20nokia%20lumia%20reviews.txt"
                             ,"Sample data input file"),   
                           p("Please refer to the link below for sample udpipe model in English"),
                           a(href=" https://github.com/poojaarora014/Shiny-App/blob/master/data/english-ud-2.0-170801.udpipe"
                             ,"Sample udpipe model in English"),  
                          
                           br(),
                           h4('How to use this App'),
                           p('To use this app, click on', 
                             span(strong("Upload Input Text File(.txt format)")),
                             'and upload the text data file.',
                             span(strong("Upload trained udpipe model")),
                              'To upload the trained udpipe model file.You can also change',span(strong("Part-Of-Speech Tags")),  
                             'by selecting from the Checkbox on the left panel.' ),
                           p('For english and non- english udpipe model Please goto appropriate tab i.e. 3rd and 4th respectively '),
                            p('App Contributors:',span(strong("Pooja Arora (RollNo. 11810083)")), span(strong("Vikash Singh Negi (RollNo. 11810048)")))),
                  
                  tabPanel("Example Dataset", h4(p("Download Sample text file")), 
                           downloadButton('downloadDataSet', 'Download amazon nokia lumia reviews txt file'),br(),br(),
                           p("Please note that downloaded file will not work with RStudio interface. Download will work only in web-browsers. Please open this Shiny App in a web-browser and download the example data set. For opening this dataset file in web-browser click on \"Open in Browser\" as shown below:"),
                           img(src = "image.png")),
                  
                  tabPanel("Cooccurance Plot for english input udpipe model",
                           plotOutput("cooccurance")),
                  
                  tabPanel("Word Cloud Plot for english input udpipe model",
                           plotOutput("wordCloudXpos")),
                  
                  tabPanel("Cooccurance Plot for non-english udpipe model",
                           plotOutput("cooccurance1")),
                  
                  tabPanel("Word Cloud Plot for non-english udpipe model",
                           plotOutput("wordCloudUpos"))

                  
      ) # end of tabsetPanel
    )# end of main panel
  ) # end of sidebarLayout
)  # end if fluidPage
) # end of UI


