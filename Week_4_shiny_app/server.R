
library(shiny)
library(shinyjs)
library(tidyverse)

shinyServer(function(input, output) {
    
    f <- reactive({
        vari <- input$select_variable
        
        if(is.factor(diamonds[[vari]])){
            
            shinyjs::hide(id = "select_log_var")
        } else {
            shinyjs::show(id = "select_log_var")
        }
        
        y <- if_else(input$select_log == "price",
                     "price",
                     "log(price)")
        x <- if_else(input$select_log_var == "var",
                     vari,
                     if_else(is.factor(diamonds[[vari]]),
                             vari,
                             paste0(vari," %>% log()")))
        selection <- paste0(y, " ~ ", x)
        select <- as.formula(selection)
        
    })

    output$plot <- renderPlot({
        
        vari <- input$select_variable
        
        plot(f(), data = diamonds,
             xlab = if_else(!input$select_log_var == "var" & !is.factor(diamonds[[vari]]),
                            paste0("Log of ", vari),
                            vari))
        
        if(!is.factor(diamonds[[vari]])){
            
            abline(lm(f(), data = diamonds), col = "red", lwd = 2)
            
        }
        
    })
    

    output$corr_value <- renderText({
        vari <- input$select_variable
        if(input$checkbox & (!is.factor(diamonds[[vari]]))){
        cor(diamonds[["price"]], diamonds[[vari]])
        }
    })
    
    output$corr_desc <- renderText({
        vari <- input$select_variable
        if(input$checkbox & (!is.factor(diamonds[[vari]]))){
            paste0("The Pearson correlation between price and ", vari, " is")
        }
    })
    
    url <- a("App documentation", href="http://rpubs.com/JayR44/633753")
    output$doc <- renderUI({
        tagList("Link to app documentation:", url)
    })

})
