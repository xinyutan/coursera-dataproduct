library(shiny)
library(wordcloud)
library(ggplot2)

# prepare all the data ready
file_names <- dir('./names/', "?txt")
name_data <- data.frame()
#names(name_data) <- c("Name", "Sex", "Freq", "Year")
for (file in file_names[seq(1, 135, 9)]) {
        temp_data <- read.csv(paste('./names/', file, sep = ""), 
                              header = F, stringsAsFactors = F)
        temp_year <- strsplit(file, '.txt')
        temp_year <- strsplit(temp_year[[1]], 'yob')
        temp_year <- as.numeric(temp_year[[1]][2])
        temp_data[,4] <- rep(temp_year, dim(temp_data)[1])
        name_data <- rbind(name_data, temp_data)
}


shinyServer(
        function(input, output) {
                
                # only do something if there is a input
                output$plot <- renderPlot({
                        temp_name_data <- name_data[name_data$V4==input$year, ]
                        temp_name_data <- temp_name_data[temp_name_data$V2 == input$sex, ]
                        temp_name_data <- temp_name_data[order(temp_name_data$V3, decreasing = input$type), ]
                        temp_name_data <- temp_name_data[1:50, ]
                        ggplot(temp_name_data, aes(V1, V3)) + 
                                geom_point(aes(size = V3)) + scale_size_area() +
                                xlab("Name") + ylab("Frequency") + 
                                theme(axis.text.x = element_text(face="bold", color="#993333", 
                                                                 size=14, angle=45))
                })
                wordcloud_rep <- repeatable(wordcloud)
                output$wordcloudplot <- renderPlot({
                        temp_name_data <- name_data[name_data$V4==input$year, ]
                        temp_name_data <- temp_name_data[temp_name_data$V2 == input$sex, ]
                        temp_name_data <- temp_name_data[order(temp_name_data$V3, decreasing = input$type), ]
                        temp_name_data <- temp_name_data[1:50, ]
                        wordcloud_rep(temp_name_data$V1, temp_name_data$V3, colors=brewer.pal(8, "Dark2"))
                })
                #output$dateRangeText <- renderPrint({descending})
        }
)