## ----setup, include=FALSE--------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(quantmod)


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



## --------------------------------------------------------------------------------------------------------------
plot(treasury_yields, main = "Bond Prices", multi.panel = FALSE)

