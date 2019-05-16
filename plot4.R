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
par(mfcol=c(2,2))
# same as plot 2
with(data, plot(Global_active_power, type="l", ylab="Global Active Power", xaxt='n', xlab=""))
axisLabels <- c("Thu", "Fri", "Sat")
axisIndices <- c(1, nrow(data)/2+1, nrow(data))
axis(side=1, at=axisIndices, labels=axisLabels)
# same as plot 3
with(data, plot(Sub_metering_1, type="l", xaxt="n", xlab="", ylab="Energy sub metering"))
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")
axis(side=1, at=axisIndices, labels=axisLabels)
nameIndices <- grep("Sub_metering_[1-9]$",names(data))
legend("topright", col=c("black","red","blue"), legend=names(data)[nameIndices], lty=1, cex=0.75)
# third plot
with(data, plot(Voltage, type="l", xlab="datetime", xaxt="n"))
axis(side=1, at=axisIndices, labels=axisLabels)
# fourth plot
with(data, plot(Global_reactive_power, type="l", xlab="datetime", xaxt="n"))
axis(side=1, at=axisIndices, labels=axisLabels)

#Write to png
dev.copy(png, filename="plot4.png", width = 480, height = 480)
dev.off()