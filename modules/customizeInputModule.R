CustomizeInputModule <- R6::R6Class(
  classname = "CustomizeInputModule",
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
        tags$div(tags$h4(tags$b("Customize view"))),
        br(),
        tags$div(
          sliderInput(
            self$ns("eventDateRange"),
            label = "Event Date",
            min = min(private$.periodRange),
            max = max(private$.periodRange),
            value = c(min(private$.periodRange), max(private$.periodRange))
          )
        ),
        br(),
        tags$div(
          selectizeInput(
            inputId = self$ns("displayedSpecies"),
            label = "Display custom species by name",
            choices = NULL,
            multiple = TRUE,
            width = "200%"
          )
        )
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