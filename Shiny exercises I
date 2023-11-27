# intro
install.packages("shiny")
library(shiny)

# 1.2 Create app directory and file
ui <- fluidPage(
  "Hello, world!"
)
server <- function(input, output, session) {
}
shinyApp(ui, server)

# 1.3 Running and stopping


# 1.4 Adding UI controls
# Replace your ui with this code:
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

# 1.5 Adding behaviour
server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })
  
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}

# 1.6 Reducing duplication with reactive expressions
server <- function(input, output, session) {
  # Create a reactive expression
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    # Use a reactive expression by calling it like a function
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}

# 1.7 Summary
# In this chapter you’ve created a simple app — it’s not very exciting or useful, 
# but seen how easy it is to construct a web app using your existing R knowledge. 
#In the next two chapters, you’ll learn more about user interfaces and reactive programming, 
#the two basic building blocks of Shiny. Now is a great time to grab a copy of the Shiny cheatsheet. 
#This is a great resource to help jog your memory of the main components of a Shiny app.

# 1.8 Exercise 1
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name)
  })
}

shinyApp(ui, server)

# Exercise 2

library(shiny)

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  "then x times 5 is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * 5
  })
}

shinyApp(ui, server)

# Exercise 3
ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "If y is", min = 1, max = 50, value = 5), #Added the y slider
  "then, x times y is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * input$y # changed 5 to input$y to multiply the sliders. 
  })
}

shinyApp(ui, server)

# Exercise 4
# Take the following app which adds some additional functionality to the last app 
# described in the last exercise. What’s new? How could you reduce the amount of duplicated 
# code in the app by using a reactive expression.
library(shiny)

ui <- fluidPage(
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    product <- input$x * input$y
    product
  })
  output$product_plus5 <- renderText({ 
    product <- input$x * input$y
    product + 5
  })
  output$product_plus10 <- renderText({ 
    product <- input$x * input$y
    product + 10
  })
}

shinyApp(ui, server)

ui <- fluidPage(
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)

# Reduction using reactive

server <- function(input, output, session) {
  product <- reactive({
     input$x * input$y
  })

output$product <- renderText({
  product()
})

output$product_plus5 <- renderText({
  product() + 5
})

output$product_plus10 <- renderText({
  product() + 10
})
}

shinyApp(ui, server)

# Exercise 5
# Find and fix the bugs
library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput(inputId = "dataset", label = "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$plot <- renderPlot({
    plot(dataset())
  }, res = 96)
}

shinyApp(ui, server)
# I changed output$summmry to -> output$summary
# Then i called the plot(dataset) as a function -> plot(dataset())
# Lastly I changed the tableOutput function in the UI section to -> plotOutput, as it
# serves as a plot, not a table. 

# Exercise 6
ui <- fluidPage(
  textInput(inputId = "name", label = NULL, placeholder = "Your name")
)

server <- function(input, output, session) {}

shinyApp(ui, server)

# Exercise 7
# Carefully read the documentation for sliderInput() to figure out how to create a date slider, as
# shown below.
ui <- fluidPage(
  sliderInput(inputId = "wswd",
              label = "When should we deliver?",
              min = as.Date("2020-09-16", "%Y-%m-%d"),
              max = as.Date("2020-10-16", "%Y-%m-%d"),
              value = as.Date("2020-10-16", "%Y-%m-%d"))
)

server <- function(input, output, session) {}

shinyApp(ui, server)

# Exercise 8
# Create a slider input to select values between 0 and 100 where the interval between each
# selectable value on the slider is 5. Then, add animation to the input widget so when the user
# presses play the input widget scrolls through the range automatically.

ui <- fluidPage(
  sliderInput(inputId = "0-100",
              label = "0 to 100",
              min = 0,
              max = 100,
              value = 0,
              step = 5,
              animate = TRUE)
)

animationOptions(playButton = TRUE)

server <- function(input, output, session) {}

shinyApp(ui, server)

# Exercise 9
#If you have a moderately long list in a selectInput() , it’s useful to create sub-headings that
#break the list up into pieces. Read the documentation to figure out how. (Hint: the underlying
#                                                                          HTML is called <optgroup> .)

cars <- list(`Swedish cars` = list("Volvo", "Saab"),
             `German cars` = list("Mercedes", "BMW", "Audi"))

ui <- fluidPage(
  selectInput(inputId = "cars",
              label = "Choose a car",
              choices = cars)
)

server <- function(input, output, session) {}

shinyApp(ui, server)

# Exercise 10
#Which of textOutput() and verbatimTextOutput() should each of the following render
#functions be paired with?
# 1. renderPrint(summary(mtcars))
#    - Should be paired with verbatimTextOutput()

# 2. renderText("Good morning!")
#    - Should be paired with textOutput() as it is usually paired with renderText()

# 3. renderPrint(t.test(1:5, 2:6))
#    - Should be paired with verbatimTextOutput()

# 4. renderText(str(lm(mpg ~ wt, data = mtcars)))
#    - Should be paired with textOutput()


# Exercise 11 
# Re-create the Shiny app below, setting height and width of the plot to 300px and 700px
# respectively. Set the plot “alt” text so that a visually impaired user can tell that its a scatterplot of
# five random numbers.
library(shiny)
ui <- fluidPage(
  plotOutput("plot", width = "700px", height = "300px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}
shinyApp(ui, server)
