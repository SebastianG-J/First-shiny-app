library(shiny)
library(ggplot2)
library(dplyr)

# Minimal Shiny App (blank) ####

ui <- fluidPage()

server <- function(input, output) {}

shinyApp(ui = ui, server = server)


# Dataset ####

biopics <- read.csv("biopics.csv")

biopics <- biopics %>%
  mutate(box_office = gsub("\\$", "", box_office)) %>%
  mutate(box_office = gsub("m", "", box_office)) %>%
  mutate(box_office = gsub("-", "", box_office))%>%
  mutate(box_office = as.numeric(box_office))

# ggplot 

my_plot <-  ggplot(biopics) +
  aes(
    x=year_release,
    y=box_office,
    color= type_of_subject) +
  geom_point()

my_plot

# Adding a Plot to App ####

ui <- fluidPage(
  plotOutput("movie_plot")
)

server <- function(input, output) {
  
  output$movie_plot <- renderPlot({
    
    ggplot(biopics) +
      aes(x=year_release,
          y=box_office,
          color= type_of_subject) +
      geom_point()
    
  })
  
}

shinyApp(ui = ui, server = server)

# Adding a Control ####

categoricalVars <- c("country", "type_of_subject", "subject_sex", "country")

ui <- fluidPage(
  plotOutput("movie_plot"),
  selectInput(
    inputId = "color_select",
    label = "Select Categorical Variable",
    choices = categoricalVars)
)

server <- function(input, output) {
  
  output$movie_plot <- renderPlot({
    
    ggplot(biopics) +
      aes(x=year_release,
          y=box_office,
          color=.data[[input$color_select]]) +
      
      geom_point()
  })
  
}

shinyApp(ui = ui, server = server)

# Making a Dataset Filterable ####

biopics %>%
  filter(year_release > 1917)

#or biopics[biopics$year_release > 1917,]


# Adding control: sliderInput() ####

ui <- fluidPage(
  
  plotOutput("movie_plot"),
  sliderInput("year_filter",
              "Select Lowest Year",
              min = 1915,
              max=2014,
              value = 1915)
)

server <- function(input, output) {
  
  biopics_filtered <- reactive({
    
    biopics %>%
      filter(year_release > input$year_filter)
    
  })
  
  output$movie_plot <- renderPlot({
    
    ggplot(biopics_filtered()) +
      aes(x=year_release,
          y=box_office) +
      
      geom_point()
  })
  
}

shinyApp(ui = ui, server = server)
