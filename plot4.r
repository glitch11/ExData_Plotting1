plot4<-function(){
  ##This assumes that you have the file for analysis downloaded and placed within your working directory and named as the original
  ##file name.  Saves you from downloading it again.  Refer to course instructions for
  ##downloading location.
  
  ##Read File
  household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
  
  ##Add column with date object
  household_power_consumption$newdate <- strptime(as.character(household_power_consumption$Date), "%d/%m/%Y")
  
  ##Subset data frame based on 2007-02-01 and 2007-02-02
  twodays<-subset(household_power_consumption, newdate=='2007-02-01' | newdate=='2007-02-02')
  
  ##convert Global_active_power into float
  twodays$Global_active_power<-as.numeric(twodays$Global_active_power)
  
  ##convert Sub_metering 1,2,3 into numerics
  twodays$Sub_metering_1<-as.numeric(twodays$Sub_metering_1)
  twodays$Sub_metering_2<-as.numeric(twodays$Sub_metering_2)  
  twodays$Sub_metering_3<-as.numeric(twodays$Sub_metering_3)
  twodays$Voltage<-as.numeric(twodays$Voltage)
  ##convert date and time fields into one date and time field
  twodays$datetime<-paste(twodays$Date, twodays$Time)
  twodays$newdatetime <- strptime(as.character(twodays$datetime), "%d/%m/%Y %H:%M:%S")
  
  
  
  ## add plot
  par(mfrow=c(2,2))
  
  with(twodays, {
    plot(newdatetime, Global_active_power, 
         type = "l",
         main = "",
         xlab="",
         ylab="Global Active Power")
    plot(newdatetime, Voltage,
         type = "l",
         main="",
         xlab="datetime",
         ylab="Voltage")
    
    ##plot3()  
    {with(twodays, plot(newdatetime, Sub_metering_1, 
                        main = "",
                        xlab="",
                        ylab="Energy sub metering",
                        type = "n"))
     with(twodays, points(newdatetime, Sub_metering_1, 
                          type = "l"))
     with(twodays, points(newdatetime, Sub_metering_2, 
                          type = "l",
                          col = "red"))
     with(twodays, points(newdatetime, Sub_metering_3, 
                          type = "l",
                          col = "blue"))
     legend("topright", 
            lwd = c(1,1,1),
            cex = 0.5,
            bty="n",
            col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
     )}
    
    
    plot(newdatetime, Global_reactive_power,
         type="l",
         main="",
         xlab="datetime",
         ylab="Global_reactive_power")
  })  
         
  ##export to.png
  
  dev.copy(png, file = "plot4.png")
  dev.off()
}