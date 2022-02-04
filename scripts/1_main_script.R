# This is main analysis script.

# First we need to install/ load packages
if(!require("here"))install.packages("here")
if(!require("tidyverse"))install.packages("tidyverse")
if(!require("sylcount"))install.packages("sylcount")
if(!require("ggplot2"))install.packages("ggplot2")
if(!require("jtools"))install.packages("jtools")

# Next we need to download raw data. ONLY RUN LINE ONCE. The following line will download a file from Harvard Dataverse to the data_raw folder on your local disk
#url <- "https://dataverse.harvard.edu/api/access/datafile/4432885"
#download.file(url, here("data_raw", "rawdata.csv"))
#rm(url)

# We then need to clean the data. In order to keep the main script a reasonable length, we will source a separate script to do this.
# The following script will add a catagory for which parliament is in, remove duplicate speeches and create a list of MSPs
source(here("scripts", "2_clean_data.R"))

# Next we should remove MSPs, with positions because we are only interested in backbenchers
speeches <- speeches %>% filter(office_held == "N/A" | # 230846 obs. of 18 vars.
                                 office_held == "." |
                                 office_held == "n/a" |
                                 is.na(office_held))


# Make a list of MSPs who remain in the sample
MSPs <- speeches %>%
  select(parl_id, name, gender, gender_num, wikidataid, constituency, region, msp_type, office_held, parly) %>%
  unique()

# Next we want to make a data frame that shows us how many female MSPs there are in each parliament 
female_msps_per_parly <- MSPs %>%
  filter(!is.na(parly)) %>% # NOT SURE WHY THERE ARE NAs, but I have removed them for the time being
  group_by(parly) %>%
  summarise(pr_f_msps = mean(gender_num))



# Plot number of women over parliamentary session 
pr_women_parly_plot <- ggplot(female_msps_per_parly, aes(x=parly, y=pr_f_msps)) +  # nolint
  geom_bar(stat = "identity", fill = "black") +
  geom_text(aes(label = signif(pr_f_msps, digits = 3)*100, vjust = -1)) + # rounds labels
  ggtitle("Proportion of backbench MSPs who are women by Parliament") +
  xlab("Parliamentary session") + ylab("% MSPs who are women") +
  ylim(0,1) +
  theme_apa()

ggsave(here("output", "pr-women-parly.png"), pr_women_parly_plot,
       width = 9,
       height = 7)



# See how many MSPs are male/female
male_msps <- MSPs %>% filter(gender == "M") %>% nrow()
female_msps <- MSPs %>% filter(gender == "F") %>% nrow()

proportion_female_msps <- female_msps/nrow(MSPs)
proportion_male_msps <- male_msps/nrow(MSPs)

# Now we want to count the number of speeches by male/female male_msps
male_speeches <- speeches %>% filter(gender == "M") %>% nrow()
female_speeches <- speeches %>% filter(gender == "F") %>% nrow()

proportion_female_speeches <- female_speeches/nrow(speeches)
proportion_male_speeches <- male_speeches/nrow(speeches)

# Look at relative ratio

female_speech_per_msp <- female_speeches/female_msps
male_speech_per_msp <- male_speeches/male_msps

# Speech analysis (produces plot in output folder)
source(here("scripts", "3_speeches_analysis.R")) # execute script, NOTE: rm line at end of script removes intermediatary variables
speeches_women_plot # view plot

# Syllable analysis (produces plot in output folder)
source(here("scripts", "4_syl_analysis.R")) # execute script
syllables_women_plot # view plot


# Pie charts
# MSPs pie chart

df_msps <- data.frame( # create data
  Gender = c("Men", "Women"),
  proportion_msps = c(proportion_male_msps, proportion_female_msps))

pie_msps <- ggplot(df_msps, aes(x="", y=proportion_msps, fill=Gender)) +
  geom_bar(width = 1, stat = "identity") +
  ylab("") + xlab("") +
  scale_fill_manual(values = c("#1E88E5","#D81B60")) +
  coord_polar("y", start = 0) +
  theme_apa(legend.pos = "right",
            legend.use.title = FALSE,
            legend.font.size = 12,
            x.font.size = 0,
            y.font.size = 0,
            facet.title.size = 0,
            remove.y.gridlines = TRUE,
            remove.x.gridlines = TRUE) 

pie_msps



# Speeches pie chart
df_speeches <- data.frame( # create data
  gender = c("Men", "Women"),
  proportion_speeches = c(proportion_male_speeches, proportion_female_speeches))

