library(shiny)
library(ggplot2)
library(OpenStreetMap)

# Read in data
data<-read.csv("world_quakes_1970_2013.csv", header = TRUE)
data<- subset(data, select = c(time, latitude, longitude, depth, mag, place))
data$time<- as.Date(data$time)
names(data)<-c("time", "latitude", "longitude", "depth", "magnitude", "place")
data$year = as.numeric(substr(data$time, 1,4))



# Main function to subset the data based on the year / date and bounding box
getPoints<-function(checkbox, year, start_date, end_date, left, bottom, right, top){
    
    # Subset by date
    if (checkbox == "By Year") {
        sub<-data[grep(year, data$time),]
    } else if (checkbox == "By Date") {
        sub<-subset(data, start_date <= data$time)
        sub<-subset(sub, end_date >= sub$time)
    } else # Default to year
        sub<-data[grep(year, data$time),]
    
    # Subset by bounding box
    sub<-subset(sub, left <= sub$longitude)
    sub<-subset(sub, right >= sub$longitude)
    sub<-subset(sub, bottom <= sub$latitude)
    sub<-subset(sub, top >= sub$latitude)
    
}


shinyServer(
    function(input,output){
            sub<-reactive({getPoints(input$checkbox, input$year, input$start_date, input$end_date,
                       input$left, input$bottom, input$right, input$top)})
            output$count<-renderText({
                paste("Total Earthquakes: ", nrow(sub()))
                })
            output$average<-renderText({
                paste("Average magnitude", round(mean(sub()$magnitude),2))
                })
            output$worst<-renderText({
                paste("Location of Worst (highest magnitude) earthquake: ", sub()$place[which(sub()$magnitude == max(sub()$magnitude, na.rm = TRUE))])
            })
            output$hist<-renderPlot({
                hist(data$year, breaks = 50, xlab = "Year", ylab = "Number of EarthQuakes", main = "")
                select<-input$year
                lines(c(select,select), c(0,5000), col = "#FF7519", lwd = 5)
            })
            output$mapYear<-renderText({ 
                input$goButton
                isolate(paste("The current map shows points for the year: ",input$year))
            })
            output$mapPlot <- renderPlot({
                input$goButton
                isolate(map <- openmap(c(input$top,input$left),c(input$bottom,input$right),zoom=input$zoom))
                isolate(map <- openproj(map))
                isolate(plot(autoplot(map) + 
                         xlab("Longitude") + ylab("Latitude") + 
                         geom_point(aes(x=longitude,
                                        y=latitude, 
                                        colour = magnitude,
                                        size = magnitude,
                                        alpha = 0.5), 
                                    data = sub()) + 
                         scale_colour_gradient(low = "yellow", high = "red")
                     ))
            })
            
    }
)