SliderInputModule <- R6::R6Class(
  classname = "SliderInputModule",
  inherit = TidyModule,
  private = list(
    .defaultSpeciesVernacularName = NULL,
    .defaultSpeciesScientificName = NULL
  ),
  public = list(
    initialize = function(...) {
      super$initialize(...)

      # Ports definition starts here
      self$definePort({
        # Outputs
        self$addOutputPort(
          name = "eventDataRange",
          description = "Data from range of observation dates",
          sample = ""
        )
      })
    },
    ui = function() {
      tagList(
        tags$div(
          sliderInput(self$ns("eventDateRange"), "Event Date", min = min(data$eventDate),
                      max = max(data$eventDate),
                      value = c(min(data$eventDate), max(data$eventDate))
          )
        )
      )
    },
    server = function(input, output, session) {
      # Don't remove the line below
      super$server(input, output, session)

      filteredData <- reactive({
        data[eventDate >= input$eventDateRange[1] & eventDate <= input$eventDateRange[2]]
      })

      self$assignPort({
        self$updateOutputPort(id = "eventDataRange",
                              output = filteredData)
      })

    }
  )
)