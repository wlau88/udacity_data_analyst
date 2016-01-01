# Diamonds data set

library(ggplot2) #must load the ggplot package first 
data(diamonds) #loads the diamonds data set since it comes with the ggplot package 

summary(diamonds)

str(diamonds)

# Create a histogram of the price of
# all the diamonds in the diamond data set.

qplot(x=price, data=diamonds, color=cut) + facet_wrap(~color) +
  scale_x_log10() + scale_fill_brewer(type = 'qual')

ggplot(aes(x = table, y = price, color=cut), data = diamonds) + 
  geom_point() 

diamonds$volume <- diamonds$x * diamonds$y * diamonds$z

ggplot(aes(x = volume, y = price, color=clarity), data = diamonds) + 
  geom_point() + scale_y_log10() + scale_x_log10() +
  scale_fill_brewer(type = 'div') + xlim(0, quantile(diamonds$volume, 0.99))

getwd()
setwd('/Users/Warren/Desktop/Udacity/EDA_Course_Materials/lesson3')
list.files()

pf <- read.csv('pseudo_facebook.tsv', sep = '\t')

str(pf)

pf$prop_initiated <- pf$friendships_initiated / pf$friend_count 

pf$year_joined <- 2014 - ceiling(pf$tenure/365)

pf$year_joined.bucket <- cut(pf$year_joined, 
                             breaks = c(2004, 2009, 2011, 2012, 2014))

pf.fc_by_tenure <- subset(pf, !is.na(prop_initiated)) %>%
  group_by(tenure) %>%
  summarise(prop_initiated_median = median(prop_initiated),
            n = n())

ggplot(aes(x = tenure, y = prop_initiated),
       data = pf) + 
  geom_line(aes(color = year_joined.bucket), stat = 'summary', fun.y = median)

ggplot(aes(x = tenure, y = prop_initiated),
       data = pf) +
  geom_smooth(aes(color = year_joined.bucket))

by(pf$prop_initiated, pf$year_joined.bucket, summary)

ggplot(aes(x = cut, y = price/carat, color = color), data = diamonds) +
  facet_wrap(~ clarity) +
  geom_jitter() + scale_color_brewer(type = 'div')

# urban population data
setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/indicator SP_URB_TOTL/')
list.files()

urb_pop <- read.csv('Data-Table 1.csv', header = T, row.names = 1, check.names = F)

# carbon emission
setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/indicator CDIAC carbon_dioxide_total_emissions/')
list.files()

carbon_emission <- read.csv('Data-Table 1.csv', header = T, row.names = 1, check.names = F)

# residential electricity use, per person
setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/Indicator_Residential electricity consumption total/')
list.files()

resid_elec <- read.csv('Data-Table 1.csv', header = T, row.names = 1, check.names = F)

all <- Reduce(function(x, y) merge(x, y, by=0, all=TRUE), 
       list(urb_pop, resid_elec))
dim(all)

dim(urb_pop)
dim(carbon_emission)
dim(resid_elec)

subset(all, select = c(`2006`, `2006.x`, `2006.y`))

ggplot(aes(x = `2005.x`, y = `2005.y`), data = carbon_urb_pop) + geom_point(alpha = 1/5) +
  xlim(0, 2000000) +
  ylim(0, 200000000)

ggplot(aes(x = `2005.x`, y = `2005.y`), data = carbon_urb_pop) + geom_point(alpha = 1/5) +
  xlim(0, 500000) +
  ylim(0, 50000000)

cor.test(carbon_urb_pop$`2005.x`, carbon_urb_pop$`2005.y`)


