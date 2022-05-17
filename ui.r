library(shiny)
shinyUI(fluidPage(
  titlePanel("Topology Maker - File Input - Select bash file"),
  sidebarLayout(
    sidebarPanel(
      
      fileInput("file","Upload the file", multiple = TRUE), # fileinput() function is used to get the file upload contorl option
      helpText("Default max. file size is 5MB"),
      downloadButton("downloadData", "Download"),
      uiOutput("selectfile")
    ),
    mainPanel(
      uiOutput("tb")
      
    )
    
  )
))
