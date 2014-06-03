# Assignment for course project #1 of https://class.coursera.org/exdata-003
# Plot 1 (histogram of global active power)

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
  data$Date = dmy(data$Date)
  data$Time = hms(data$Time) 
  data
}

data <- downloadData()

# Write histogram to png file (default png size is already 480x480)
png(file = "plot1.png")
hist(data$Global_active_power,
    main = "Global Active Power",
    col = "red",
    xlab = "Global Active Power (killowatts)",
    ylab = "Frequency")
dev.off()

