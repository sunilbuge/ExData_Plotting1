# read data from downloaded file Sunil Buge
hpc_data <-read.table("./household_power_consumption.txt",header=TRUE,sep=";")
,
                      col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                      colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = c("?","NA"))

# define Criteria to subset data between 2 dates
date_criteria<-(as.Date(hpc_data$Date, "%d/%m/%Y")=='2007-01-01' | as.Date(hpc_data$Date, "%d/%m/%Y")=='2007-01-02')
#Subset of limited rows to plot
hpc_subset<-hpc_data[date_criteria,]
# combine date & time by adding datetime column to data frame
hpc_subset$datetime <- strptime(paste(hpc_subset$Date, hpc_subset$Time), "%d/%m/%Y %H:%M:%S")
# define png file to store histogram chart
png("plot2.png", width=480, height=480)
# draw graph for global_active_power values of limited data set
plot(1:length(strptime(paste(hpc_subset$Date, hpc_subset$Time), "%d/%m/%Y %H:%M:%S")),
              hpc_subset$Global_active_power,"l",xaxt="n",xlab=NA,ylab="Global Active Power (kilowatts)")
axis(1,at=c(1,0.5*length(strptime(paste(hpc_subset$Date, hpc_subset$Time), "%d/%m/%Y %H:%M:%S")),
            length(strptime(paste(hpc_subset$Date, hpc_subset$Time), "%d/%m/%Y %H:%M:%S"))),
     c("Thu","Fri","Sat"))
dev.off()


