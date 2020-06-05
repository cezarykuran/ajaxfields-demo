#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fixedPage(
  div(
    titlePanel("NCBI (ajaxfields) test application"),
    div(class='row',
      div(class='col-md-6', div(ajaxfields::draw('ncbi', 'https://ncbi.dafne.prv.ovh', 'NCBI'))),
      div(class='col-md-6', div(ajaxfields::draw('ncbi2', 'https://ncbi.dafne.prv.ovh', 'NCBI II')))
    )
  )
)

server <- function(input, output) {
  ncbiData <- callModule(ajaxfields::observer, "ncbi")
  ncbi2Data <- callModule(ajaxfields::observer, "ncbi2")
  
  observe({
    dput(ncbiData())
    dput(ncbi2Data())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

