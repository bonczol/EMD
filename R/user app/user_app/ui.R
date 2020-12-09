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
                                column(6,
                                    selectInput("poke_1", "Wybierz:",NULL),
                                    tableOutput('table_poke1'),
                                    plotOutput("poke_1Plot")),
                                
                                column(6,
                                    selectInput("poke_2", "Wybierz:",NULL),
                                    tableOutput('table_poke2'),
                                    plotOutput("poke_2Plot"))
                            )
                         )
                     )
                 )
            ),
        tabPanel('Przegladaj',
                 dataTableOutput('table')
            ),
        tabPanel('Stworz reke',
                 selectInput("poke_3", "Wybierz atrybut:",NULL),
                 textOutput('text'),
                 tableOutput('table_reka')
        )
    )
)
