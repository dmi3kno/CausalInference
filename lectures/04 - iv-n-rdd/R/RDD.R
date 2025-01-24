# https://evalf20.classes.andrewheiss.com/example/rdd/
# https://evalf20.classes.andrewheiss.com/example/rdd-fuzzy/

library(tidyverse)  # ggplot(), %>%, mutate(), and friends
library(broom)  # Convert models to data frames
library(rdrobust)  # For robust nonparametric regression discontinuity
library(estimatr)  # Run 2SLS models in one step with iv_robust()
library(modelsummary)  # Create side-by-side regression tables
library(kableExtra)  # Fancy table formatting
library(here)

tutoring <- read_csv(here("R","tutoring_program_fuzzy.csv"))

tutoring %>% filter(tutoring==T & entrance_exam <= 70 | tutoring == F & entrance_exam >70) %>% 
  ggplot(aes(x = entrance_exam, y = tutoring_text, color = entrance_exam <= 70)) +
  # Make points small and semi-transparent since there are lots of them
  geom_point(size = 1.5, alpha = 0.5, 
             position = position_jitter(width = 0, height = 0.25, seed = 1234)) + 
  # Add vertical line
  geom_vline(xintercept = 70) + 
  # Add labels
  labs(x = "Entrance exam score", y = "Participated in tutoring program") + 
  # Turn off the color legend, since it's redundant
  guides(color = FALSE)


ggplot(tutoring, aes(x = entrance_exam, y = tutoring_text, color = entrance_exam <= 70)) +
  # Make points small and semi-transparent since there are lots of them
  geom_point(size = 1.5, alpha = 0.5, 
             position = position_jitter(width = 0, height = 0.25, seed = 1234)) + 
  # Add vertical line
  geom_vline(xintercept = 70) + 
  # Add labels
  labs(x = "Entrance exam score", y = "Participated in tutoring program") + 
  # Turn off the color legend, since it's redundant
  guides(color = FALSE)


ggplot(tutoring, aes(x = entrance_exam, y = exit_exam, color = tutoring)) +
  geom_point(size = 1, alpha = 0.5) + 
  # Add a line based on a linear model for the people scoring less than 70
  # geom_smooth(data = filter(tutoring, entrance_exam <= 70), method = "lm") +
  # Add a line based on a linear model for the people scoring 70 or more
  # geom_smooth(data = filter(tutoring, entrance_exam > 70), method = "lm") +
  geom_vline(xintercept = 70) +
  labs(x = "Entrance exam score", y = "Exit exam score", color = "Used tutoring")
