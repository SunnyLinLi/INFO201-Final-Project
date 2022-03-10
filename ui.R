library(ggplot2)
library(plotly)
library(bslib)

library(shiny)

project_data<-read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-sara-mustredr09/main/Juvenile_Justice_Dashboard_-_HS_Completion.csv?token=GHSAT0AAAAAABQIEWSA6BKJCPJ3VN3C5VHSYQYGLCA")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "sketchy"),
    h3("Overview"),
    p("Education has always been one of the most important topics among the world. It is good to see
      that the educational attainment of the whole population has increased for the past few years. 
      However, differences and gaps between the races still remain, or even worse, grow. In contemporary 
      society, educational attainment could be one of the vital determinants of a person's future path. 
      To put it into the specific scenario, a decent education could help the person to have better job 
      opportunities and the possibility to apply for higher wages. Beyond the economic elements, those who 
      fail to graduate from high school are more likely to have health problems, worse housing, unhappy 
      families, etc., compared with those who are \"highly educated.\""),
    p("If a person's future is highly dependent on his/her educational attainment, and it would be 
      affected by some demographic reasons; In other words, one's future is determined by his/her 
      ethnicity. The injustice a person will undergo is formed since his/her birth. As a bad consequence, 
      it is undeniable that many situations like this would make people be disappointed and less confident 
      about the meaning of education. Therefore, by focusing on Washington State, we would like to explore 
      how demographic elements affect the educational result for high school students, the level that race 
      is connected to high schoolers' criminal justice system, and how they influence the educational 
      outcomes when they are combined. Hopefully, it is possible to see if there is anything we can do to 
      alleviate such inequality and the negative outcomes it brings"),
    p("We have aimed to answer these three research questions:
      - How does race influence educational outcomes for Washington state high schoolers?
      - To what extent does Washington state high schoolers' involvement with the criminal justice system affect their educational outcomes?
      - How strongly is race correlated to high schoolers' criminal justice system involvement and high school graduation rates?"),
    p("Our research questions all aim to find answers about how race and involvement in with the criminal justice system affect education for high schoolers in Washington State. Because we are diving into the concept of race and education, this could have very controversial implications for policymakers in Washington, as education is a very important part in the upbringing of the next generation of minds that will be running our country one day. If it is found that race is a factor in the detriment of young people's high school education experiences, and with that a direct connection to their involvement with the criminal justice system, this will prove to be a major flaw in our education and reform systems within Washington State. We sought to find these answers in all ways that they factor into someone's high school education, whether it be due to discrimination, lack of opportunity, school funding, or any other relevant factors that may contribute to an educational experience.Also, there are a handful of different challenges and limitations that we needed to address in our research in order to come to a reliable conclusion. The first that comes to mind is the areas in which we choose to target within Washington state. Because school districts are usually controlled by the city or county that they reside in, it is important to note any distinctions within these separate areas in order to identify any biases. This also applies to any data that we come across when conducting research about involvement with the criminal justice system and its effect on young people's education outcomes. This could pose a challenge as the extra data that we are looking for may not be readily available in the way that we need it, forcing us to adapt based on the information that we know to be true. Educated inferences were necessary for the sake of answering our research questions which could have possibly limited our findings. However, these are all challenges that can be addressed and should not have kept us from answering our questions about the effects race and criminal justice involvement have on young people's education outcomes in Washington State High Schools.")
    )
)

#Chart1 Page

# small widges
plot_sidebar <- sidebarPanel(
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

# insert plot
plot_main <- mainPanel(
  plotlyOutput(outputId = "chart1")
)

# layer of the tab
plot1_tab <- tabPanel(
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
      ),
      selectInput("demo_id",
                  label = "Choose Demographic Values",
                  choices = project_data$DemographicValue,
                  selected = "Black or African American",
                  multiple = TRUE
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
  h3(strong("Key Takeaways")),
  textOutput(outputId = "SummaryValues")
)

ui <- navbarPage(
  "General page title",
  intro_tab,
  plot1_tab,
  plot2_tab,
  plot3_tab,
  conclusion_tab
)