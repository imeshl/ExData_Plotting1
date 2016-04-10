# Read in data from working directory
household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

# Convert Date column data to Date format
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")

# Extract only required data within the specified date range
pw_data <- subset(household_power_consumption, Date > "2007-01-31" & Date < "2007-02-03")

# Combine Date & Time coloumns into a new coloumn named datetime
pw_data <- within(pw_data, {datetime=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")})
pw_data$datetime <- strptime(pw_data$datetime, format = "%d/%m/%Y %H:%M:%S")

# Set row & column count
png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfcol = c(2,2))

# Plot 1st graph
with(pw_data, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Plot 2nd graph
plot(pw_data$datetime, pw_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(pw_data$datetime, pw_data$Sub_metering_2, col = "red")
lines(pw_data$datetime, pw_data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"), bty = "n")

# Plot 3rd graph
with(pw_data, plot(datetime, Voltage, type = "l"))

# Plot 4th graph
with(pw_data, plot(datetime, Global_reactive_power, type = "l"))
dev.off()