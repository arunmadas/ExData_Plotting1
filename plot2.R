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

#convert the Date as Characters 
mydata[,1]<-suppressWarnings(as.character(mydata[,1]))
#convert the Time as Characters
mydata[,2]<-suppressWarnings(as.character(mydata[,2]))

#append Date and Time into one data frame
mergedData<-paste(mydata[,1],mydata[,2])

#convert the Character format of the merged date time into Time Format
dayData<- strptime(mergedData,"%d/%m/%Y %H:%M:%S")

#Open the PNG file with width and height as 480 each
png(file="plot2.png", width=480, height=480, bg="transparent")

# Plot the line chart with time on X axis and power on y axis, type is line chart, set the x axis label to empty, y axis label, empty plot title (main=)
# This projects the last x axis point but wont mark the tick with label=8
plot(dayData,mydata[,3],type="l",xlab="",ylab="Global Active Power (kilowatts)", main="")

# save the png file to working directory 
dev.off()

