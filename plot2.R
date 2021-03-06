# Download data
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "./data/exdata_data_household_power_consumption.zip"
download.file(fileUrl, destfile = destination, method="curl")
unzip(destination, exdir = "./data")

#Read in the data
file <- "./data/household_power_consumption.txt"
data <- read.table(file, header=T, sep=";", stringsAsFactors=F, na.strings="?")
library(lubridate)
data$Date <- dmy(data$Date)
targetDates <- c(date("2007-02-01"), date("2007-02-02"))
data <- data[data$Date %in% targetDates,]

#Generate the plot
with(data, plot(Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xaxt='n', xlab=""))
axisLabels <- c("Thu", "Fri", "Sat")
axisIndices <- c(1, nrow(data)/2+1, nrow(data))
axis(side=1, at=axisIndices, labels=axisLabels)

#Write to png
dev.copy(png, filename="plot2.png", width = 480, height = 480)
dev.off()
