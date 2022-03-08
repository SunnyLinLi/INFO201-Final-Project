library(tidyverse)
library(shiny)
library(lintr)
library(styler)
library(plotly)

#Heres where we load our data.

#Chart 1 

# Load chart 1 data.

#Make chart 1.

ggplotly(chart1)
return(chart1)

# Chart 2 

# Load chart 2 data.

# Make chart 2.

ggplotly(chart2)
return(chart2)

#Chart 3

# Load chart 3 data.

# Make chart 3.

ggplotly(chart3)
return(chart3)


#Server function!

server <- function(input, output) {
  output$column <- renderPlotly({
    fires_per_month_updated <- fires_per_month %>%
      filter(Name1 == input$column_id)
    
    chart1 <- ggplot(data = dataframe1) +
      geom_col(mapping = aes(x = x_axis, y = y_axis),
               fill = input$color_id) +
      labs(title = "Description of chart 1", 
           x = "x-axis-name", y = "y-axis-name")
  })
  
  output$column <- renderPlotly ({
    chart2data <- main_dataframe %>%
      filter(Name2 == input$column_id)
    
    chart2 <- ggplot(data = dataframe2) +
      geom_line(mapping = aes(x = x_axis, y = y_axis),
                color = input$color_id2) +
      labs(title = "Description of chart 2", 
           x = "x-axis-name", y = "y-axis-name")
  })
  
  output$total_num_fires<- renderPlotly ({
    chart3data <- main_dataframe %>%
      filter(Name3 == input$column_id)
    
    chart3 <- ggplot(data = total_num_fires_updated) +
      geom_col(mapping = aes(x = ArchiveYear, y = total_num_per_year),
               fill = input$color_id3) +
      labs(title = "Description of chart 3", 
           x = "x-axis-name", y = "y-axis-name")
  })
}