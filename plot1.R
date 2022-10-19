
# Reading the data
classes <- c('character', 'character', 'numeric', 'numeric', 
             'numeric', 'numeric', 'numeric', 'numeric', 'numeric')
electric <- read.table("household_power_consumption.txt", 
                       header = TRUE, 
                       sep = ';', 
                       colClasses = classes, 
                       na.strings = '?')

# Creating new variable DateTime
electric$DateTime <- as.character(paste(electric$Date, electric$Time, sep = ' '))

#Converting Date and DateTime variables
electric$Date <- dmy(electric$Date)
electric$DateTime <- dmy_hms(electric$DateTime)

# Creating subset of data
electric_sub <- subset(electric, Date >= '2007-02-01' & Date <= '2007-02-02')

# Plot
png(file = 'plot1.png', width = 480, height = 480)
with(electric_sub, hist(Global_active_power, 
                        col = 'red', 
                        main = 'Global Active Power', 
                        xlab = 'Global Active Power (kilowatts)'))
dev.off()