library(shiny)
require(markdown)

shinyUI(fluidPage(
        # Application title
        titlePanel("Most Popular Baby Names in US"),
        includeMarkdown("README.md"),
        # siderbar layout
        sidebarLayout(
                sidebarPanel(
                        # select sex
                        radioButtons("sex", label = "Sex", c("Female" = "F", "Male" = "M"), 
                                     selected = "F", inline = T),
                        # select year
                        sliderInput("year", label = "Year", min = 1880, max = 2006, step = 9, value = 1934),
                        # select type of order
                        selectInput("type", label = "Most popular or least popular", 
                                    c("Most 50 popular names" = TRUE,
                                      "Least 50 popular names" = FALSE),
                                    selected = TRUE)
                        
                ),
                
                # render the plot
                mainPanel(
                        tabsetPanel(
                        tabPanel("Frequency plot", plotOutput("plot")),
                        tabPanel("Word Cloud", plotOutput("wordcloudplot"))
                        #textOutput("values")
#                         verbatimTextOutput("dateText"),
#                         verbatimTextOutput("dateText2"),
#                         verbatimTextOutput("dateRangeText")
                        )
                )
        )
        
))