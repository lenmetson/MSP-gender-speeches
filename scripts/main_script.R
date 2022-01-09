# This is main analysis script.

# First we need to install/ load packages
if(!require("here"))install.packages("here")
if(!require("tidyverse"))install.packages("tidyverse")

# Next we need to download raw data. ONLY RUN LINE ONCE. The following line will download a file from Harvard Dataverse to the data_raw folder on your local disk
url <- "https://dataverse.harvard.edu/api/access/datafile/4432885"
download.file(url, here("data_raw", "rawdata.csv"))
rm(url)

# We then need to clean the data. In order to keep the main script a reasonable length, we will source a separate script to do this.
# The following script will add a catagory for which parliament is in, remove duplicate speeches and create a list of MSPs
source(here("scripts", "clean_data.R"))

# Next we should remove MSPs, with positions because we are only interested in backbenchers
speeches <- speeches %>% filter(office_held == "N/A" | # 230846obvs of 17vars
                                 office_held == "." |
                                 office_held == "n/a" |
                                 is.na(office_held))

# Make a list of MSPs who remain in the sample 
MSPs <- speeches %>%
  select(parl_id, name, gender, wikidataid, constituency, region, msp_type, office_held, parly) %>%
  unique()
