MapModule <- R6::R6Class(
  classname = "MapModule",
  inherit = TidyModule,
  private = list(
    .wholeDataset = NULL,
    .defaultColumn = "scientificName",
    .accessoryColumn = "vernacularName"
  ),
  public = list(
    filterDatasetByDateRange = function(.data, column, range) {
      .data[get(column) >= range[1] & get(column) <= range[2]]
    },
    filterDatasetBySpecies = function(.data, species) {
      bind_rows(
        .data %>% filter(scientificName %in% species),
        .data %>% filter(vernacularName %in% species)
      )
    },
    arrangeData = function(data, column, range, species) {
      if (is.null(species)) {
        data %>% self$filterDatasetByDateRange(column, range)
      } else {
        data %>%
          self$filterDatasetByDateRange(column, range) %>%
          self$filterDatasetBySpecies(species)
      }
    },
    getValuesFromProxy = function(proxy, column) {
      attr(proxy$x, "leafletData")[[column]]
    },
    modifyLabelFormat = function(values) {
      sep = " / "
      labelFormat(
        suffix = paste0(sep, "(", values, ")"),
      )
    },
    displayDefaultMap = function(proxy) {
      proxy %>%
        addCircles(lng = ~long,
                   lat = ~lat,
                   color = "#FDB462",
                   fillOpacity = 0.7)
    },
    displayCustomizedMap = function(proxy, factpal, mainColumn, accessoryColumn) {
      mainValues <- self$getValuesFromProxy(proxy, mainColumn)
      accessoryValues <- self$getValuesFromProxy(proxy, accessoryColumn)

      proxy %>%
        addCircles(lng = ~long,
                   lat = ~lat,
                   color = ~factpal(mainValues),
                   fillOpacity = 0.7) %>%
        addLegend(pal = factpal,
                  values = mainValues,
                  labFormat = self$modifyLabelFormat(accessoryValues),
                  layerId = "colorLegend",
                  title = "Selected species",
                  position = "bottomright"
        )
    },
    initialize = function(wholeDataset, ...) {
      super$initialize(...)

      private$.wholeDataset <- wholeDataset

      # Ports definition starts here
      self$definePort({
        # port 1
        self$addInputPort(
          name = "eventDataRange",
          description = "Data from range of observation dates",
          sample = ""
        )
        # port 2
        self$addInputPort(
          name = "selectedSpecies",
          description = "Observations by selected species",
          sample = ""
        )
      })
    },
    ui = function() {
      tagList(
        tags$div(
          leafletOutput(self$ns("map"), width = "100%", height = 700) %>%
            shinycssloaders::withSpinner()
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

      displayedDateRange <- reactive({
        self$execInput("eventDataRange")
      })

      # if user does not specify species, we display all species, but selection is null
      displayedSpecies <- reactive({
        self$execInput("selectedSpecies")
      })

      dataToDisplay <- reactiveVal()
      # update value
      observe({
        dataToDisplay(self$arrangeData(data = private$.wholeDataset,
                                       column = "eventDate",
                                       range = displayedDateRange(),
                                       species = displayedSpecies()
        ))
      })

      observeEvent(dataToDisplay(), {

        proxy <- leafletProxy("map", data = dataToDisplay()) %>% clearShapes()
        factpal <- colorFactor(palette = brewer.pal(n = 12, name = "Set3"),
                               dataToDisplay()[[private$.defaultColumn]])

        if (is.null(displayedSpecies())) {
          self$displayDefaultMap(proxy)
        } else {
          self$displayCustomizedMap(proxy, factpal, private$.defaultColumn, private$.accessoryColumn)
        }

      })

    }
  )
)