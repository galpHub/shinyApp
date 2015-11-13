
# ui.R
library(shiny)
shinyUI(fluidPage(#pageWithSidebar(
      
      #headerPanel("Predicting species from empirical measurements using random forests"),
      titlePanel("Predicting species from empirical measurements using random forests"),
      
      sidebarPanel(
#             sliderInput("Petal.Length","Petal length",value=4.35,min=1,max=6.9,step=0.1),
#             sliderInput("Petal.Width","Petal Width",value=1.3,min=.1,max=2.5,step=0.1),
#             sliderInput("Sepal.Length","Sepal length",value=5.8,min=4.3,max=7.9,step=0.1),
#             sliderInput("Sepal.Width","Sepal Width",value=3,min=2,max=4.4,step=0.1),
            uiOutput('resetable_input'),
            actionButton("goButton","Predict"),
            actionButton("reset_button","Reset inputs")
            ),
      
      mainPanel(
            tabsetPanel(position="above",
                  tabPanel(
                        h3('Computation display'),
                        h3('Selected inputs'),
                        verbatimTextOutput('inputAsText'),
                        h3('Predicted species'),
                        verbatimTextOutput('predicted'),
                        h3('Discrimination by petal width and sepal length'),
                        plotOutput('ClassPlot')
                        ),
                  tabPanel(
                        h3('Documentation'),
                        p("This application utilizes four quantitative parameters of
                          plants from the Iris genus to determine the species.
                          The various parameters can be set using the sliders. To
                          predict the species one first sets the parameters and clicks
                          the predict button. The reset input button is there to
                          allow the user to reset the inputs to their default values.
                          
                          Additionally a plot is included to inform the user about
                          how the chosen parameters interact with the data. The first
                          slider changes the sizes of the points, enlarging those
                          of the species which has the most similar median value.
                          The second and third slider control the position of the
                          horizontal and vertical black lines. The fourth slider has no
                          reactive graphics.")
                        )

                  )
                  
            )
))