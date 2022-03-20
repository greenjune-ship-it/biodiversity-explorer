AboutModule <- R6::R6Class(
  classname = "AboutModule",
  inherit = TidyModule,
  private = list(
  ),
  public = list(

    initialize = function(...) {
      super$initialize(...)
    },
    ui = function() {
      tagList(
        tags$div(
          includeMarkdown("README.md")
        )
      )
    },
    server = function(input, output, session) {
      # Don't remove the line below
      super$server(input, output, session)
    }
  )
)