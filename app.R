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
      div(class='col-md-6', div(ajaxfields::draw('ncbi', 'simple'))),
      div(class='col-md-6', div(ajaxfields::draw('ncbi2', 'elasticsearch')))
    )
  )
)

server <- function(input, output, session) {
  ncbiData <- callModule(ajaxfields::observer, "ncbi")
  ajaxfields::loadEngine(session, 'ncbi', 'simple', 'https://ncbi.dafne.prv.ovh')
  ncbi2Data <- callModule(ajaxfields::observer, "ncbi2")
  ajaxfields::loadEngine(session, 'ncbi2', 'es', 'http://lucene.dafne.prv.ovh/ncbi/')
  
  observe({
    dput(ncbiData())
    dput(ncbi2Data())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

