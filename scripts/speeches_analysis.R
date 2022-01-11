# Number of speeches by backbench female MSPs each day

speeches_per_day_women <- speeches %>%
  filter(gender == "F") %>%
  group_by(date) %>%
  summarise(n_speeches_f = n())

speeches_per_day_f_plot <-
    ggplot(speeches_per_day_women, aes(x=date, y=n_speeches_f)) + geom_smooth(method = loess, se=FALSE, color ="black")

speeches_per_day_f_plot # view plot

# Number of speeches by backbench male MSPs each day
speeches_per_day_men <- speeches %>%
  filter(gender == "M") %>%
  group_by(date) %>%
  summarise(n_speeches_m = n())

speeches_per_day_m_plot <-
      ggplot(speeches_per_day_men, aes(x=date, y=n_speeches_m)) + geom_smooth(method = loess, se=FALSE, color ="black")

speeches_per_day_m_plot # view plot

# Proportion of speeches by women per day

speeches_per_day_all <- speeches %>%
  group_by(date) %>%
  summarise(n_speeches_all = n())

proportion_women_speeches <- full_join(speeches_per_day_all, speeches_per_day_women, by = "date")
proportion_women_speeches[is.na(proportion_women_speeches)] <- 0 # days where women didn't speak any sylables are still kept becayse of full_join but there is an NA, so we need to convert NAs to 0%
proportion_women_speeches$prop_f_sp <- proportion_women_speeches$n_speeches_f/proportion_women_speeches$n_speeches_all

speeches_women_plot <-
  ggplot(proportion_women_speeches, aes(x=date, y=prop_f_sp)) +
  ggtitle("Proportion of backbench speeches by women MSPs") +
  xlab("") + ylab("% speeches by women") +
  ylim(0,1) +
  geom_smooth(method = loess, se=FALSE, color = "black") +
  theme_apa()

speeches_women_plot # view ggplot

ggsave(here("output", "speeches-women-plot.png"), speeches_women_plot,
       width = 9,
       height = 7)

rm(speeches_per_day_women,speeches_per_day_f_plot, speeches_per_day_men, speeches_per_day_m_plot,
  speeches_per_day_all, proportion_women_speeches)
