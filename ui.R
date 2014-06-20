library(shiny)

# Define UI 
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel('EarthQuakes: A Global View'),
    
    # Sidebar with controls to select the year to plot on map
    sidebarPanel(
        
        h3('Choose how you want to filter the map results:', style = "color:#00A37A"),
        checkboxGroupInput("checkbox", "Choose how you want to filter the map results:", c("By Year", "By Date"), selected = "By Year"),
        h4('Select the year to filter by:', style = "color:#FF7519"),
        sliderInput("year","", 1974, 2013, 2010, step = 1, format = "####"),
        h4('Select the date range to filter by:', style = "color:#FF7519"),
        dateInput("start_date", "Start Date:", "2010-01-01", min = "1974-01-01", max = "2013-12-31"),
        dateInput("end_date", "End Date:", "2010-12-31", min = "1974-01-01", max = "2013-12-31"),
        h4('Select the the bounding box to filter by:', style = "color:#FF7519"),
        p("(For a global map select -179, -82, 179, 82)"),
        numericInput("left", "Left / Min Longitude:", -179, min = -179, max = 0, step = 1),
        numericInput("bottom", "Bottom / Min Latitude:",  -82, min = -82, max = 0, step = 1),
        numericInput("right", "Right / Max Longitude:",  179, min = 0, max = 179, step = 1),
        numericInput("top", "Top / Max Latitude:",  82, min = 0, max = 82, step = 1),
        h4('Set the zoom range of the map:', style = "color:#FF7519"),
        sliderInput("zoom", "", 1, 10, 1, step = 1),
        p("WARNING: Setting a high zoom level will take a while to render"),
        actionButton("goButton", "Update Map")
        
    ),
    
    # Show the caption and plot of the requested variable on map
    mainPanel(
        textOutput("average"),
        textOutput("count"),
        textOutput("worst"),
        plotOutput("hist"),
        textOutput("mapYear"),
        p("(Click 'Update Map' to refresh the map)"),
        plotOutput("mapPlot")
    )
))