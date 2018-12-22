#################################################
#   Shiny App around the UDPipe NLP workflow    #
#################################################

#Team Name:
# Pooja Arora (RollNo. 11810083)
# Vikash Singh Negi (RollNo. 11810048)

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  set.seed=2092014  
  options(shiny.maxRequestSize=30*1024^2)
  
  #Taking input data file from the user
  TextInput <- reactive({
    #Return NULL if no input text recieved
    if (is.null(input$file)) {return(NULL)}
    else {
      #Reading input text file
      Document = readLines(input$file$datapath)
      return(Document)}
  })
  
  #Taking udpipe model input data file from the user
  ModelFile <- reactive({
    #Return NULL if no input udpipe model recieved
    if (is.null(input$modelFile)) {return(NULL)}
    else {
      #Reading input udpipe model file
      model = udpipe_load_model(file=input$modelFile$datapath)
      x <- udpipe_annotate(model, x = as.character(TextInput())) 
      x <- as.data.frame(x)
      return(x)}
  })

  # Plotting the Co-occurrence graph for the input text file and the udpipe model
  output$cooccurance <- renderPlot({
    # For executing on Hindi input udpipe model
    windowsFonts(devanew=windowsFont("Devanagari new normal"))
    
      # Reaading the checkbox group selection of XPOS from the user
    inputSelection <- input$post
    inputText <-  as.character(TextInput())
     
    model = udpipe_load_model(file=input$modelFile$datapath)
    x <- udpipe_annotate(model, x = inputText, doc_id = seq_along(inputText))
    x <- as.data.frame(x)

    # Sentence Co-occurrences for the selected data from the checkbox group 
    inputCooc <- cooccurrence(   
      x <- subset(x, x$xpos %in% inputSelection), # This is filtering as per the inputSelection of XPOS from the checkbox group
      term = "lemma", 
      group = c("doc_id", "paragraph_id", "sentence_id")) 
    
    # Visualising co-occurrences using a network plot
    wordsNetwork <- head(inputCooc, 50)
    wordsNetwork <- igraph::graph_from_data_frame(wordsNetwork) 
    
    ggraph(wordsNetwork, layout = "fr") +  
      
      geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
      geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
      
      theme_graph(base_family = "Arial Narrow") +  
      theme(legend.position = "none") +
      
      labs(title = "Cooccurrences within 3 words distance")
  })
  
  
  # Plotting the word cloud for english udpipe model
  output$wordCloudXpos <- renderPlot({
    # For executing on Hindi input udpipe model
     windowsFonts(devanew=windowsFont("Devanagari new normal"))
    
    # Reaading the checkbox group selection of XPOS from the user
    inputSelection <- input$post
    inputText <-  as.character(TextInput())
    
    model = udpipe_load_model(file=input$modelFile$datapath)
    x <- udpipe_annotate(model, x = inputText, doc_id = seq_along(inputText))
    x <- as.data.frame(x)
    #Getting all the noun xpos from the input model
    allNoun = x %>% subset(., xpos %in% "NN"); allNoun$token[1:20]
    topNoun = txt_freq(all_nouns$lemma)
    
    #Ploting the word cloud
    wordcloud(words = topNoun$key, 
              freq = topNoun$freq, 
              min.freq = 2, 
              max.words = 100,
              random.order = FALSE, 
              colors = brewer.pal(6, "Dark2"))

  })
  
  
  # Plotting the Co-occurrence graph for the input text file and the non- english udpipe model
  output$cooccurance1 <- renderPlot({

    # Reaading the checkbox group selection of UPOS from the user
    inputSelection <- input$upost
    inputText <-  as.character(TextInput())
    
    model = udpipe_load_model(file=input$modelFile$datapath)
    x <- udpipe_annotate(model, x = inputText, doc_id = seq_along(inputText))
    x <- as.data.frame(x)
    
    # Sentence Co-occurrences for the selected data from the checkbox group 
    inputCooc <- cooccurrence(   
      x <- subset(x, x$upos %in% inputSelection), # This is filtering as per the inputSelection of XPOS from the checkbox group
      term = "lemma", 
      group = c("doc_id", "paragraph_id", "sentence_id")) 
    
    # Visualising co-occurrences using a network plot
    wordsNetwork <- head(inputCooc, 50)
    wordsNetwork <- igraph::graph_from_data_frame(wordsNetwork) 
    
    ggraph(wordsNetwork, layout = "fr") +  
      
      geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
      geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
      
      theme_graph(base_family = "Arial Narrow") +  
      theme(legend.position = "none") +
      
      labs(title = "Cooccurrences within 3 words distance")
  })

  # Plotting the word cloud for english udpipe model
  output$wordCloudUpos <- renderPlot({

    # Reaading the checkbox group selection of XPOS from the user
    inputSelection <- input$post
    inputText <-  as.character(TextInput())
    
    model = udpipe_load_model(file=input$modelFile$datapath)
    x <- udpipe_annotate(model, x = inputText, doc_id = seq_along(inputText))
    x <- as.data.frame(x)
    #Getting all the noun xpos from the input model
    allNoun = x %>% subset(., xpos %in% "NOUN"); allNoun$token[1:20]
    topNoun = txt_freq(all_nouns$lemma)
    
    #Ploting the word cloud
    wordcloud(words = topNoun$key, 
              freq = topNoun$freq, 
              min.freq = 2, 
              max.words = 100,
              random.order = FALSE, 
              colors = brewer.pal(6, "Dark2"))
    
  })
  
  #Method to download the dataset
  output$downloadDataSet <- downloadHandler(
    filename = function() { 
      "amazon nokia lumia reviews.txt" 
      },
    content = function(file) {
      writeLines(readLines("data/amazon nokia lumia reviews.txt"), file)
    })
  
})
