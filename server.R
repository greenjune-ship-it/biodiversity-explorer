function(input, output, session) {
  sliderInputModule$callModule()
  mapModule$callModule()

  # pass output of sliderInput to Map
  observe({
    sliderInputModule %1>1% mapModule
  })

}