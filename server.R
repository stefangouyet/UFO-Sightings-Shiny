library(shiny)
library(ggmap)
library(mapproj)
library(dplyr)
library(data.table)
library(leaflet)


#read UFO sightings dataset; latitude changed to numeric (initially seen as integer)
df<-read.csv("scrubbed.csv")
df$latitude2 <- as.character(df$latitude)
df$latitude3 <- as.numeric(df$latitude2)



shinyServer(function(input, output) {
  
  data <- reactive({
    req(input$sample)
    
  })
  
  
  observeEvent(input$update,{
    sampledf <- df %>% sample_n(input$sample) 
    
    if (input$shape == "circle"){
      updated_data <- sampledf %>% filter(shape == "circle")
    }
    else if (input$shape == "triangle"){
      updated_data <- sampledf %>% filter(shape == "triangle")
      
    }  
    
    else if (input$shape == "oval"){
      updated_data <- sampledf %>% filter(shape == "oval")
    }
    
    else if (input$shape == "fireball"){
      updated_data <- sampledf %>% filter(shape == "fireball")
    }
    
    else if (input$shape == "disk"){
      updated_data <- sampledf %>% filter(shape == "disk")
    }
    
    else if (input$shape == "egg"){
      updated_data <- sampledf %>% filter(shape == "egg")
    }
    
    else if (input$shape == "teardrop"){
      updated_data <- sampledf %>% filter(shape == "teardrop")
    }
    
    else if (input$shape == "diamond"){
      updated_data <- sampledf %>% filter(shape == "diamond")
    }
    
    else if (input$shape == "teardrop"){
      updated_data <- sampledf %>% filter(shape == "teardrop")
    }
    
    else if (input$shape == "formation"){
      updated_data <- sampledf %>% filter(shape == "formation")
    }
    
    else if (input$shape == "changing"){
      updated_data <- sampledf %>% filter(shape == "changing")
    }
    
    else if (input$shape == "cigar"){
      updated_data <- sampledf %>% filter(shape == "cigar")
    }
    
    else if (input$shape == "flash"){
      updated_data <- sampledf %>% filter(shape == "flash")
    }
    
    else if (input$shape == "light"){
      updated_data <- sampledf %>% filter(shape == "light")
    }
    
    else if (input$shape == "sphere"){
      updated_data <- sampledf %>% filter(shape == "sphere")
    }
    
    
    else if (input$shape == "chevron"){
      updated_data <- sampledf %>% filter(shape == "chevron")
    }
    
    if (input$Zoom == "Europe"){
      zoom_lat <- 55
      zoom_lng <- 16.3738
      zoom<-3
      
      
    }
    
    else if (input$Zoom == "Africa"){
      zoom_lat <- 4.986977
      zoom_lng <- 24.7
      zoom<-3
      
    }
    
    else if (input$Zoom == "North America"){
      zoom_lat <- 48
      zoom_lng <- -105.255119
      zoom<-3
    }
    
    else if (input$Zoom == "South America"){
      zoom_lat <- -8.783195
      zoom_lng <- -55.491477
      zoom<-3
    }
    
    else if (input$Zoom == "Oceania"){
      zoom_lat <- -22.73591
      zoom_lng <- 140.018765
      zoom<-3
    }
    
    else if (input$Zoom == "Asia"){
      zoom_lat <- 35
      zoom_lng <- 100
      zoom<-3
    }
    
    else if (input$Zoom == "World"){
      zoom_lat <- 0
      zoom_lng <- 40
      zoom<-1
    }
    
    output$mymap <- renderLeaflet({
      leaflet(data=updated_data) %>% addTiles() %>% addMarkers(~longitude,~latitude3, label=~datetime, popup = ~comments) %>% 
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>% 
        setView(zoom_lng,zoom_lat,zoom=zoom)
      
    })
    
    output$table <- renderDataTable({
      table_data <- updated_data %>% select(-c(date.posted,longitude,latitude,latitude2,latitude3,`duration..hours.min.`))
      as.data.table(table_data)})
    
    
  })  
  
})

