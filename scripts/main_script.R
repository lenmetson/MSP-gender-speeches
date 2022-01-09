# This is main analysis script.

# First we need to install/ load packages
if(!require("here"))install.packages("here")
if(!require("tidyverse"))install.packages("tidyverse")

# Next we need to download raw data. ONLY RUN LINE ONCE. The following line will download a file from Harvard Dataverse to the data_raw folder on your local disk
url <- "https://dataverse.harvard.edu/api/access/datafile/4432885"
download.file(url, here("data_raw", "rawdata.csv"))
rm(url)

# We then need to clean the data. In order to keep the main script a reasonable length, we will source a separate script to do this.
# The following script will add a catagory for which parliamnet a speech is in.
source(here("scripts", "clean_data.R"))
