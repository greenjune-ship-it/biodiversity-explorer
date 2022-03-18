MapModule <- R6::R6Class(
  classname = "MapModule",
  inherit = TidyModule,
  private = list(
    .dataToDisplay = NULL,
    .defaultSpeciesVernacularName = NULL,
    .defaultSpeciesScientificName = NULL
  ),
  public = list(
    initialize = function(...) {
      super$initialize(...)

      # Ports definition starts here
      self$definePort({
        # Inputs
        self$addInputPort(
          name = "eventDataRange",
          description = "Data from range of observation dates",
          sample = ""
        )
      })
    },
    ui = function() {
      tagList(
        tags$div(leafletOutput(self$ns("map"), width = "100%", height = 600))
      )
    },
    server = function(input, output, session) {
      # Don't remove the line below
      super$server(input, output, session)

      output$map <- renderLeaflet({
        leaflet(data) %>%
          addTiles() %>%
          fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
      })

      observe({
        data <- self$execInput("eventDataRange")
        req(data)

        leafletProxy("map", data = data) %>%
          clearShapes() %>%
          addCircles(lng = ~long,
                     lat = ~lat,
                     color = "#ffb482",
                     fillOpacity = 0.7)
      })

    }
  )
)