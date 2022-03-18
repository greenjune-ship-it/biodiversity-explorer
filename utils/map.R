library(data.table)
library(dplyr)
library(shiny)
library(leaflet)
library(RColorBrewer)
library(zoo)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                sliderInput("range", "eventDate", min = min(data$eventDate),
                            max = max(data$eventDate),
                            value = c(min(data$eventDate), max(data$eventDate))
                ),
                selectInput("colors", "Color Scheme",

                            rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
                ),
                checkboxInput("legend", "Show legend", TRUE)
  )
)

server <- function(input, output, session) {

  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    data[eventDate >= input$range[1] & eventDate <= input$range[2]]
  })

  # colorpal <- reactive({
  #   colorNumeric(input$colors, data$eventDate)
  # })

  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(data) %>%
      addTiles() %>%
      fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
  })

  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    # pal <- colorpal()

    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addCircles(fillOpacity = 0.7
      )
  })

  # Use a separate observer to recreate the legend as needed.
  # observe({
  #   proxy <- leafletProxy("map", data = data)
  #
  #   # Remove any existing legend, and only if the legend is
  #   # enabled, create a new one.
  #   proxy %>% clearControls()
  #   if (input$legend) {
  #     pal <- colorpal()
  #     proxy %>% addLegend(position = "bottomright",
  #       pal = pal, values = ~mag
  #     )
  #   }
  # })
}

shinyApp(ui, server)