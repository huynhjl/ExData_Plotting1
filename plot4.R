# Assignment for course project #1 of https://class.coursera.org/exdata-003
# Plot 4 (4 graphs in two rows)

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "exdata-data-household_power_consumption.zip"
datafile <- "household_power_consumption.txt"

# Load the data
# Check if file is present, if not download it. Uncompress the file
# unconditionally and return the data for Feb 1st-2nd, 2007.
downloadData <- function() {
  library(lubridate)
  if (!file.exists(filename)) {
    download.file(fileurl, dest=filename, method="curl")
  }
  unzip(filename)
  data <- read.table(datafile, header = TRUE, sep = ";", na.strings = "?",
    colClasses = c(rep("character", 2), rep("numeric", 7)))
  data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
  data$DateTime <- dmy_hms(paste(data$Date, data$Time))
  data
}

data <- downloadData()

# Write 4 plots to png file (default png size is already 480x480)
png(file = "plot4.png")

par(mfrow = c(2, 2))

# plot at (1,1)
plot(Global_active_power ~ DateTime, data=data,
  type="l",
  ylab = "Global Active Power",
  xlab="")

# plot at (2,1)
plot(Voltage ~ DateTime, data=data,
  type="l",
  ylab = "Voltage",
  xlab="datetime")

# plot at (1,2)
plot(Sub_metering_1 ~ DateTime, data=data, type = "n",
    ylab = "Energy sub metering", xlab="")
lines(Sub_metering_1 ~ DateTime, data=data, type = "l")
lines(Sub_metering_2 ~ DateTime, data=data, type = "l", col = "red")
lines(Sub_metering_3 ~ DateTime, data=data, type = "l", col = "blue")
legend("topright", lty = 1,
    col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot at (2,2)
plot(Global_reactive_power ~ DateTime, data=data,
  type="l",
  ylab = "Global_reactive_power",
  xlab="datetime")

dev.off()

