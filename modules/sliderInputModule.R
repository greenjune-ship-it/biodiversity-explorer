SliderInputModule <- R6::R6Class(
  classname = "SliderInputModule",
  inherit = TidyModule,
  private = list(
    .periodRange = NULL,
    .vernacularName = NULL,
    .scientificName = NULL
  ),
  public = list(
    initialize = function(periodRange, scientificName, vernacularName, ...) {
      super$initialize(...)

      private$.periodRange <- periodRange
      private$.scientificName <- scientificName
      private$.vernacularName <- vernacularName

      # Ports definition starts here
      self$definePort({

        # port 1
        self$addOutputPort(
          name = "eventDataRange",
          description = "Data from range of observation dates",
          sample = ""
        )
        # port 2
        self$addOutputPort(
          name = "selectedSpecies",
          description = "Observations by selected species",
          sample = ""
        )

      })
    },

    ui = function() {
      tagList(
        tags$div(
          sliderInput(
            self$ns("eventDateRange"),
            label = "Event Date",
            min = min(private$.periodRange),
            max = max(private$.periodRange),
            value = c(min(private$.periodRange), max(private$.periodRange))
          )
        ),
        tags$div(
          tags$style(HTML('#q1 {margin-top: 30px}')),
          selectizeInput(
            inputId = self$ns("displayedSpecies"),
            label = "Display custom species by scientific or vernacular name",
            choices = NULL,
            multiple = TRUE,
          ),
          actionButton(
            inputId = self$ns("clearSelection"),
            label = NULL,
            icon = icon("trash", "fa-sm")
          )
          # style = "display:inline-block; align-items: center;",
        )
        # tags$div(
        #   style = "display:inline-block; align-items: center;"
        #
        # )
      )
    },

    server = function(input, output, session) {
      # Don't remove the line below
      super$server(input, output, session)

      # server-side selectize
      updateSelectizeInput(
        session = session,
        inputId = "displayedSpecies",
        choices = c(private$.scientificName, private$.vernacularName),
        server = TRUE
      )

      self$assignPort({
        # port 1
        self$updateOutputPort(id = "eventDataRange",
                              output = reactive({ input$eventDateRange }))
        # port 2
        self$updateOutputPort(id = "selectedSpecies",
                              output = reactive({ input$displayedSpecies }))
      })

    }
  )
)