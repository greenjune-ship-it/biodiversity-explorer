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
                  tabPanel("Table", fluidPage(
                    "Here should be displayed data as DT object, implemented in separate module")
                  )
      ),
      width = 8
    )
  )
)