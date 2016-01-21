# Get environmental data
# Crystal 2015/11/11
library(jsonlite)
library(XML)
library(xml2)
#library(data.table)
library(httr)

#PDO
PDO_raw <- fromJSON("https://www.ncdc.noaa.gov/teleconnections/pdo/data.json")
PDO_raw <- as.matrix(unlist(PDO_raw[2]$data))
PDO <- data.frame(date = as.numeric(row.names(PDO_raw)), value = as.numeric(PDO_raw)) 

#SOI
SOI_raw <- fromJSON("https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/data.json")
SOI_raw <- as.matrix(unlist(SOI_raw[2]$data))
SOI <- data.frame(date = as.numeric(row.names(SOI_raw)), value = as.numeric(SOI_raw)) 

#NPGO
URL_npgo <- "http://www.o3d.org/npgo/npgo.php"
npgo_pre <- xpathSApply(content(GET(URL_npgo)),"/html/body/pre", xmlValue)
npgo_cols <- scan(textConnection(npgo_pre), skip=25, nlines=1, what=character()) # Get header row
npgo_cols <- npgo_cols[2:4] # select column names
npgo_df <- read.csv(file=textConnection(npgo_pre), skip=26, stringsAsFactors=F, sep="",
                    header=FALSE, col.names=npgo_cols, strip.white=TRUE)

#SIO pier SST

#CalCOFI coastal station average SST