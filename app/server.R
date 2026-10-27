library(shiny)
shinyServer(function(input, output, session) {
 model <- lm(mpg ~ wt + hp, data=mtcars)
 estimate <- reactive({
  req(input$weight, input$hp)
  predict(model, newdata=data.frame(wt=input$weight, hp=input$hp), interval="prediction")
 })
 annual <- reactive({
  req(!is.null(input$miles), !is.null(input$price))
  validate(need(is.finite(input$miles) && input$miles >= 0 && input$miles <= 100000, "Enter annual miles from 0 to 100,000."),
           need(is.finite(input$price) && input$price >= 0 && input$price <= 20, "Enter a fuel price from 0 to 20."),
           need(estimate()[1,"lwr"] > 0, "Choose a more plausible weight and horsepower combination: the prediction interval includes zero."))
  gallons <- input$miles / estimate()[1,"fit"]
  data.frame(Measure=c("Annual fuel (US gallons)", "Annual fuel cost (USD)"), Estimate=round(c(gallons, gallons * input$price), 2))
 })
 output$prediction <- renderText({
  e <- estimate()
  sprintf("Predicted fuel economy: %.1f mpg\n95%% prediction interval: %.1f to %.1f mpg", e[1,"fit"], e[1,"lwr"], e[1,"upr"])
 })
 output$cost <- renderTable(annual(), digits=2)
 output$comparison <- renderPlot({
  e <- estimate()
  weights <- seq(1.6, 5.4, length.out=100)
  fitted <- predict(model, data.frame(wt=weights, hp=input$hp))
  plot(mtcars$wt, mtcars$mpg, xlab="Weight (1,000 lb)", ylab="Fuel economy (mpg)", pch=1,
       ylim=range(c(mtcars$mpg, fitted, e[1,"fit"])), main="Historical cars and your selected vehicle")
  lines(weights, fitted, lty=2)
  points(input$weight, e[1,"fit"], pch=4, cex=2, lwd=2)
  legend("topright", c("Historical cars", "Model at chosen horsepower", "Selected vehicle"), pch=c(1,NA,4), lty=c(NA,2,NA), bty="n", cex=0.8)
 })
 output$caution <- renderText("Educational estimates from historical data. Read the How to use tab before interpreting results.")
})
