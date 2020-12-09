#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    navbarPage('Pokedex', 
        tabPanel('Porownanie',
                 fluidPage(
                     fluidRow(
                         column(12,
                            h1("Porownaj Pokemony"),
                            fluidRow(
                                column(3,
                                    selectInput("poke1", "Wybierz:",NULL),
                                    tableOutput('compare_table')),
                                
                                column(4,
                                    selectInput("poke2", "Wybierz:",NULL),
                                    plotOutput("compare_plot"))
                            )
                         )
                     )
                 )
            ),
        tabPanel('Przegladaj',
                 h1("Przegladaj Pokemony"),
                 dataTableOutput('table')
            ),
        tabPanel('Stworz reke',
                 h1("Wybierz atrybut do zbudowania reki"),
                 selectInput("attr", "Wybierz:",NULL),
                 tableOutput('hand_table')
        )
    )
)
