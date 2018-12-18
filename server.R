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
  
  TextInput <- reactive({
    if (is.null(input$file)) {return(NULL)}
    else {
      Document = readLines(input$file$datapath)
      return(Document)}
  })
  
  ModelFile <- reactive({
    if (is.null(input$modelFile)) {return(NULL)}
    else {
      #  datasetClean  =  str_replace_all(dataset, "<.*?>", "")
      model = udpipe_load_model(file=input$modelFile$datapath)
      x <- udpipe_annotate(model, x = as.character(TextInput())) 
      x <- as.data.frame(x)
      return(x)}
  })

  output$cooccurance <- renderPlot({
      inputSelection <- input$post
      inputText <-  as.character(TextInput())
     
      model = udpipe_load_model(file=input$modelFile$datapath)
      x <- udpipe_annotate(model, x = inputText, doc_id = seq_along(inputText))
      x <- as.data.frame(x)

    nokia_cooc <- cooccurrence(   
      x <- subset(x, x$xpos %in% inputSelection), 
      term = "lemma", 
      group = c("doc_id", "paragraph_id", "sentence_id")) 
    wordnetwork <- head(nokia_cooc, 50)
    wordnetwork <- igraph::graph_from_data_frame(wordnetwork) 
    
    ggraph(wordnetwork, layout = "fr") +  
      
      geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
      geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
      
      theme_graph(base_family = "Arial Narrow") +  
      theme(legend.position = "none") +
      
      labs(title = "Cooccurrences within 3 words distance")
  })
})
