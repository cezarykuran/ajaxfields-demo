library(shiny)

ui <- fixedPage(
  shiny::div(
    shiny::titlePanel("NCBI (ajaxfields) test application"),
    shiny::hr(),
    
    shiny::h3('Engine elasticsearch'),
    shiny::div(class='row',
       shiny::div(class='col-md-6', ajaxfields::draw('elasticsearch', 'NCBI Taxonomy')),
       shiny::div(class='col-md-6', shiny::tableOutput('elasticsearchDump'))
    ),

    shiny::h3('Engine simple (MariaDb)'),
    shiny::div(class='row',
      shiny::div(class='col-md-6', ajaxfields::draw('simple', 'NCBI Taxonomy')),
      shiny::div(class='col-md-6', shiny::tableOutput('simpleDump'))
    )
  )
)

server <- function(input, output, session) {
  simpleData <- shiny::callModule(ajaxfields::observer, "simple")
  ajaxfields::loadEngine(session, 'simple', 'simple', 'https://ncbi.dafne.prv.ovh', 500)
  
  elasticsearchData <- shiny::callModule(ajaxfields::observer, "elasticsearch")
  ajaxfields::loadEngine(session, 'elasticsearch', 'es', 'http://lucene.dafne.prv.ovh/ncbi/_search', 500)
  
  shiny::observe({
      output$simpleDump <- renderTable(simpleData())
      output$elasticsearchDump <- renderTable(elasticsearchData())
  })
}
shinyApp(ui = ui, server = server)

