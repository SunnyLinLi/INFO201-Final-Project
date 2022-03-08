library(shiny)
library(bslib)

# install.packages(rsconnect)
library(rsconnect)
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)