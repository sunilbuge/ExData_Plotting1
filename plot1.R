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
png("plot1.png", width=480, height=480)
# draw histogram for global_active_power values of limited data set
hist(hpc_subset$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",
     ylab="Frequency",main="Global Active Power" ,breaks = 13, ylim = c(0, 1200), 
     xlim = c(0, 6), xaxp = c(0, 6, 3))
dev.off()
