library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)

#Heres where we load our data.

project_data<-read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-sara-mustredr09/main/Juvenile_Justice_Dashboard_-_HS_Completion.csv?token=GHSAT0AAAAAABQIEWSA6BKJCPJ3VN3C5VHSYQYGLCA")
avg_pct_offenders<-read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-group6-be/main/avg_pct_offenders.csv")
#Chart 1 



# SUMMARY VALUES----------------------------------------

# Proportion of not justice involved w/HS Diploma
all_justice_not_in <- project_data %>% filter(JJOffenderType == 'Not Justice Involved') %>% 
  count()

HS_Diploma_nojustice <- project_data %>% filter(JJOffenderType == 'Not Justice Involved') %>% 
  filter(HSOutcome == 'HS Diploma') %>% count()

prop_HSdiploma_nojustice <- round((HS_Diploma_nojustice / all_justice_not_in), digits = 2)


# Proportion of dropouts w/justice involvement
all_justice_in <- project_data %>% filter(JJOffenderType != 'Not Justice Involved') %>% 
  count()

dropouts_w_justice <- project_data %>% filter(JJOffenderType != 'Not Justice Involved') %>% 
  filter(HSOutcome == 'Dropout') %>% count()

prop_dropouts_justice_in <- round((dropouts_w_justice / all_justice_in), digits = 2)



#Server function

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
  
# Chart 2 output
  output$chart2 <- renderPlotly({
    
    pct_graduated <- project_data %>% 
      filter(HSOutcome == input$outcome_id) %>% 
      filter(JJOffenderType == input$offender_id) %>%
      filter(DemographicValue == input$demo_id)
    
    p1 <- ggplot(data = pct_graduated) + 
      geom_line(mapping = aes(y = Pct, x = CohortYearTTL, color = DemographicValue)) + 
      labs(title = "High School Outcome by Demographic", x = "Year", y = "Percent With Diploma", caption = "Data: data.wa.gov")
    
    my_plotly_plot <- ggplotly(p1) 
    return(my_plotly_plot)
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
  
  output$SummaryValues <- renderText({
    paste0("In the analysis, there is not a big difference among the different demographic groups in percentage of justice involved and justice not involved. And the proportion 0.333333333333333 (about 0.33) of not justice involved with HS Diploma (a supposed positive outcome) and the proportion 0.333333333333333(about 0.33) of justice involved with dropouts are exactly the same. As for the data of justice involvement, the only obvious difference is that Native Hawaiian and Other Pacific Islander have a higher percent of justice involvement (about 0.41). And in their academic outcomes, they have a relatively high percent of HS Diploma and a relatively low percent of dropouts (but not the extremes). Moreover, is noticeable that Asians have higher percentages of HS Diplomas, which is a percentage of (about 0.76), while they also have the lowest percent of dropouts (about 0.2). 


However, like what it is stated above, it is reasonable to speculate that their academic outcome might also be influenced by other elements, such as race and ethnicity. This can explain the influence of the school-to-prison pipeline, which is a “growing pattern of tracking students out of educational institutions, primarily via ―zero tolerance policies, and tracking them directly and/or indirectly into the juvenile and adult criminal justice systems.” The school-to-prison pipeline disproportionately affects Black and brown students the most, given stereotypes about their behavior. Therefore, they are punished more harshly than their white and Asian counterparts. ")
})
}

