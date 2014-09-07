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
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(1:length(hpc_subset$datetime),hpc_subset$Global_active_power,"l",xaxt="n",xlab=NA,ylab="Global Active Power")
axis(1,at=c(1,0.5*length(hpc_subset$datetime), length(hpc_subset$datetime)),c("Thu","Fri","Sat"))
plot(1:length(hpc_subset$datetime),hpc_subset$Voltage,"l",xaxt="n",xlab="datetime",ylab="Voltage")
axis(1,at=c(1,0.5*length(hpc_subset$datetime), length(hpc_subset$datetime)),c("Thu","Fri","Sat"))
plot(1:length(hpc_subset$datetime),hpc_subset$Sub_metering_1,"l",xaxt="n",xlab=NA,ylab="Energy sub metering",ylim = c(0, 25))
lines(1:length(hpc_subset$datetime),hpc_subset$Sub_metering_2,col="red","l",xaxt="n",xlab=NA,ylab="Energy sub metering")
lines(1:length(hpc_subset$datetime),hpc_subset$Sub_metering_3,col="blue","l",xaxt="n",xlab=NA,ylab="Energy sub metering")
axis(1,at=c(1,0.5*length(hpc_subset$datetime), length(hpc_subset$Time)),c("Thu","Fri","Sat"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=3,col=c("black","red","blue"))
plot(1:length(hpc_subset$datetime),hpc_subset$Global_reactive_power,"l",xaxt="n",xlab="datetime",ylab="Global_reactive_power")
axis(1,at=c(1,0.5*length(hpc_subset$datetime), length(hpc_subset$datetime)),c("Thu","Fri","Sat"))
dev.off()
