#########################################################################################################
# Name             : GGVIS Examples
# Date             : 07-24-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Making life a little easier
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150724???             initial
#########################################################################################################

library(ggvis)


##__________________________________________________________________________________________________________________________________________
# Scatterplot
faithful %>% 
  ggvis(~waiting, ~eruptions) %>% 
  layer_points()

mtcars %>% ggvis(~mpg, ~hp, size = ~mpg) %>% layer_points()

faithful %>% 
  ggvis(~waiting, ~eruptions, 
        size = ~eruptions, opacity := 0.5, 
        fill := "blue", stroke := "black") %>% 
  layer_points()

##__________________________________________________________________________________________________________________________________________
# Line plots
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()


pressure %>% 
  ggvis(~temperature, ~pressure, 
        stroke := "red", strokeWidth := 2, strokeDash := 6) %>% 
  layer_lines()

##__________________________________________________________________________________________________________________________________________
# regression
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

mtcars %>% ggvis(x = ~wt, y = ~mpg) %>%
  layer_points() %>%
  layer_smooths(stroke := "red")

mtcars %>% ggvis(x = ~wt, y = ~mpg) %>%
  layer_points() %>%
  layer_smooths(stroke := "red", se = TRUE)

##__________________________________________________________________________________________________________________________________________
# Histogram

faithful %>% ggvis(~waiting) %>% layer_histograms(width = 5)
mtcars %>% ggvis(~mpg) %>% layer_histograms(width = 5)
mtcars %>% ggvis(~mpg,fill := "blue") %>% layer_histograms(width = 5)

##__________________________________________________________________________________________________________________________________________
# Density
faithful %>% ggvis(~waiting, fill := "green") %>% layer_densities()

##__________________________________________________________________________________________________________________________________________
# barplot
mtcars %>% compute_count(~factor(cyl))
mtcars %>% compute_count(~factor(am))

mtcars %>% ggvis(~factor(am)) %>% layer_bars()

mtcars %>% ggvis(~factor(carb),fill := "green") %>% layer_bars()

##__________________________________________________________________________________________________________________________________________
# boxplots

mtcars %>% ggvis(~cyl, ~mpg) %>% layer_boxplots()
# Setting width=0.5 makes it 0.5 wide in the data space, which is 1/4 of the
# distance between data values in this particular case.
mtcars %>% ggvis(~cyl, ~mpg) %>% layer_boxplots(width = 0.5)

##__________________________________________________________________________________________________________________________________________
# Advanced Plots
hec <- as.data.frame(xtabs(Freq ~ Hair + Eye, HairEyeColor))

hec %>% group_by(Eye) %>%
  ggvis(x = ~Hair, y = ~Freq, fill = ~Eye, fillOpacity := 0.5) %>%
  layer_bars(stack = FALSE) %>%
  scale_nominal("fill",
                domain = c("Brown", "Blue", "Hazel", "Green"),
                range = c("#995522", "#88CCFF", "#999933", "#00CC00"))

# With stacking
hec %>% group_by(Eye) %>%
  ggvis(x = ~Hair, y = ~Freq, fill = ~Eye, fillOpacity := 0.5) %>%
  layer_bars() %>%
  scale_nominal("fill",
                domain = c("Brown", "Blue", "Hazel", "Green"),
                range = c("#995522", "#88CCFF", "#999933", "#00CC00"))

hec %>% group_by(Eye) %>%
  ggvis(y = ~Hair, fill = ~Eye, fillOpacity := 0.5) %>%
  compute_stack(stack_var = ~Freq, group_var = ~Hair) %>%
  layer_rects(x = ~stack_lwr_, x2 = ~stack_upr_, height = band()) %>%
  scale_nominal("y", range = "height", padding = 0, points = FALSE) %>%
  scale_nominal("fill",
                domain = c("Brown", "Blue", "Hazel", "Green"),
                range = c("#995522", "#88CCFF", "#999933", "#00CC00"))








