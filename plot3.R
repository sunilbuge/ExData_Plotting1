# read data from downloaded file Sunil Buge
hpc_data <-read.table("./household_power_consumption.txt",header=TRUE,sep=";",
                      col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                      colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = c("?","NA"))

# define Criteria to subset data between 2 dates
date_criteria<-(as.Date(hpc_data$Date, "%d/%m/%Y")=='2007-01-01' | as.Date(hpc_data$Date, "%d/%m/%Y")=='2007-01-02')
#Subset of limited rows to plot
hpc_subset<-hpc_data[date_criteria,]
# combine date & time by adding datetime column to data frame
hpc_subset$datetime <- strptime(paste(hpc_subset$Date, hpc_subset$Time), "%d/%m/%Y %H:%M:%S")
# define png file to store histogram chart
png("plot3.png", width=480, height=480)
# draw graph for global_active_power values of limited data set
plot(hpc_subset$datetime, 
     hpc_subset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering",  ylim = c(0, 25))
lines(hpc_subset$datetime, 
       hpc_subset$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "red")
lines(hpc_subset$datetime, 
       hpc_subset$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", 
                                                                        "Sub_metering_2", "Sub_metering_3"))
dev.off()
