
library(tidyverse)
library(shinyjs)
library(shiny)

# Define UI for application that creates scatter and box plots
shinyUI(fluidPage(
    useShinyjs(),

    # Application title
    titlePanel("Diamond prices"),

    # Sidebar with a selection input for x variable
    sidebarLayout(
        sidebarPanel(
            selectInput("select_variable", "See the impact of which variable (var) on price of diamonds",
                        choices = colnames(diamonds)),
            selectInput("select_log_var", "Choose 'var' or 'log(var)'",
                        choices = c("var", "log(var)")),
            selectInput("select_log", "Choose 'price' or 'log(price)'",
                        choices = c("price", "log(price)")),
            checkboxInput("checkbox", "Show/Hide correlation coefficient", value = TRUE),
            submitButton("Submit")

        ),

        # Show a plot of the generated graph and the Pearson correlation coefficient
        mainPanel(
            plotOutput("plot"),
            h3(textOutput("corr_desc")),
            h3(textOutput("corr_value"))
        )
    )
))
