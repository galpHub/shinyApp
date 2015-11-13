# server.R
library(shiny)


# Ideally the computation would be done offline and loaded using the 'load' function.
# However, since this data set is small it remains effective to do so.
set.seed(1000)
library(datasets)
library(randomForest)
rf_model1 <- randomForest(Species ~.,data=iris)


shinyServer(
      function(input,output){
            
            variableInputs <- reactive({
                  userInputs <- names(input)[grepl("Petal|Sepal" ,names(input) )]
                  sapply(userInputs,function(e)input[[e]])
            })
            output$inputAsText <- renderPrint({
                        variableInputs()
                  })
            output$predicted <- renderPrint({
                  if(input$goButton>0){
                        isolate({
                              dfNames <- names(variableInputs())
                              df <- as.data.frame(matrix(variableInputs(),nrow=1))
                              names(df)
                              names(df) <- dfNames
                              as.character(predict(rf_model1,newdata=df ))
                        })
                  }
                  

            })
            output$ClassPlot <- renderPlot({
                  speciesNames <- unique(iris$Species)
                  colors <- c("black","red","blue")
                  lengthVals <- sapply(split(iris$Petal.Length,iris$Species),median)
                  cexScale <-function(j){
                        3.1/(abs(input$Petal.Length-lengthVals[j])+1)
                  }
                        
                  with(data=iris[iris$Species==speciesNames[1],],
                       plot(Sepal.Length,Petal.Width,col=colors[1],
                       cex = cexScale(1),xlim=c(4,8.2),ylim=c(0,2.7) ) )
                  
                  for(i in 2:3){
                        with(data=iris[iris$Species==speciesNames[i],],
                             points(Sepal.Length,Petal.Width,
                                              col=colors[i],
                                            cex= cexScale(i) ))  
                  }
                  
                  legend(x="topleft",legend=as.character(speciesNames),
                         col=colors,pch=1)
                  
                  v <- c(5.8,5.8)
                  if( length(c(input$Sepal.Length)) > 0){
                        v <- c(input$Sepal.Length,input$Sepal.Length)
                  }
                  lines( v,
                        c(0,100),col='black')
                  lines(c(0,100),c(input$Petal.Width,input$Petal.Width),
                        col='black')
                  #abline(h = input$Sepal.Length)
                  #abline(v = input$Petal.Width,col='black')
            })
            
            output$resetable_input <- renderUI({
                  input$reset_button
                  list(
                        sliderInput("Petal.Length","Petal length",value=4.35,min=1,max=6.9,step=0.1),
                        sliderInput("Petal.Width","Petal Width",value=1.3,min=.1,max=2.5,step=0.1),
                        sliderInput("Sepal.Length","Sepal length",value=5.8,min=4.3,max=7.9,step=0.1),
                        sliderInput("Sepal.Width","Sepal Width",value=3,min=2,max=4.4,step=0.1)
                        )
            })
            
      }
)