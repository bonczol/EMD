#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(fmsb)

df <- read.csv("pokemons.csv")
choices = setNames(df$X + 1,df$name)
df_stats<- df %>% select(3:8)
choice_attr <- colnames(df)[3:8]

shinyServer(function(input, output, session) {

    updateSelectizeInput(session, 'poke_1',
                         choices = choices,
                         selected = "",
                         server = TRUE
    )
    updateSelectizeInput(session, 'poke_2',
                         choices = choices,
                         selected = "",
                         server = TRUE
    )
    
    updateSelectizeInput(session, 'poke_3',
                         choices = choice_attr,
                         selected = "",
                         server = TRUE
    )
    
    output$table <- renderDataTable(df)
        
    output$table_poke1 <- renderTable({
        if(input$poke_1 != ""){
            
            a <- t(df[input$poke_1,])
            b <- data.frame(Parameters = colnames(df), Resources = a)
            colnames(b)<- c('stat', 'value')
            b
            }
        
    })
    
    output$table_poke2 <- renderTable({
        if(input$poke_2 != ""){
            
            a <- t(df[input$poke_2,])
            b <- data.frame(Parameters = colnames(df), Resources = a)
            colnames(b)<- c('stat', 'value')
            b
        }
        
    })
    
    output$table_reka <- renderTable({
if (input$poke_3 != ""){
        
        top_n(df, 6, eval(parse(text=input$poke_3))) 
        }})
    



    output$text <- renderText(input$poke_3)
    
    
    output$poke_1Plot <- renderPlot({
        if(input$poke_1 != ""){
        data <- rbind(rep(240,6) , rep(0,6) ,df_stats[input$poke_1,])
        radarchart(data,axistype=1,
                   pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=1, 
                   cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,240,60), cglwd=0.8,
                   vlcex=0.8 )}
    })
    
    output$poke_2Plot <- renderPlot({
        if(input$poke_2 != ""){
            data <- rbind(rep(240,6) , rep(0,6) ,df_stats[input$poke_2,])
            radarchart(data,axistype=1,
                       pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=1, 
                       cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,240,60), cglwd=0.8,
                       vlcex=0.8 )}
    })

})
