library(ggplot2)
library(plotly)
library(bslib)

library(bslib)
#install.packages("htmlwidgets", type = "binary")
#install.packages("DT", type = "binary")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "solar"),
            p("Here is the intro text.")
  )
)

#Chart1 Page
Chart1 <- tabPanel(
  "Chart 1",
  
  #This is the sidebar.
  sidebarLayout(
    sidebarPanel(
      p("Select your viewing options"),
      selectInput("input_id",
                  label = h3("Year"),
                  choices = df$column,
                  selected = "option"
      ),
      selectInput("color_id",
                  label = h3("Color"),
                  choices = brewer.pal(8, "Set2")
      )
    ),
    
    #Main panel where the chart + description are supposed to go.
    
    mainPanel(
      h2("title of what chart 1 is doing"),
      p("..."),
      plotlyOutput(outputId = "output_id"),
      p("some description")
    )
  )
)

#Chart 2 Page

Chart2 <- tabPanel(
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

# Chart 3.

Chart3 <- tabPanel(
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