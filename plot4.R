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
png(file = 'plot4.png', width = 480, height = 480)

par(mfrow = c(2, 2))

#plot (1, 1)
with(electric_sub, plot(DateTime, Global_active_power,
                        xlab = '',
                        ylab = 'Global Active Power',
                        type = 'n'))
with(electric_sub, lines(DateTime, Global_active_power))

#plot (1, 2)
with(electric_sub, plot(DateTime, Voltage, 
                        xlab = 'datetime', 
                        ylab = 'Voltage', 
                        type = 'n'))
with(electric_sub, lines(DateTime, Voltage))

#plot (2, 1)
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
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        box.col = 'white')
box(col = 'black')

#plot (2, 2)
with(electric_sub, plot(DateTime, Global_reactive_power,
                        xlab = 'datetime',
                        type = 'n'))
with(electric_sub, lines(DateTime, Global_reactive_power))

dev.off()
