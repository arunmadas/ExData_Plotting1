##########################################################################
#Author : Arun Kumar Madas
#DAte   : 04/08/2015
##########################################################################

# Read the entire file
# Assumption working directory is set in RStudio, or we can explicity set with setwd() command
mydata<-read.csv("household_power_consumption.txt",header=TRUE,sep=";")

#Since data is read as char we can subset for required dates 1/2/2007, 2/2/2007
#Alternate option is to convert the char date column to date type column and match the date equivalent, 
#    but this approach works equally better because it matches the date string match
# Also, there was no requirement to convert dates though it was a recommendation
mydata<-subset(mydata,Date=='1/2/2007' | Date=='2/2/2007')

# Data is read as factor, so need to convert to Char and cast as numeric type and suppress warnings for NA
mydata[,3]<-suppressWarnings(as.numeric(as.character(mydata[,3])))

# Data is read as factor, so need to convert to Char and cast as numeric type and suppress warnings for NA
mydata[,5]<-suppressWarnings(as.numeric(as.character(mydata[,5])))

# Data is read as factor, so need to convert to Char and cast as numeric type and suppress warnings for NA
mydata[,4]<-suppressWarnings(as.numeric(as.character(mydata[,4])))


sub_metering_1 <-suppressWarnings(as.numeric(as.character(mydata[,7])))
sub_metering_2 <-suppressWarnings(as.numeric(as.character(mydata[,8])))
sub_metering_3 <-suppressWarnings(as.numeric(as.character(mydata[,9])))

#convert the Date as Characters 
mydata[,1]<-suppressWarnings(as.character(mydata[,1]))
#convert the Time as Characters
mydata[,2]<-suppressWarnings(as.character(mydata[,2]))

#append Date and Time into one data frame
mergedData<-paste(mydata[,1],mydata[,2])

#convert the Character format of the merged date time into Time Format
dayData<- strptime(mergedData,"%d/%m/%Y %H:%M:%S")

#Open the PNG file with width and height as 480 each
png(file="plot4.png", width=480, height=480, bg="white")

par(mfrow=c(2,2))

#Plot1
plot(dayData,mydata[,3],type="l",xlab="",ylab="Global Active Power (kilowatts)", main="")

#Plot2
plot(dayData,mydata[,5],type="l",xlab="datetime",ylab="Voltage", main="")

#Plot3
xrange<-range(dayData)
yrange<-c(0,38)

# Plot the line chart with time on X axis and power on y axis, type is line chart, set the x axis label to empty, y axis label, empty plot title (main=)
# This projects the last x axis point but wont mark the tick with label=8
plot(xrange,yrange,type="n",xlab="",ylab="Energy sub metering", main="", yaxt="n")
lines(dayData,sub_metering_1,type="l",col="black")
lines(dayData,sub_metering_2,type="l",col="red")
lines(dayData,sub_metering_3,type="l",col="blue")
axis(2, at=c(0,10,20,30))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),,lty=c(1,1,1),col=c("black","red","blue"), bty="n")

#Plot4
plot(dayData,mydata[,4],type="l",xlab="datetime",ylab="Global_reactive_power", main="")

# save the png file to working directory 
dev.off()

