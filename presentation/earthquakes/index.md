---
title       : "EarthQuakes: A Global View"
subtitle    : "Displaying the global distribution of Earthquakes from 1774 to 2013"
author      : Michael Reed
job         : 
framework   : io2012       # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## Introduction

The goal of this application was to both __summarise__ and __display__ data representing reported earthquakes around the globe. 

* __Easy to use__ with simple inputs such as sliders and checkboxes
* __Interactive__ with dynamic reactive output
* __Intuitive plots__  with points displayed on a global map

--- .class #id

## Data

The data for this application was provided by the USGS Earthquakes Hazard Program, specifically the Earthquake Archive Catalog available at :

http://earthquake.usgs.gov/earthquakes/search/

The data selected for the application represents all recorded earthquakes around the globe of a magnitude of 5 or higher, during the period 01/01/1974 to 31/12/2013. A subset of the data is created based on the year or daterange selected, depending on which checkbox is selected.

## Calculations

The following summary calculations are made:

* Count - The total number of earthquakes during the selected time period
* Mean - The average magnitude of earthquakes during the selected time period
* Worst - The place/location of the highest magnitude earthquake during the selected time period. 

--- .class #id

## Interactivity

An chart is shown that represents a histogram of the earthquakes per year, with an interactive line which moves as the year being selected on the slider changes:





```r
hist(data$year, breaks = 50, xlab = "Year", ylab = "Number of EarthQuakes", 
    main = "")
lines(c(2000, 2000), c(0, 5000), col = "#FF7519", lwd = 5)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


--- .class #id

## Mapping

A Bounding Box is used to filter the data and select the size of the plot

OpenStreetMap:

* Get a map using the `openmap()` function
* Project the map to the right coordinate system using `openproj()`
* Plot the map using `autoplot()` (a ggplot2 function which allows different objects)
* Plot the lattitude and longitude points on the map using `geom_point()`

The points are then coloured and sized based on the magnitude of the earthquake, with small yellow points representing low mangitude earthquakes (5) and large red points representing high mangitude earthquakes (10).





