library(ggplot2)
library(plotly)
library(bslib)

library(bslib)
#install.packages("htmlwidgets", type = "binary")
#install.packages("DT", type = "binary")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            p("Here is the intro text.")
  )
)

#Chart1 Page

# small widgets

plot1_tab <- tabPanel(
  "Educational Outcome and Justice Involvement",
  sidebarLayout(
    sidebarPanel(
      selectInput(
    inputId = "user_justice_choice",
    label = h3("Select an Offender Type"),
    choices = avg_pct_offenders$Justice_Involvement,
    selected = "Justice Involved",
    multiple = TRUE),
  
  radioButtons(
    inputId = "user_explain",
    label = h5("See the Metric explanation of High School Outcomes (HSOutcome):"),
    choices = list("Dropout" = 1, "GED" = 2, "HS Diploma" = 3),
    selected = NULL),
  textOutput(outputId = "outcome")
  
  )
 ),

mainPanel(
  plotlyOutput(outputId = "chart1"),
  p("We wanted to demonstrate the changes over time for the high school outcomes for different types of justice involvement.",
    "These graphs show the percent for each high school outcome (GED, diploma, and dropout) for each type of justice involvement within different years.",
    "It is pretty obvious that the most optismistic high school outcome shows on those students who are not justice involved: ",
    "highest rate of HS Diploma and lowest rate of dropout."),
 )
)

# layer of the tab
chart1_tab <- tabPanel(
  "Educational Outcome and Justice Involvement",
  sidebarLayout(
    plot_sidebar,
    plot_main
  ),
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
            p("We wanted to demonstrate the changes over time for the high school outcomes for different types of justice involvement.",
              "These graphs show the percent for each high school outcome (GED, diploma, and dropout) for each type of justice involvement within different years.",
              "It is pretty obvious that the most optismistic high school outcome shows on those students who are not justice involved: ",
              "highest rate of HS Diploma and lowest rate of dropout.")
  )
)

#Chart 2 Page

plot2_tab <- tabPanel(
  "Chart 2",
  
  #This is the sidebar.
  sidebarLayout(
    sidebarPanel(
      p("Select your viewing options!"),
      selectInput("county_id",
                  label = h3("County"),
                  choices = fires$Counties,
                  selected = "option"
      ),
      selectInput("color_id2",
                  label = h3("Color"),
                  choices = brewer.pal(8, "Set2")
      )
    ),
    
    #Main panel where the chart + description are supposed to go.
    mainPanel(
      h2("Title that describes the chart"),
      p("Description"),
      plotlyOutput(outputId = "output id for ch2"),
      p("...")
    )
  )
)

p("We wanted to demonstrate the changes over time for the high school outcomes for different types of justice involvement.",
  "These graphs show the percent for each high school outcome (GED, diploma, and dropout) for each type of justice involvement within different years.",
  "It is pretty obvious that the most optismistic high school outcome shows on those students who are not justice involved: ",
  "highest rate of HS Diploma and lowest rate of dropout.")

# Chart 3.

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
    )
      ),
    
    # Main panel where the chart + description are supposed to go.
mainPanel(
      h2("High School outcomes per race"),
      plotlyOutput(outputId = "chart3"),
      p("This visualization demonstrates high school outcomes for different racial groups each year. We chose this chart to reveal how race and involvement with the criminal justice system might 
  affect high school outcomes. The fact that there is little to no data on certain races for offender status 
  rates might reveal how racial steoreotypes influence both high school outcomes and involvement with the criminal justice system.
"),
      
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
  plot1_tab,
  plot2_tab,
  plot3_tab,
  conclusion_tab
)