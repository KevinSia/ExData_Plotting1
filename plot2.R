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

# plot xy plot
png(file='plot2.png', width = 480, height = 480, units = "px")
with(obs, plot(Global_active_power ~ DateTime,col='black', type='l', xlab=NA,
        ylab='Global Active Power (kilowatts)'))
dev.off()