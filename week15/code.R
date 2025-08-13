#http://varianceexplained.org/r/improving-pie-chart/
library(readr)

d <- read_csv("Task,< 1 a week,1-4 a week,1-3 a day,>4 a day
Basic exploratory data analysis,11,32,46,12
Data cleaning,19,42,31,7
Machine learning/statistics,34,29,27,10
Creating visualizations,23,41,29,7
Presenting analysis,27,47,20,6
Extract/transform/load,43,32,20,5")

# reorganize
library(tidyr)
d <- gather(d, Hours, Percentage, -Task)
library(ggplot2)
theme_set(theme_bw())

ggplot(d, aes(Hours, Percentage)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Task)

ggplot(d, aes(Hours, Percentage, color = Task, group = Task)) +
  geom_line()

ggplot(d, aes(Hours, Task, fill = Percentage)) +
  geom_tile(show.legend = FALSE) +
  geom_text(aes(label = paste0(Percentage, "%")), color = "white")

ggplot(d, aes(Hours, Percentage)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Task) +
  theme(axis.text.x = element_text(angle = 90,  hjust = 1))

ggplot(d, aes(Hours, Percentage)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Task) +
  geom_text(aes(label = paste0(Percentage, "%"), y = Percentage),
            vjust = 1.4, size = 5, color = "white")

library(dplyr)

d %>%
  mutate(Task = reorder(Task, Percentage, function(e) e[1])) %>%
  ggplot(aes(Hours, Percentage)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Task) +
  geom_text(aes(label = paste0(Percentage, "%"), y = Percentage),
            vjust = 1.4, size = 5, color = "white") +
  theme(axis.text.x = element_text(angle = 90,  hjust = 1)) +
  xlab("Hours spent per week")

library(ggthemes)

d %>%
  mutate(Task = reorder(Task, Percentage, function(e) e[1])) %>%
  ggplot(aes(Hours, Percentage)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Task) +
  geom_text(aes(label = paste0(Percentage, "%"), y = Percentage),
            vjust = 1.4, size = 5, color = "white") +
  theme_tufte() +
  theme(axis.text.x = element_text(angle = 90,  hjust = 1))