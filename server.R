library(tidyverse)
library(shiny)
library(lintr)
library(styler)
library(plotly)

#Heres where we load our data.

project_data<-read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-sara-mustredr09/main/Juvenile_Justice_Dashboard_-_HS_Completion.csv?token=GHSAT0AAAAAABQIEWSA6BKJCPJ3VN3C5VHSYQYGLCA")

#Chart 1 

# A dodged bar chart showing the high school outcomes for each offender type
# (justice-involved, not justice-involved, juvenile offender, status offender)
avg_pct_offenders <- project_data %>%
  filter(DemographicGroup == "All Students") %>% 
  filter(DemographicValue == "All Students") %>% 
  filter(CohortYearTTL > 2015) %>% 
  rename("Percent_of_Cohort" = "Pct") %>% 
  rename("Justice_Involvement" = "JJOffenderType")


server <- function(input, output) {
  
  output$chart1 <- renderPlotly({
    
    # dataset for chart
    chart1_plot <- avg_pct_offenders %>% 
      filter(Justice_Involvement %in% input$user_justice_choice)
    
    # make plot
    plot <- ggplot(data = chart1_plot) +
      geom_col(
        mapping = aes(x = Justice_Involvement, y = Percent_of_Cohort, fill = HSOutcome), position = "dodge"
      ) + scale_y_continuous(breaks = seq(0, .83, .1)) + facet_wrap(~CohortYearTTL) +
      labs(title = "High School Outcomes for Each Offender Type",
           x = "Justice Involvement Type",
           y = "Percent of Cohort",
           color = "High School Outcomes")
    
    plotly_plot1 <- ggplotly(plot)
    return(plotly_plot1)
  })
  
  output$outcome <- renderText({
    if(input$user_explain == 1){
      return(" If a student does not have a graduation record or a GED record, 
             they are considered to be a dropout.")
    } else if (input$user_explain == 2) {
      return(" If the student does not have a graduation record, 
             the OSPI P210 and SBCTC Completion records are queried to determine if the student has completed a GED.")
    } else {
      return("OSPI P210 indicates the student graduated.")
    }
  })
}


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