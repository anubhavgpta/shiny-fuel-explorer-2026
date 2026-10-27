library(shiny)
shinyUI(fluidPage(
 titlePanel("Fuel Economy Explorer"),
 sidebarLayout(
  sidebarPanel(
   sliderInput("weight", "Vehicle weight (1,000 lb)", min=1.6, max=5.4, value=3, step=0.1),
   sliderInput("hp", "Horsepower", min=52, max=335, value=110, step=1),
   numericInput("miles", "Annual driving distance (miles)", value=12000, min=0, max=100000, step=500),
   numericInput("price", "Fuel price (USD per US gallon)", value=3.5, min=0, max=20, step=0.1),
   helpText("Change any input to update the results automatically.")
  ),
  mainPanel(tabsetPanel(
   tabPanel("Explore", h3("Estimated fuel economy"), verbatimTextOutput("prediction"),
    h3("Estimated annual fuel use and cost"), tableOutput("cost"),
    plotOutput("comparison"), textOutput("caution")),
   tabPanel("How to use",
    h3("Getting started"),
    tags$ol(tags$li("Select the vehicle weight in thousands of pounds: 3 means 3,000 lb."),
      tags$li("Choose the engine horsepower."),
      tags$li("Enter the miles you drive per year and the fuel price in US dollars per US gallon."),
      tags$li("Read the predicted mpg, uncertainty interval, annual gallons, and annual cost. No submit button is needed.")),
    h3("What the results mean"),
    p("The server fits a linear regression: mpg ~ wt + hp, using the 32 cars in R's mtcars dataset. The 95% prediction interval describes model uncertainty for one car with the selected characteristics."),
    p("Annual gallons = annual miles / predicted mpg. Annual cost = annual gallons multiplied by price. Costs assume the selected fuel economy and price remain constant."),
    p("The plot shows the original observations and a regression line at your chosen horsepower. The cross marks your selected weight and predicted mpg."),
    h3("Limitations"),
    p("These data describe 1973-74 cars. This is an educational demonstration, not a modern vehicle rating or purchasing recommendation. Predictions are observational, not causal. Some combinations of weight and horsepower are poorly represented even within the slider ranges."),
    p("If the prediction interval includes zero, the app asks you to choose a more plausible combination instead of reporting misleading fuel costs."),
    p("Example: leave weight at 3, horsepower at 110, miles at 12,000, and price at 3.50. Then increase the annual miles: the estimated fuel economy stays fixed while annual fuel use and cost increase."),
    p("Data source: datasets::mtcars, from the 1974 Motor Trend US magazine. Created October 27, 2026."))
  ))
 )))
