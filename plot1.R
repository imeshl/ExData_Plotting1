# Read in data from working directory
household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

# Convert Date column data to Date format
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")

# Extract only required data within the specified date range
pw_data <- subset(household_power_consumption, Date > "2007-01-31" & Date < "2007-02-03")

# Plot histogram to PNG file & annotate
png(file = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(pw_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()