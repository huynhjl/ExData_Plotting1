# Assignment for course project #1 of https://class.coursera.org/exdata-003
# Plot 2 (global active power by time)

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

# Write lines to png file (default png size is already 480x480)
png(file = "plot2.png")
plot(Global_active_power ~ DateTime, data=data,
  type="l",
  ylab = "Global Active Power (kilowatts)",
  xlab="")
dev.off()

