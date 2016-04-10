# Read in data from working directory
household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

# Convert Date column data to Date format
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")

# Extract only required data within the specified date range
pw_data <- subset(household_power_consumption, Date > "2007-01-31" & Date < "2007-02-03")

# Combine Date & Time coloumns into a new coloumn named datetime
pw_data <- within(pw_data, {datetime=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")})
pw_data$datetime <- strptime(pw_data$datetime, format = "%d/%m/%Y %H:%M:%S")

# Plot line graph to PNG device & annotate
png(file = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
with(pw_data, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()