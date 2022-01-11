# This is main analysis script.

# First we need to install/ load packages
if(!require("here"))install.packages("here")
if(!require("tidyverse"))install.packages("tidyverse")
if(!require("sylcount"))install.packages("sylcount")

# Next we need to download raw data. ONLY RUN LINE ONCE. The following line will download a file from Harvard Dataverse to the data_raw folder on your local disk
#url <- "https://dataverse.harvard.edu/api/access/datafile/4432885"
#download.file(url, here("data_raw", "rawdata.csv"))
#rm(url)

# We then need to clean the data. In order to keep the main script a reasonable length, we will source a separate script to do this.
# The following script will add a catagory for which parliament is in, remove duplicate speeches and create a list of MSPs
source(here("scripts", "clean_data.R"))

# Next we should remove MSPs, with positions because we are only interested in backbenchers
speeches <- speeches %>% filter(office_held == "N/A" | # 230846 obs. of 17 vars.
                                 office_held == "." |
                                 office_held == "n/a" |
                                 is.na(office_held))
speeches$office_held <- NULL # remove variable

# Make a list of MSPs who remain in the sample
MSPs <- speeches %>%
  select(parl_id, name, gender, wikidataid, constituency, region, msp_type, office_held, parly) %>%
  unique()

# See how many MSPs are male/female
male_msps <- MSPs %>% filter(gender == "M") %>% nrow()
female_msps <- MSPs %>% filter(gender == "F") %>% nrow()

proportion_female_msps <- female_msps/nrow(MSPs)

# Now we want to count the number of speeches by male/female male_msps
male_speeches <- speeches %>% filter(gender == "M") %>% nrow()
female_speeches <- speeches %>% filter(gender == "F") %>% nrow()

proportion_female_speeches <- female_speeches/nrow(speeches)

# Look at relative ratio

female_speech_per_msp <- female_speeches/female_msps

male_speech_per_msp <- male_speeches/male_msps

# Count syllables 
speeches$syls <- sylcount(speeches$speech)
speeches$syls <- sapply(speeches$syls, sum)

# Number of sylables back-bench female MSPs are speeching per day  

syls_per_day_women <- speeches %>%
  filter(gender == "F") %>% 
  group_by(date) %>%
  summarise(syls = sum(syls))

syls_per_day_f_plot <- 
  ggplot(syls_per_day_women, aes(x=date, y=syls)) + geom_smooth(method = loess, se=FALSE, color ="black")

syls_per_day_f_plot # view plot

# Number of syllables back-bench male MSPs are speeching per day  

syls_per_day_men <- speeches %>%
  filter(gender == "M") %>% 
  group_by(date) %>%
  summarise(syls = sum(syls))

syls_per_day_m_plot <- 
  ggplot(syls_per_day_men, aes(x=date, y=syls)) + geom_smooth(method = loess, se=FALSE, color ="black")

syls_per_day_m_plot # view plot

# Proportion of sylables by women per day 

syls_per_day_all <- speeches %>%
  group_by(date) %>%
  summarise(syls_all = sum(syls))

proportion_women <- full_join(syls_per_day_all, syls_per_day_women, by = "date") # join the summary dataframe for all speeches and women speakers.
proportion_women[is.na(proportion_women)] <- 0 # days where women didn't speak any sylables are still kept becayse of full_join but there is an NA, so we need to convert NAs to 0% 
proportion_women$prop_f <- proportion_women$syls/proportion_women$syls_all

proportion_women_plot <- 
  ggplot(proportion_women, aes(x=date, y=prop_f)) + 
  geom_point() +
  geom_smooth(method = loess, se=FALSE, color ="blue") + theme_bw()

proportion_women_plot # view plot

