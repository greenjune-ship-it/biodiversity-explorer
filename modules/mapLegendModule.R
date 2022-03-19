MapLegendModule <- R6::R6Class(
  classname = "MapLegendModule",
  inherit = TidyModule,
  private = list(
  ),
  public = list(

    initialize = function(...) {
      super$initialize(...)
    },
    ui = function() {
      tagList(
      )
    },
    server = function(input, output, session) {
      # Don't remove the line below
      super$server(input, output, session)

    }
  )
)