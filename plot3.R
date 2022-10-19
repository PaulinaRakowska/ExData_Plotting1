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
png(file = 'plot3.png', width = 480, height = 480)

with(electric_sub, plot(DateTime, Sub_metering_1, 
                        xlab = '', 
                        ylab = 'Energy sub metering', 
                        type = 'n'))
with(electric_sub, {
                lines(DateTime, Sub_metering_1, col = 'black')
                lines(DateTime, Sub_metering_2, col = 'red')
                lines(DateTime, Sub_metering_3, col = 'blue')
})
legend("topright", 
       lty = c(1, 1, 1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
