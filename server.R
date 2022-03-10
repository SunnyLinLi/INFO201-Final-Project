library(tidyverse)
library(shiny)
library(lintr)
library(styler)
library(plotly)

#Heres where we load our data.

project_data<-read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-sara-mustredr09/main/Juvenile_Justice_Dashboard_-_HS_Completion.csv?token=GHSAT0AAAAAABQIEWSA6BKJCPJ3VN3C5VHSYQYGLCA")

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

categories<-c("American Indian or Alaska Native","Asian","Black or African American","Multiple Races (Details Unknown)","Native Hawaiian and Other Pacific Islander","Spanish/Hispanic/Latino","White")

pct_offenders <-project_data%>%
  filter(DemographicValue%in%categories)

pct_offenders <-pct_offenders%>%
  filter(DemographicValue%in%input$user_category)

# Find  a way to pick by year.

pct_offenders <-pct_offenders%>%
  filter(CohortYearTTL%in%input$user_category2)

pct_offenders <-pct_offenders%>%
  filter(JJOffenderType%in%input$user_category3)

# Make chart 3.

chart3 <- ggplot(data = pct_offenders) +
  geom_col(mapping = aes(x = HSOutcome, 
                         y = Pct, 
                         fill = DemographicValue), position="dodge")+
  labs(title = "Outcomes per Racial Group", x = "Outcome", y = "Percentage")

# Make interactive plot
my_plotly_plot <- ggplotly(chart3) 
return(my_plotly_plot)

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
  
#Chart 3 output
  
  output$chart3 <- renderPlotly({
    
    categories<-c("American Indian or Alaska Native","Asian","Black or African American","Multiple Races (Details Unknown)","Native Hawaiian and Other Pacific Islander","Spanish/Hispanic/Latino","White")
    
    pct_offenders <-project_data%>%
      filter(DemographicValue%in%categories)
    
    pct_offenders <-pct_offenders%>%
      filter(DemographicValue%in%input$user_category)
    
    # Find  a way to pick by year.
    
    pct_offenders <-pct_offenders%>%
      filter(CohortYearTTL%in%input$user_category2)
    
    pct_offenders <-pct_offenders%>%
      filter(JJOffenderType%in%input$user_category3)
    
    # Make a scatter plot
    chart3 <- ggplot(data = pct_offenders) +
      geom_col(mapping = aes(x = HSOutcome, 
                             y = Pct, 
                             fill = DemographicValue), position="dodge")+
      labs(title = "Outcomes per Racial Group", x = "Outcome", y = "Percentage")
    
    # Make interactive plot
    my_plotly_plot <- ggplotly(chart3) 
    return(my_plotly_plot)
  })
}