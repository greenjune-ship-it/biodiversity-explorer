navbarPage("Biodiversity Explorer",
           tabPanel("Map",
                    testModule$ui()),
           tabPanel("About"),
           tabPanel(
             "Test",
             mapModule$ui()
           )
)