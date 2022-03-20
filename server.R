function(input, output, session) {

  customizeInputModule$callModule()
  mapModule$callModule()

  # pass arguments via ports
  observe({
    customizeInputModule %1>1% mapModule
    customizeInputModule %2>2% mapModule
  })

}