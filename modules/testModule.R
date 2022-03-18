TestModule <- R6::R6Class(
  classname = "TestModule",
  inherit = TidyModule,
  private = list(
    .defaultSpeciesVernacularName = NULL,
    .defaultSpeciesScientificName = NULL
  ),
  public = list(
    initialize = function(...) {
      super$initialize(...)
    },
    ui = function() {
      tagList(
        # tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
        tags$div(
          sliderInput(self$ns("eventDateRange"), "Event Date", min = min(data$eventDate),
                      max = max(data$eventDate),
                      value = c(min(data$eventDate), max(data$eventDate))
          )
        ),
        tags$div(leafletOutput(self$ns("map")))
      )
    },
    server = function(input, output, session) {
      # Don't remove the line below
      super$server(input, output, session)

      filteredData <- reactive({
        data[eventDate >= input$eventDateRange[1] & eventDate <= input$eventDateRange[2]]
      })

      output$map <- renderLeaflet({
        leaflet(data) %>%
          addTiles() %>%
          fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
      })

      observe({
        leafletProxy("map", data = filteredData()) %>%
          clearShapes() %>%
          addCircles(lng = ~long, lat = ~lat, color = "#ffb482", fillOpacity = 0.7)
      })

    }
  )
)