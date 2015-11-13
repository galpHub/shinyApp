
# ui.R
library(shiny)
shinyUI(pageWithSidebar(
      
      headerPanel("Predicting species from empirical measurements using random forests"),
      
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
            h3('Computation display'),
            h3('Selected inputs'),
            verbatimTextOutput('inputAsText'),
            h3('Predicted species'),
            verbatimTextOutput('predicted'),
            h3('Discrimination by petal width and sepal length'),
            plotOutput('ClassPlot')
            )
))