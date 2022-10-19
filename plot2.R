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

#Plot
png(file = 'plot2.png', width = 480, height = 480)

with(electric_sub, plot(DateTime, Global_active_power, 
                        xlab = '', 
                        ylab = 'Global Active Power (kilowatts)', 
                        type = 'n'))
with(electric_sub, lines(DateTime, Global_active_power))

dev.off()
