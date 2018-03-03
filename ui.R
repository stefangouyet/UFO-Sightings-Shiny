library(shiny)
library(ggmap)
library(mapproj)
library(dplyr)
library(leaflet)
library(data.table)

shinyUI(fluidPage(
  
  
  titlePanel("A Sample of UFO Sightings (1949-Present)"),
  tags$h2("by Stefan Gouyet"),
  tags$h6("This Shiny application provides an interactive visualization of UFO Sightings around the world. The data 
          was gathered by the National UFO Reporting Center (NUFORC) and was downloaded on Kaggle.com."),

  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "shape",label="Filter by Shape", choices = c("Light" = "light","Triangle" = "triangle",
                                                                         "Circle" = "circle", "Egg" = "egg",
                                                                         "Fireball"= "fireball","Sphere"= "sphere",
                                                                         "Chevron" = "chevron", "Diamond" = "diamond", "Disk"= "disk",
                                                                         "Oval"  = "oval","Teardrop"="teardrop",
                                                                         "Flash" = "flash", "Cigar" = "cigar", "Formation" = "formation",
                                                                         "Changing" = "changing"),
                  selected = "light"),
      selectInput(inputId = "Zoom", label = "Edit Map Zoom", choices = c("World", "North America", "Europe","Africa",
                                                                        "South America",
                                                                        "Asia","Oceania"),
                  selected="World"),
      sliderInput(inputId = "sample", label = "Sample Size", min=1000,max=10000,value = 5000),
    
    actionButton(inputId = "update",label = "Update")),
    mainPanel(
      leafletOutput('mymap'),
      br(),
      br(),
      dataTableOutput('table')
    )
    
  )))