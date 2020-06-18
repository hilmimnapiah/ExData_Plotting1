library("data.table")

#Reads in data from file using Data.table
hld_pwr <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

# convert global active column to numbers.
hld_pwr[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# create a new posixct variable by combining date and time .
hld_pwr[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# subset specific dates for 2007-02-01 and 2007-02-02
hld_pwr <- hld_pwr[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(hld_pwr[, dateTime], hld_pwr[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(hld_pwr[, dateTime],hld_pwr[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(hld_pwr[, dateTime], hld_pwr[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(hld_pwr[, dateTime], hld_pwr[, Sub_metering_2], col="red")
lines(hld_pwr[, dateTime], hld_pwr[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(hld_pwr[, dateTime], hld_pwr[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
