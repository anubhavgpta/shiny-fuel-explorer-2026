.libPaths(c(file.path(getwd(), "college_analysis", "R-library"), .libPaths()))
if (dir.exists("shiny_fuel_explorer")) setwd("shiny_fuel_explorer")
library(shiny)
server <- source("app/server.R")$value
testServer(server, {
 session$setInputs(weight=3, hp=110, miles=12000, price=3.5)
 stopifnot(abs(estimate()[1,"fit"] - predict(lm(mpg~wt+hp,mtcars),data.frame(wt=3,hp=110))) < 1e-9)
 initial <- annual()$Estimate
 session$setInputs(miles=24000)
 stopifnot(abs(annual()$Estimate[2] - initial[2]*2) < 0.02)
 session$setInputs(miles=0, price=0)
 stopifnot(all(annual()$Estimate==0))
 session$setInputs(weight=5.4, hp=335)
 stopifnot(inherits(try(annual(), silent=TRUE), "try-error"))
})
cat("Reactive calculation and invalid-prediction checks passed.\n")
setwd("pitch")
library(slidify)
assignInNamespace("is_installed", function(mypkg) requireNamespace(mypkg, quietly=TRUE), ns="slidify")
# Compatibility adapter for the retired markdownExtensions API.
assignInNamespace("md2html", function(md) paste(markdown::mark_html(text=md, template=FALSE), collapse="\n"), ns="slidify")
slidify::slidify("index.Rmd")



html <- readLines("index.html", warn=FALSE)
html <- gsub("http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.min.js", "libraries/widgets/quiz/js/jquery.js", html, fixed=TRUE)
writeLines(html, "index.html")
dir.create("libraries/widgets/quiz/js", recursive=TRUE, showWarnings=FALSE)
file.copy(system.file("libraries/widgets/quiz/js/jquery.js",package="slidifyLibraries"), "libraries/widgets/quiz/js/jquery.js",overwrite=TRUE)
stopifnot(sum(grepl("<slide ",html, fixed=TRUE)) - sum(grepl('class="backdrop"',html,fixed=TRUE)) == 5)

