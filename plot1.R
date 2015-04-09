##########################################################################
#Author : Arun Kumar Madas
#DAte   : 04/08/2015
##########################################################################

#Read the entire file
# Assumption working directory is set in RStudio, or we can explicity set with setwd() command
mydata<-read.csv("household_power_consumption.txt",header=TRUE,sep=";")

#Since data is read as char we can subset for required dates 1/2/2007, 2/2/2007
#Alternate option is to convert the char date column to date type column and match the date equivalent, 
#    but this approach works equally better because it matches the date string match
# Also, there was no requirement to convert dates though it was a recommendation
mydata<-subset(mydata,Date=='1/2/2007' | Date=='2/2/2007')

# Data is read as factor, so need to convert to Char and cast as numeric type and suppress warnings for NA
mydata[,3]<-suppressWarnings(as.numeric(as.character(mydata[,3])))

#Open the PNG file with width and height as 480 each
png(file="plot1.png", width=480, height=480, bg="transparent")

#Plot the histogram with color as red, label x (xlab), plot title (main=), set the xlimits from 0 to 8 and set X axis to label only from 0-6
# This projects the last x axis point but wont mark the tick with label=8
hist(mydata[,3],col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power", xlim=c(0,8), xaxt="n")

# Mark the ticks for x axis at 0,2,4,6 points only leaving 8 hidden
axis(1, at=c(0,2,4,6))

# save the png file to working directory 
dev.off()

