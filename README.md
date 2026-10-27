# Fuel Economy Explorer

A Shiny application with a reproducible five-slide Slidify pitch. Created October 27, 2026.

## Application

Public deployment: pending shinyapps.io account setup.

The app predicts fuel economy from vehicle weight and horsepower using `lm(mpg ~ wt + hp, data = mtcars)`. It calculates annual fuel use and cost from annual mileage and fuel price. The app's **How to use** tab contains all user documentation.

Run locally:

```r
install.packages("shiny")
shiny::runApp("app")
```

## Pitch

https://anubhavgpta.github.io/shiny-fuel-explorer-2026/pitch/

The five slides include the title slide and two evaluated R chunks. Source: `pitch/index.Rmd`. Built with Slidify 0.5 and markdown 1.7 with a compatibility adapter in build.R, using the default io2012 template.

## Deploy

After configuring your shinyapps.io account in RStudio:

```r
rsconnect::deployApp("app", appName = "fuel-economy-explorer")
```

Never commit deployment tokens or secrets.

