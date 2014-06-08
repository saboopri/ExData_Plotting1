plot2<-function(input){
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
	##PLOT2
	par(bg='white')
	plot(x=x$datetime, y=as.numeric(x$data.Global_active_power), type="l", ylab="Global Active Power (kilowatts)", xlab="")
	dev.copy(png, file="plot2.png", width=480, height=480, units="px")
	dev.off()
}