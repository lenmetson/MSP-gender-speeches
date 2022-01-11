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

# Number of syllables back-bench male MSPs are speaking per day

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

syllables_women_plot <-
  ggplot(proportion_women, aes(x=date, y=prop_f)) +
  ggtitle("Proportion of backbencher speech time by women in Scottish Parliament") +
  xlab("") + ylab("% syllables spoken by women MSPs") +
  ylim(0,1) +
  # geom_point() +
  geom_smooth(method = loess, se=FALSE, color = "black") +
  theme_apa()

syllables_women_plot # view plot

ggsave(here("output", "syllables-women-plot.png"), syllables_women_plot,
       width = 9,
       height = 7)


rm(syls_per_day_women, syls_per_day_f_plot, syls_per_day_men, syls_per_day_m_plot, syls_per_day_all, proportion_women, syllables_women_plot)
