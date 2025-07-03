## --------------------------------------------------------------------------------------------------------------
library(quantmod)

## --------------------------------------------------------------------------------------------------------------
getSymbols("ZN=F", src = "yahoo", from = "2010-01-01", auto.assign = TRUE) # 10 year bond future
getSymbols("ZF=F", src = "yahoo", from = "2010-01-01", auto.assign = TRUE) # 5 year bond future
getSymbols("ZB=F", src = "yahoo", from = "2010-01-01", auto.assign = TRUE) # 30 year bond future
getSymbols("ZT=F", src = "yahoo", from = "2010-01-01", auto.assign = TRUE) # 2 year bond future
colSums(is.na(`ZN=F`))
colSums(is.na(`ZF=F`))
colSums(is.na(`ZB=F`))
colSums(is.na(`ZT=F`))



## --------------------------------------------------------------------------------------------------------------
BF_10 <- `ZN=F`[,6]
BF_5 <- `ZF=F`[,6]
BF_30 <- `ZB=F`[,6]
BF_2 <- `ZT=F`[,6]

BF_data <- cbind(BF_2, BF_5, BF_10, BF_30)
colnames(BF_data) <- c("2 years", "5 years", "10 years", "30 years")
head(BF_data)

#write.csv(BF_data, "./Bond Future Data")


## --------------------------------------------------------------------------------------------------------------
plot(BF_data, main = "Bond Futures Adjusted Prices", multi.panel = TRUE)



## --------------------------------------------------------------------------------------------------------------
Sys.setenv(TZ = "America/New_York")

getSymbols("ZN=F", src = "yahoo", from = Sys.Date()-400, periodicity = "1minutes")
getSymbols("ZF=F", src = "yahoo", from = Sys.Date()-400, periodicity = "1minutes")
getSymbols("ZB=F", src = "yahoo", from = Sys.Date()-400, periodicity = "1minutes")
getSymbols("ZT=F", src = "yahoo", from = Sys.Date()-400, periodicity = "1minutes")
colSums(is.na(`ZN=F`))
colSums(is.na(`ZF=F`))
colSums(is.na(`ZB=F`))
colSums(is.na(`ZT=F`))





## --------------------------------------------------------------------------------------------------------------
BF_10_min <- `ZN=F`[,4]
BF_5_min <- `ZF=F`[,4]
BF_30_min <- `ZB=F`[,4]
BF_2_min <- `ZT=F`[,4]

BF_data_min <- cbind(BF_2_min, BF_5_min, BF_10_min, BF_30_min)
colnames(BF_data_min) <- c("2 years", "5 years", "10 years", "30 years")
head(BF_data_min)
tail(BF_data_min)


## --------------------------------------------------------------------------------------------------------------

# Define 11 Treasury yield tickers from FRED
tenors <- c("DGS1MO", "DGS3MO", "DGS6MO", "DGS1", "DGS2", "DGS3",
            "DGS5", "DGS7", "DGS10", "DGS20", "DGS30")

# Define date range: last 3 years from today
start_date <- Sys.Date() - (3 * 365)
end_date <- Sys.Date()

# Download data
getSymbols(tenors, src = "FRED", from = start_date, to = end_date)

# Merge all tenors into one xts object
treasury_yields <- do.call(merge, lapply(tenors, get))

# Rename columns
colnames(treasury_yields) <- tenors

# Remove rows with any NA (optional)
treasury_yields <- na.omit(treasury_yields)

# View result
head(treasury_yields)


