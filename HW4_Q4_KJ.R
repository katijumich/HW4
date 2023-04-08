#Problem 4 / HW4
#Kati Johnson
#install.packages("tidyverse")
#install.packages("ggrepel")
library(tidyverse)
library(ggplot2)
#install.packages('ggridges')
library(ggridges)
library(lubridate)
library(ggrepel)
library(colorspace)

#changes made were start date was adjusted to 2010-01-01 and colors were adjusted to purple, green, and gold

load("C:\\Users\\kati.johnson\\Desktop\\DATA\\preprint_growth.rda") #please change the path if needed
head(preprint_growth)
preprint_growth %>% filter(archive == "bioRxiv") %>%
  filter(count > 0) -> biorxiv_growth
preprints<-preprint_growth %>% filter(archive %in%
                                        c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")) %>%filter(count > 0) %>%
  mutate(archive = factor(archive, levels = c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")))
1
preprints_final <- filter(preprints, date == ymd("2017-01-01"))
ggplot(preprints) +
  aes(date, count, color = archive, fill = archive) +
  geom_line(size = 1) +
  scale_y_continuous(
    limits = c(0, 600), expand = c(0, 0),
    name = "preprints / month",
    sec.axis = dup_axis( #this part is for the second y axis
      breaks = preprints_final$count, #and we use the counts to position our labels
      labels = c("arXivq-bio", "PeerJPreprints", "bioRxiv"),
      name = NULL)
  ) +
  scale_x_date(name = "year",
               limits = ymd(c("2010-01-01","2017-01-01"))) +
  scale_color_manual(values = c("#7654A0", "#E0A030", "#2E8B57"),
                     name = NULL) +
  theme(legend.position = "none")


