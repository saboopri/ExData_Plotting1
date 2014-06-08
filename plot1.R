plot1<-function(input){
	##The file household_power_consumption.txt needs to be downloaded and unzipped in the working
	## directory to use this code. 

	require(data.table)
	rawfile <- file(input, "r")
	cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
	close(rawfile)
	filer<-"filtered.txt"
	data<-fread(filer, header=TRUE, na.strings="?", sep=";")
	##PLOT1
	par(bg = 'white')
	hist(as.numeric(data$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
	dev.copy (png, file = "plot1.png", width=480, height=480, units="px")
	dev.off()
}