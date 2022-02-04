# Count syllables
speeches$syls <- sylcount(speeches$speech) # function that perfoms syllable count
speeches$syls <- sapply(speeches$syls, sum) # sylcount returns a vector, this function sums the content of each vector row by row

# Create a dataframe of syllables backbench female MSPs are speaking each day

syls_per_day_women <- speeches %>% 
  filter(gender == "F") %>%
  group_by(date) %>%
  summarise(syls = sum(syls))

syls_per_day_f_plot <- # make a plot to see the trend in how much women are speaking 
  ggplot(syls_per_day_women, aes(x=date, y=syls)) + geom_smooth(method = loess, se=FALSE, color ="black")

syls_per_day_f_plot # view plot

# Create a dataframe of syllables backbench male MSPs are speaking each day

syls_per_day_men <- speeches %>%
  filter(gender == "M") %>%
  group_by(date) %>%
  summarise(syls = sum(syls))

syls_per_day_m_plot <- # make a plot to see the trend in how much men are speaking 
  ggplot(syls_per_day_men, aes(x=date, y=syls)) + geom_smooth(method = loess, se=FALSE, color ="black")

syls_per_day_m_plot # view plot

# For the visualisation, we want to plot the proportion of all syllables that are spoken by women

# Create a dataframe that summarises the total number of syllables spoken in a day 
syls_per_day_all <- speeches %>% 
  group_by(date) %>%
  summarise(syls_all = sum(syls))

proportion_women <- full_join(syls_per_day_all, syls_per_day_women, by = "date") # join the summary dataframe for all speeches and women speakers.
proportion_women[is.na(proportion_women)] <- 0 # days where women didn't speak any sylables are still kept becayse of full_join but there is an NA, so we need to convert NAs to 0%
proportion_women$prop_f <- proportion_women$syls/proportion_women$syls_all # row-wise caluculation of proportion of a days syllables spoken by women 

syllables_women_plot <- # make visualisation 
  ggplot(proportion_women, aes(x=date, y=prop_f)) + # define data and axes 
  ggtitle("Proportion of backbencher speech time by women in Scottish Parliament") + # add plot title
  xlab("") + ylab("% syllables spoken by women MSPs") + # add axes labels 
  ylim(0,1) + # define y-axis limits
  # geom_point() + # add points, uncomment if desired
  geom_smooth(method = loess, se=FALSE, color = "black") + # add loess regression line to see trend
  theme_apa() # define plot theme 

syllables_women_plot # view plot

ggsave(here("output", "syllables-women-plot.png"), syllables_women_plot, # save plot to output data 
       width = 9,
       height = 7)


rm(syls_per_day_women, syls_per_day_f_plot, syls_per_day_men, syls_per_day_m_plot, syls_per_day_all, proportion_women) # removes intermediatary variables
