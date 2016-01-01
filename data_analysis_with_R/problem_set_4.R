ggplot(aes(x = price, y = carat), data = diamonds) + geom_point() 

cor.test(diamonds$price, diamonds$x)
cor.test(diamonds$price, diamonds$y)
cor.test(diamonds$price, diamonds$z)

ggplot(aes(x = price, y = depth), data = diamonds) + geom_point() 

cor.test(diamonds$price, diamonds$depth)

ggplot(aes(x = carat, y = price), data = diamonds) + 
  xlim(0, quantile(diamonds$carat, 0.99)) +
  ylim(0, quantile(diamonds$price, 0.99)) +
  geom_point()

diamonds$volume <- diamonds$x * diamonds$y * diamonds$z

ggplot(aes(x = price, y = volume), data = diamonds) + geom_point(alpha = 1/20) +
  ylim(0, 1000)

install.packages("plyr")
library(plyr)

count(diamonds$volume == 0)

temp <- subset(diamonds, (volume != 0) & (volume < 800))

cor.test(temp$volume, temp$price)

ggplot(aes(x = price, y = volume), data = temp) + geom_point(alpha = 1/10) + 
  stat_smooth(method = 'lm')

detach("package:plyr", unload=TRUE)

clarityGroups <- group_by(diamonds, clarity)
diamondsByClarity <- summarise(clarityGroups,
                          mean_price = mean(price),
                          median_price = median(price),
                          min_price = min(price),
                          max_price = max(price),
                          n = n())

diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))

diamonds_by_color <- group_by(diamonds, color)
diamonds_mp_by_color <- summarise(diamonds_by_color, mean_price = mean(price))

install.packages('gridExtra')
library(gridExtra)

b1 <- barplot(diamonds_mp_by_color$mean_price, names.arg = diamonds_mp_by_color$color)
b2 <- barplot(diamonds_mp_by_clarity$mean_price, names.arg = diamonds_mp_by_clarity$clarity)

grid.arrange(b1, b2, ncol = 1)

barplot(diamonds_mp_by_color$mean_price, names.arg = diamonds_mp_by_color$color)
barplot(diamonds_mp_by_clarity$mean_price, names.arg = diamonds_mp_by_clarity$clarity)


#We think something odd is going here. These trends seem to go against our intuition.

#Mean price tends to decrease as clarity improves. The same can be said for color.

#We encourage you to look into the mean price across cut.

diamonds_by_cut <- group_by(diamonds, cut)
diamonds_mp_by_cut <- summarise(diamonds_by_cut, mean_price = mean(price))
barplot(diamonds_mp_by_cut$mean_price, names.arg = diamonds_mp_by_cut$cut)

# marriage data

setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/indicator_age_of_marriage.csv')
list.files()

marriage <- read.csv('Data-Table 1.csv', header = T, row.names = 1, check.names = F)

marriage$`2005`

# urban population data

setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/indicator SP_URB_TOTL/')
list.files()

urb_pop <- read.csv('Data-Table 1.csv', header = T, row.names = 1, check.names = F)

setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/indicator CDIAC carbon_dioxide_total_emissions/')
list.files()

carbon_emission <- read.csv('Data-Table 1.csv', header = T, row.names = 1, check.names = F)

carbon_urb_pop <- merge(carbon_emission, urb_pop, by=0, all=TRUE)

ggplot(aes(x = `2005.x`, y = `2005.y`), data = carbon_urb_pop) + geom_point(alpha = 1/5) +
  xlim(0, 2000000) +
  ylim(0, 200000000)

ggplot(aes(x = `2005.x`, y = `2005.y`), data = carbon_urb_pop) + geom_point(alpha = 1/5) +
  xlim(0, 500000) +
  ylim(0, 50000000)

cor.test(carbon_urb_pop$`2005.x`, carbon_urb_pop$`2005.y`)


