function(input, output, session) {
  sliderInputModule$callModule()
  mapModule$callModule()
  mapLegendModule$callModule()

  # pass arguments via ports
  observe({
    sliderInputModule %1>1% mapModule
    sliderInputModule %2>2% mapModule
  })

}