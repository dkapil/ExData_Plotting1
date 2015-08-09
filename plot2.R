## Downloading and Extracting file. This checks if the already exists file is present and is not corrupted.
if(!file.exists("household_power_consumption.txt")|file.size("household_power_consumption.txt")<=0)
{
        download.file(url = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "powerconsumption.zip")
        unzip("powerconsumption.zip")
}

## Extracting header seperately to be used as column names further
header<-read.table("household_power_consumption.txt",sep = ";",nrows=1)
colnames<-as.character(unlist(header))


## Reading only data of required dates 1/2/2007 & 2/2/2007. Skips and nrows were used to read the specific data.
powerconsumption<-read.table("household_power_consumption.txt",sep = ";",na.strings = "?",header = FALSE,skip=66637,nrows=2880,col.names = colnames)

## Converting time to POSIXct using strptime. We pasted the date information with time because the times are for these dates only and a as a POSIXct it should have the date information also. If we would not have combined these two then converted time would be having the wrong dates.
powerconsumption$Time=strptime(paste(powerconsumption$Date,powerconsumption$Time),format = "%d/%m/%Y %H:%M:%S")
powerconsumption$Date=as.Date(powerconsumption$Date,format = '%d/%m/%Y')

## Creating Plot 2
png(file = "plot2.png")
with(powerconsumption,plot(Time,Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatts)"))
dev.off()
print("Plot Created Successfully")