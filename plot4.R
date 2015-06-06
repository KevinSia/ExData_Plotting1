# reading data
epc <- read.table('household_power_consumption.txt', header=TRUE,
        colClasses=c(rep("character",2),rep("numeric",7)),sep=';',
        na.string='?')
# select observations on 01/02/2007 and 02/02/2007
obs <- epc[epc$Date=='1/2/2007' | epc$Date=='2/2/2007',]
# remove epc to save memory
rm(epc)

# Parsing date time
dt <- paste(obs$Date, obs$Time)
dt <- strptime(dt, "%d/%m/%Y %H:%M:%S")
obs[,'DateTime'] <- as.POSIXct(dt)

png(file='plot4.png', width = 480, height = 480, units = "px")
# Create 2 x 2 panes
par(mfrow=c(2,2))
# First pane
with(obs, plot(Global_active_power ~ DateTime,col='black', type='l', xlab=NA,
               ylab='Global Active Power'))
# Second pane
with(obs, plot(Voltage ~ DateTime,col='black', type='l', xlab='datetime',
               ylab='Voltage'))
# Third pane
plot(obs$Sub_metering_1 ~ obs$DateTime,col='black', type='l', xlab=NA,
     ylab='Energy sub metering')
lines(obs$Sub_metering_2 ~ obs$DateTime,col='red', type='l', xlab=NA,
      ylab='Energy sub metering')
lines(obs$Sub_metering_3 ~ obs$DateTime,col='blue', type='l', xlab=NA,
      ylab='Energy sub metering')
legend("topright",c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty=c(1,1,1),col=c('black','red','blue'),bty='n')
# Last pane
with(obs, plot(Global_reactive_power ~ obs$DateTime,col='black', type='l', xlab='datetime',
     ylab='Global_reactive_power'))
dev.off()