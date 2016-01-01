getwd()
setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R')

stateInfo <- read.csv('stateData.csv')

subset(stateInfo, state.region == 1)

stateInfo[stateInfo$state.region == 1, ]

# reddit survey data

getwd()
setwd('/Users/Warren/Desktop/Udacity/EDA_Course_Materials/lesson2')

reddit <- read.csv('reddit.csv')

library(ggplot2)
qplot(data = reddit, x = age.range) # ordered factors to order factors for plots

# ordered factors: income level (ranking matters)

reddit$age.range = ordered(reddit$age.range, levels = c("Under 18", "18-24", "25-34",
                                                        "35-44", "45-54", "55-64",
                                                        "65 or Above"))
