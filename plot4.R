plot4<-function(input){
	##The file household_power_consumption.txt needs to be downloaded and unzipped in the working
	## directory to use this code. 

	require(data.table)
	rawfile <- file(input, "r")
	cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
	close(rawfile)
	filer<-"filtered.txt"
	data<-fread(filer, header=TRUE, na.strings="?", sep=";")
	
	dt<-paste(data$Date, data$Time, sep=" ")
	datetime<-as.POSIXlt(dt, format="%d/%m/%Y %H:%M:%S")
	x<-data.frame(data$Global_active_power, datetime)
	
	##PLOT4
	par(bg='white', mfrow=c(2,2))
	##1
	plot(x=x$datetime, y=as.numeric(x$data.Global_active_power), type="l", ylab="Global Active Power (kilowatts)", xlab="")
	##2
	plot(x=x$datetime, y=as.numeric(data$Voltage), type="l", ylab="Voltage", xlab="datetime")
	##3
	plot(x=x$datetime, y=as.numeric(data$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="")
	points(x=x$datetime, y=as.numeric(data$Sub_metering_1), col="black", type="l")
	points(x=x$datetime, y=as.numeric(data$Sub_metering_2), col="red", type="l")
	points(x=x$datetime, y=as.numeric(data$Sub_metering_3), col="blue", type="l")
	legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), ncol=1, cex=0.8, bty="n", inset=c(0,0), text.col=c("black"))
	##4
	plot(x=x$datetime, y=as.numeric(data$Global_reactive_power), type="l", ylab="Global_reactive_power", xlab="")

	dev.copy(png, file="plot4.png", width=480, height=480, units="px")
	dev.off()
}