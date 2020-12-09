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
colnames(df)[1] <- "ID"
df_stats<- df %>% select(3:8)
choice_attr <- colnames(df)[3:8]

shinyServer(function(input, output, session) {

    updateSelectizeInput(session, 'poke1', choices = choices, selected = "",server = TRUE)
    updateSelectizeInput(session, 'poke2', choices = choices, selected = "",server = TRUE)
    updateSelectizeInput(session, 'attr', choices = choice_attr, selected = "", server = TRUE)
    
    output$table <- renderDataTable(df)

    output$compare_table <- renderTable({
        if(input$poke2 != "" | input$poke1 != ""){
            indexs=c()
            names=c('Parametr')
            if(input$poke1 != "") {
                indexs <- append(indexs,input$poke1)
                names <- append(names,'') }
            if(input$poke2 != "") {
                indexs <- append(indexs,input$poke2)
                names <- append(names,'') }
            
            b <- data.frame(Parameters = colnames(df), Resources = t(df[indexs,]))
            colnames(b)<- names
            b
        }
    })
    
    output$hand_table <- renderTable({
        if (input$attr != "") top_n(df, 6, eval(parse(text=input$attr))) 
        })

    output$compare_plot <- renderPlot({
        if(input$poke2 != "" | input$poke1 != ""){
            indexs=c()
            names=c()
            if(input$poke1 != "") {
                indexs <- append(indexs,input$poke1)
                names <- append(names,df[input$poke1,]$name) }
            if(input$poke2 != "") {
                indexs <- append(indexs,input$poke2)
                names <- append(names,'') }
            
            
            colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.7,0.5,0.1,0.9) )
            colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.7,0.5,0.1,0.4) )
            
            data <- rbind(rep(240,6) , rep(0,6) ,df_stats[indexs,])
            radarchart(data,axistype=1,
                       pcol=colors_border , pfcol=colors_in , plwd=2 , plty=1,
                       cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,240,60), cglwd=0.8,
                       vlcex=0.8 )
            legend("topright", legend = df[indexs,]$name, bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)
            }
    })

})
