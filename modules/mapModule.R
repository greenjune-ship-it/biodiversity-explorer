MapModule <- R6::R6Class(
  classname = "MapModule",
  inherit = TidyModule,
  private = list(
    .defaultSpeciesVernacularName = NULL,
    .defaultSpeciesScientificName = NULL
  ),
  public = list(
    initialize = function(...) {
      super$initialize(...)

      # self$definePort({
      #   # inputs
      #   self$addInputPort(
      #     name = "bins",
      #     description = "",
      #     sample = ""
      #   )
      #   # outputs
      #   self$addOutputPort(
      #     name = "test",
      #     description = "Object of class MapModule",
      #     sample = ""
      #   )
      # })

    },
    ui = function() {
      tagList(
        tags$div(
          sliderInput(inputId = self$ns("bins"),
                      label = "Number of bins:",
                      min = 1,
                      max = 50,
                      value = 30)
        ),
        tags$div(
          plotOutput(outputId = self$ns("distPlot"))
        )
      )
    },
    server = function(input, output, session) {

      # Don't remove the line below
      super$server(input, output, session)

      observe({
        print(input$bins)
      })

      bins <- reactive({
        seq(min(faithful$waiting), max(faithful$waiting), length.out = input$bins + 1)
      })

      output$distPlot <- renderPlot({
        x <- faithful$waiting
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        hist(x, breaks = bins, col = "#75AADB", border = "white",
             xlab = "Waiting time to next eruption (in mins)",
             main = "Histogram of waiting times")

      })

    }
  )
)