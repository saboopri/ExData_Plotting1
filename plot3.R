plot3<-function(input){
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
	##PLOT3
	par(bg='white')
	plot(x=x$datetime, y=as.numeric(data$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="")
	points(x=x$datetime, y=as.numeric(data$Sub_metering_1), col="black", type="l")
	points(x=x$datetime, y=as.numeric(data$Sub_metering_2), col="red", type="l")
	points(x=x$datetime, y=as.numeric(data$Sub_metering_3), col="blue", type="l")
	legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=1.5)

	dev.copy(png, file="plot3.png", width=480, height=480, units="px")
	dev.off()
}