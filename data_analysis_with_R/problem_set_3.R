# Diamonds data set

library(ggplot2) #must load the ggplot package first 
data(diamonds) #loads the diamonds data set since it comes with the ggplot package 

summary(diamonds)

str(diamonds)

# Create a histogram of the price of
# all the diamonds in the diamond data set.

qplot(x=price, data=diamonds)

summary(diamonds$price)

sum(diamonds$price < 500)

sum(diamonds$price < 250)

sum(diamonds$price >= 15000)

# Explore the largest peak in the
# price histogram you created earlier.

# Try limiting the x-axis, altering the bin width,
# and setting different breaks on the x-axis.

# There won’t be a solution video for this
# question so go to the discussions to
# share your thoughts and discover
# what other people find.

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Submit your final code when you are ready.


qplot(x = price, data = diamonds, binwidth = 1) + 
  scale_x_continuous(limits = c(0, 1500), breaks = seq(0, 1500, 100))

ggsave('priceHistogram.png')

# Break out the histogram of diamond prices by cut.

# You should have five histograms in separate
# panels on your resulting plot.

qplot(x = price, data = diamonds) + facet_wrap(~cut)

by(diamonds$price, diamonds$cut, summary)

by(diamonds$price, diamonds$cut, max)

# In the two last exercises, we looked at
# the distribution for diamonds by cut.

# Run the code below in R Studio to generate
# the histogram as a reminder.

# ===============================================================

qplot(x = price, data = diamonds) + facet_wrap(~cut)

# ===============================================================

# In the last exercise, we looked at the summary statistics
# for diamond price by cut. If we look at the output table, the
# the median and quartiles are reasonably close to each other.

# diamonds$cut: Fair
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     337    2050    3282    4359    5206   18570 
# ------------------------------------------------------------------------ 
# diamonds$cut: Good
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     327    1145    3050    3929    5028   18790 
# ------------------------------------------------------------------------ 
# diamonds$cut: Very Good
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     336     912    2648    3982    5373   18820 
# ------------------------------------------------------------------------ 
# diamonds$cut: Premium
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     326    1046    3185    4584    6296   18820 
# ------------------------------------------------------------------------ 
# diamonds$cut: Ideal
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     326     878    1810    3458    4678   18810 

# This means the distributions should be somewhat similar,
# but the histograms we created don't show that.

# The 'Fair' and 'Good' diamonds appear to have 
# different distributions compared to the better
# cut diamonds. They seem somewhat uniform
# on the left with long tails on the right.

# Let's look in to this more.

# Look up the documentation for facet_wrap in R Studio.
# Then, scroll back up and add a parameter to facet_wrap so that
# the y-axis in the histograms is not fixed. You want the y-axis to
# be different for each histogram.

# If you want a hint, check out the Instructor Notes.

qplot(x = price, data = diamonds) + facet_wrap(~cut, scales = 'free_y')

# Create a histogram of price per carat
# and facet it by cut. You can make adjustments
# to the code from the previous exercise to get
# started.

# Adjust the bin width and transform the scale
# of the x-axis using log10.

# Submit your final code when you are ready.

qplot(x = price/carat, data = diamonds) + facet_wrap(~cut) + 
  scale_x_log10()

# pretty normally distributed

# Investigate the price of diamonds using box plots,
# numerical summaries, and one of the following categorical
# variables: cut, clarity, or color.

# There won’t be a solution video for this
# exercise so go to the discussion thread for either
# BOXPLOTS BY CLARITY, BOXPLOT BY COLOR, or BOXPLOTS BY CUT
# to share you thoughts and to
# see what other people found.

qplot(x = cut, y = price, 
      data = diamonds, 
      geom = 'boxplot',
      color = cut)

by(diamonds$price, diamonds$cut, summary)

qplot(x = color, y = price, 
      data = diamonds, 
      geom = 'boxplot',
      color = color)

by(diamonds$price, diamonds$color, summary)

qplot(x = clarity, y = price, 
      data = diamonds, 
      geom = 'boxplot',
      color = clarity)

by(diamonds$price, diamonds$clarity, summary)

# Investigate the price per carat of diamonds across
# the different colors of diamonds using boxplots.

# Go to the discussions to
# share your thoughts and to discover
# what other people found.

qplot(x = color, y = price/carat, 
      data = diamonds, 
      geom = 'boxplot',
      color = color)

# Carat frequency polygon

qplot(x = carat, data = diamonds, geom = 'freqpoly', binwidth = 0.01)  +
  scale_x_continuous(limits = c(0, 2.4),
                     breaks = seq(0, 2.4, 0.01)) +
  scale_y_continuous(breaks = seq(0, 3000, 1000))

with(diamonds, table(carat))

# Gapminder data

setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/indicator_age_of_marriage.csv')
list.files()

marriage <- read.csv('Data-Table 1.csv', header = T, row.names = 1, check.names = F)

marriage$`2005`

qplot(x = `2005`, data = marriage)
qplot(x = `2004`, data = marriage)
qplot(x = `2003`, data = marriage)

qplot(x = `2005`, data = marriage, geom = 'freqpoly')

with(marriage, table(`2005`))

#+ 
#  scale_x_continuous(limits = c(0, 1500), breaks = seq(0, 1500, 100))




