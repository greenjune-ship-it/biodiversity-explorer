MapModule <- R6::R6Class(
  classname = "MapModule",
  inherit = TidyModule,
  private = list(
    .wholeDataset = NULL
  ),
  public = list(
    filterDatasetByDateRange = function(df, column, range) {
      df[get(column) >= range[1] & get(column) <= range[2]]
    },
    initialize = function(wholeDataset, ...) {
      super$initialize(...)

      private$.wholeDataset <- wholeDataset

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
        tags$div(
          leafletOutput(self$ns("map"), width = "100%", height = 700) %>%
            withSpinner()
        )
      )
    },
    server = function(input, output, session) {
      # Don't remove the line below
      super$server(input, output, session)

      # display all observations initially by default
      output$map <- renderLeaflet({
        leaflet(private$.wholeDataset,
                options = leafletOptions(zoomSnap = 0.5, zoomAnimation = TRUE)) %>%
          addTiles() %>%
          fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat)) %>%
          addCircles(lng = ~long,
                     lat = ~lat,
                     color = "#ffb482",
                     fillOpacity = 0.7)
      })
      #
      displayedDateRange <- reactive({
        self$execInput("eventDataRange")
      })

      observeEvent(displayedDateRange(), {
        data <- self$filterDatasetByDateRange(private$.wholeDataset, "eventDate", displayedDateRange())

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