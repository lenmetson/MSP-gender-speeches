# Data
harvard <- read.csv(here("data_raw", "rawdata.csv")) # 475869 obs. of 21 vars.
speeches <- harvard %>% filter(is_speech == 1) # 430577 obs. of 21 vars.
rm(harvard)
speeches <- speeches %>% filter(!is.na(parl_id)) # drop all without parl_id, 399256 obs. of 21 vars.

# Next, we are going to label which parliament each speech was made in.

# Firstly, load a csv which is stored in data_raw. This is pre-loaded into the GitHub repository

years <- read.csv(here("data_raw", "years.csv"))

years$Election.Date <- as.Date(years$Election.Date, format = "%d-%m-%Y") # format dates
years$Dissolution.Date <- as.Date(years$Dissolution.Date, format = "%d-%m-%Y")
speeches$date <- as.Date(speeches$date, format = "%Y-%m-%d")

speeches$parly <- ifelse(speeches$date >= years[1,2] & speeches$date <= years[1,3], "1st",
                  ifelse(speeches$date >= years[2,2] & speeches$date <= years[2,3], "2nd",
                  ifelse(speeches$date >= years[3,2] & speeches$date <= years[3,3], "3rd",
                  ifelse(speeches$date >= years[4,2] & speeches$date <= years[4,3], "4th",
                  ifelse(speeches$date >= years[5,2] & speeches$date <= years[5,3], "5th",
                  ifelse(speeches$date >= years[6,2], "6th",
                  NA)))))) # 399256 obs. of 22 vars

rm(years)

# There are some duplicate speeches, so the following code removes them

speeches <- speeches %>%
  select(committee, date, item, type, office_held, name, display_as, speech, parl_id, party, gender, constituency, region, msp_type, wikidataid, party.facts.id, parly) %>%
  unique()

# Add gender_num variable 
# F == 1; M == 0

speeches$gender_num <- NA
speeches$gender_num[speeches$gender == "F"] <- 1
speeches$gender_num[speeches$gender == "M"] <- 0
