setwd('/Users/Warren/Desktop/Udacity/data_analysis_with_R/')
fb_friends_birthdays <- read.csv('friends_birthdays.csv')
bdays <- fb_friends_birthdays

bdays$clean_dates <- as.Date(bdays$Start, format = '%m/%d/%Y')

bdays$month <- format(bdays$clean_dates, '%m')

qplot(x = month, data = bdays)

with(bdays, table(month))

bdays$day <- format(bdays$clean_dates, '%d')

with(bdays, table(day))

qplot(x = day, data = bdays)
