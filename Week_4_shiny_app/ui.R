#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    useShinyjs(),

    # Application title
    titlePanel("Predict diamond price"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("select_variable", "See the impact of which variable (var) on price of diamonds",
                        choices = colnames(diamonds)),
            selectInput("select_log_var", "Choose 'var' or 'log(var)'",
                        choices = c("var", "log(var)")),
            selectInput("select_log", "Choose 'price' or 'log(price)'",
                        choices = c("price", "log(price)"))#,
           # submitButton("Submit")

        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot")
        )
    )
))
