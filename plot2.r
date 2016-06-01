# Exploratory Data Analysis - Assignment 01
# -----------------------------------------------------------------------------
# Making Plots - plot2.R -> plot2.png
#
# Our overall goal here is simply to examine how household energy usage varies
# over a 2-day period in February, 2007. Your task is to reconstruct the example
# plots, which were constructed using the base plotting system.
#
# For each plot you should construct the plot and save it to a PNG file with a
# width of 480 pixels and a height of 480 pixels. Create a separate R code file
# that constructs the corresponding plot (eg. plotN.R makes the plotN.png plot).
# The code file should include code for reading the data so that the plot can be
# fully reproduced. You must also include the code that creates the PNG file.
#
# When loading the dataset into R, consider the following:
# The dataset has 2,075,259 rows and 9 columns. First estimate how much memory
# the data will require before reading into R, to ensure your computer has
# enough memory (most modern computers should be fine). We will only be using
# data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the
# data from just those dates rather than reading in the entire dataset and
# subsetting to those dates. You may find it useful to convert the Date and Time
# variables to Date/Time classes in R using the strptime() and as.Date()
# functions. Note that in this dataset missing values are coded as ?.
# -----------------------------------------------------------------------------

# Setup the working environment...
# Remove everything from the workspace and set the working directory...
rm(list = ls())
setwd('W://code//R-Stats//Coursera//04 - ExploratoryDataAnalysis Assgn01')

# Define the data directory and files and download the data if necessary...
dataDir         <- "./data"
dataZip         <- paste(dataDir, "data.zip", sep="/")
dataFile        <- paste(dataDir, "household_power_consumption.txt", sep="/")

# Download and Unzip the data if necessary...
if(!file.exists(dataFile)){
    if(!file.exists(dataZip)){
        url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
        download.file(url,destfile = dataZip)
    }
    unzip(dataZip, exdir=dataDir) 
}

# Load the data - load the first 5 rows initially to ascertain the column
# classes in advance of the main data loading operation, as this is apparently
# much faster (http://www.biostat.jhsph.edu/~rpeng/docs/R-large-tables.html)
data5rows       <- read.table(dataFile, header=TRUE, sep=";",
                 na.strings="?", nrows = 5)
classes         <- sapply(data5rows, class)
dataFull        <- read.table(dataFile, header=TRUE, colClasses=classes,
                 sep=";", na.strings="?")

# Reclassify the Date columns as Date class then subset for the required dates.
# Convert the Time field into DateTime in Posix format, then delete the full
# dataset to save memory...
dataFull$Date   <- as.Date(dataFull$Date, "%d/%m/%Y")
dataMain        <- subset(dataFull, (Date=="2007-02-01") | (Date=="2007-02-02"))
dataMain$Time <- paste(dataMain$Date,dataMain$Time)
names(dataMain)[2] <- "DateTime"
dataMain$DateTime <- strptime(dataMain$DateTime, "%Y-%m-%d %H:%M:%S")
rm(dataFull)

# Make Plot2 on screen...
with(dataMain, plot(DateTime,Global_active_power, type = "l", xlab = "",
    ylab = "Global Active Power (kilowatts)", main =""))

# Copy Plot2 to PNG file...
dev.copy(png, file="plot2.png")
dev.off()