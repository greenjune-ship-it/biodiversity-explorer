fluidPage(
  titlePanel("Biodiversity Explorer"),
  sidebarLayout(
    sidebarPanel(
      sliderInputModule$ui(),
      width = 3
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Map", mapModule$ui()),
                  tabPanel("About", aboutModule$ui()
                  )
      ),
      width = 8
    )
  )
)