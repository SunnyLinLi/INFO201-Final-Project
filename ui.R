library(ggplot2)
library(plotly)
library(bslib)

library(shiny)
#install.packages("htmlwidgets", type = "binary")
#install.packages("DT", type = "binary")
project_data<-read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-sara-mustredr09/main/Juvenile_Justice_Dashboard_-_HS_Completion.csv?token=GHSAT0AAAAAABQIEWSA6BKJCPJ3VN3C5VHSYQYGLCA")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            p("Here is the intro text.")
  )
)

#Chart1 Page

# small widgets

# plot1_tab <- tabPanel(
#   "Educational Outcome and Justice Involvement",
#   fluidPage(theme = bs_theme(bootswatch = "sketchy"),
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(
#         inputId = "user_justice_choice",
#         label = h3("Select an Offender Type"),
#         choices = avg_pct_offenders$Justice_Involvement,
#         selected = "Justice Involved",
#         multiple = TRUE),
# 
#       radioButtons(
#         inputId = "user_explain",
#         label = h5("See the Metric explanation of High School Outcomes (HSOutcome):"),
#         choices = list("Dropout" = 1, "GED" = 2, "HS Diploma" = 3),
#         selected = 1),
#       textOutput(outputId = "outcome")
#     ),
#     mainPanel(
#       plotlyOutput(outputId = "chart1"),
#       p("We wanted to demonstrate the changes over time for the high school outcomes for different types of justice involvement.",
#         "These graphs show the percent for each high school outcome (GED, diploma, and dropout) for each type of justice involvement within different years.",
#         "It is pretty obvious that the most optismistic high school outcome shows on those students who are not justice involved: ",
#         "highest rate of HS Diploma and lowest rate of dropout.")
#     ),
#     p("We wanted to demonstrate the changes over time for the high school outcomes for different types of justice involvement.",
#                 "These graphs show the percent for each high school outcome (GED, diploma, and dropout) for each type of justice involvement within different years.",
#                 "It is pretty obvious that the most optismistic high school outcome shows on those students who are not justice involved: ",
#                 "highest rate of HS Diploma and lowest rate of dropout.")
# 
#   )
# ))
#
# Chart 2
plot2_tab <- tabPanel(
  "Chart 2",
  
  #This is the sidebar.
  sidebarLayout(
    sidebarPanel(
      selectInput("outcome_id",
                  label = "Choose High School Outcome",
                  choices = project_data$HSOutcome,
                  selected = "HS Diploma",
                  multiple = FALSE
      ),
      selectInput("offender_id",
                  label = "Choose Offender Type",
                  choices = project_data$JJOffenderType,
                  selected = "Not Justice Involved",
                  multiple = FALSE
      )
    ),
    
    #Main panel where the chart + description are supposed to go.
    mainPanel(
      p("Description"),
      plotlyOutput(outputId = "chart2"),
      p("...")
    )
  )
)

# Chart 3.
#
plot3_tab <- tabPanel(
  "Chart 3",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "user_category",
        label = "Select Demographic Group",
        choices = pct_offenders$DemographicValue,
        selected = "Asian",
        multiple = TRUE),

      selectInput(
        inputId = "user_category2",
        label = "Select Year",
        choices = pct_offenders$CohortYearTTL,
        selected = "2013",
        multiple = TRUE),

      selectInput("user_category3",
                  label = h3("Offender Type"),
                  choices = pct_offenders$JJOffenderType,
                  selected = "Status Offender"
      )
    ),
    mainPanel(
      h2("High School outcomes per race"),
      plotlyOutput(outputId = "chart3"),
      p("This visualization demonstrates high school outcomes for different racial groups each year. We chose this chart to reveal how race and involvement with the criminal justice system might
        affect high school outcomes. The fact that there is little to no data on certain races for offender status
        rates might reveal how racial steoreotypes influence both high school outcomes and involvement with the criminal justice system.
      ")
    )

    # Main panel where the chart + description are supposed to go.

  )
)

# Conclusion tab.

conclusion_tab <- tabPanel(
  "Conclusion",
  h1(strong("here‘s a title")),
  p("Here is the conclusion text.")
)

ui <- navbarPage(
  "General page title",
  intro_tab,
  # plot1_tab,
  plot2_tab,
  plot3_tab,
  conclusion_tab
)