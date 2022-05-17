library(shiny)
library(bio3d)
# use the below options code if you wish to increase the file input limit, in this example file input limit is increased from 5MB to 9MB
# options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input,output) {
  
  ## input$file is a data frame and contains the details around the name, size and temp location of the files uploaded
  # this reactive output display the content of the input$file dataframe
  output$filedf <- renderTable({
    if(is.null(input$file)){return ()}
    input$file # the file input data frame object that contains the file attributes
  })
  
  # Extract the file path for file
  output$filedf2 <- renderTable({
    if(is.null(input$file)){return ()}
    input$file$datapath # the file input data frame object that contains the file attributes
  })
  
  ## Below code to display the structure of the input file object
  output$fileob <- renderPrint({
    if(is.null(input$file)){return ()}
    str(input$file)
  })
  
  ## Side bar select input widget coming through renderUI()
  # Following code displays the select input widget with the list of file loaded by the user
  #output$selectfile <- renderUI({
   # if(is.null(input$file)) {return()}
    #list(hr(), 
     #    helpText("Select the files for which you need to see data and summary stats"),
      #   selectInput("Select", "Select", choices=input$file$name)
    #)
    
#  })
  
  ## Dataset code ##
  # This reactive output contains the dataset and display the dataset in table format
  output$run <- renderTable({ 
    #if(is.null(input$file)){return()}
    system("bash /media/ajay/e64e5c93-92d9-4629-a905-5f74efd31865/ajay/Documents/harry_maan/R_shiny/topology_maker/Data/topology_maker.sh > job_top.txt")
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("output", "tar", sep = ".")
    },
    content = function(file) {
      tar(file, "./mytar.tar.gz")
    }
  )  
  ## MainPanel tabset renderUI code ##
  # the following renderUI is used to dynamically generate the tabsets when the file is loaded. 
  # Until the file is loaded, app will not show the tabset.
  output$tb <- renderUI({
    #if(is.null(input$file)) {return()}
    #else
      tabsetPanel(
        tabPanel("Input File Object DF ", tableOutput("filedf"), tableOutput("filedf2")),
        tabPanel("Input File Object Structure", verbatimTextOutput("fileob")),
        tabPanel("Run", tableOutput("run"))
        )
  })
})

