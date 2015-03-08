plot1<-function(){
  
##This assumes that you have the file for analysis downloaded and placed within your working directory and named as the original
##file name.  Saves you from downloading it again.  Refer to course instructions for
##downloading location.    
  
##Read File
household_power_consumption <- read.csv("C:/specdata/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

##Add column with date object
household_power_consumption$newdate <- strptime(as.character(household_power_consumption$Date), "%d/%m/%Y")

##Subset data frame based on 2007-02-01 and 2007-02-02
twodays<-subset(household_power_consumption, newdate=='2007-02-01' | newdate=='2007-02-02')

##convert Global_active_power into float
twodays$Global_active_power<-as.numeric(twodays$Global_active_power)

## add plot
hist(twodays$Global_active_power, 
     main="Global Active Power", 
     col="Red", 
     ylab="Frequency", 
     xlab="Global Active Power (kilowatts)")

##export to.png
dev.copy(png, file = "plot1.png")
dev.off()
}