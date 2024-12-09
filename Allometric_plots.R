## Codes related to Allometric plots

#libraries
library(readxl)
library(ggplot2)
library(dplyr)

## Generation Length vs Body mass
# Data from Pacifici, Michela, et al. "Generation length for mammals." Nature Conservation 5 (2013): 89-94.
GLdata = read_excel("GLmammals.xlsx")

# NA in cases where calculated_GL_d not present
GLdata$Calculated_GL_d[which(GLdata$Calculated_GL_d == "no information")] = NA

o = unique(GLdata$Order)

# we included only data points where GL was calculated based on observations of the species itself, excluding data derived from congenerics species,
# higher taxonomic levels (family or order), or estimates based on body mass. 
a = GLdata %>%
  filter(Sources_GL == "GMA" | Sources_GL == "Rspan-AFB" | Sources_GL == "Rspan-AFR" | Sources_GL == "Rspan-ASMmales" ) %>%
  filter(AdultBodyMass_g>100 & AdultBodyMass_g<100000)

GL_BM_data_filtered = a

# GL and BM data points manually selected
y1 = c(2,2, 5,5,5,5, 10,10,10)*360
x1 = c(10.81,6.09, 76.34,38.65,20.65,6.09, 76.34, 38.65, 6.09)*1000
d = data.frame(x1,y1)

# data points selected for simulation 
y2 = c(0.5, 5,10)*360
x2 = c(300, 76.34, 6.09)*1000
d2 = data.frame(x2, y2)


## Figure 4 (A) in main text and Figure S6 (A) in Supplementary Material
plot_GL_BM = ggplot(a, aes(x = as.numeric(AdultBodyMass_g), y  = as.numeric(GenerationLength_d), color = Order))+
  geom_point(size = 3.5, alpha = 0.3)+
  #labs(title = "C")+
  geom_point(data = d, aes(x = x1, y = y1), color = 'black', shape = 19, size = 3)+
  geom_point(data = d2, aes(x = x2[2], y = y2[2]), color = 'orange', shape = 15, size = 6)+
  geom_point(data = d2, aes(x = x2[2], y = y2[2]), color = 'black', shape = 0, size = 6, stroke = 1)+
  geom_point(data = d2, aes(x = x2[3], y = y2[3]), color = 'darkorchid2', shape = 17, size = 6)+
  geom_point(data = d2, aes(x = x2[3], y = y2[3]), color = 'black', shape = 2, size = 6, , stroke = 1)+
  ylab("Gentime (years)")+
  xlab("body mass (kg)")+
  scale_y_continuous(breaks=c(0, 720, 1440, 2160, 2880, 3600, 4320, 5040, 5760, 6480, 7200, 7920, 8640,9360), 
                     labels = c(0, 2,4,6,8,10,12,14,16,18,20,22,24,26))+
  scale_x_continuous(breaks=c(0, 10000, 20000, 30000, 40000, 50000, 60000,
                              70000, 80000, 90000, 100000),
                     labels = c(0,10,20,30,40,50,60,70,80,90,100))+
  expand_limits(x=0, y=0)+
  theme_bw()+
  theme(axis.text = element_text(angle = 0, hjust = 1, size = rel(1.5)),
        axis.title=element_text(size=18), legend.text=element_text(size=14), legend.title = element_text(size = 14),
        plot.title = element_text(size=18))

plot_GL_BM

#################################################################################

# Population Density vs Body Mass
# Data from Damuth, John. "Interspecific allometry of population density in mammals and other animals: the independence of body mass and population energy-use." Biological Journal of the Linnean Society 31.3 (1987): 193-246.

PDdata = read_excel("damuth1987.xlsx")

PDdata$type = as.factor(PDdata$type)
levels(PDdata$type)[levels(PDdata$type)=="Primates"] <- "primates"

a = PDdata

a %>%
  ggplot(aes(x = (mass_g), y = density))+
  ggtitle('Damuth 1987_all points')+
  geom_point()+
  ylab("density (ind/km^2)")+
  xlab("mass_g")+
  stat_smooth(method="lm")+
  scale_x_continuous(trans = 'log10') +
  scale_y_continuous(trans = 'log10')



################################################################################

# Dispersal Distance and Body Mass
# Data from Santini, Luca, et al. "Ecological correlates of dispersal distance in terrestrial mammals." Hystrix: The Italian Journal of Mammalogy 24.2 (2013).

DD_data =read.csv("DD_BM_2013_santini.csv")

# taking dispersal distances for species with body masses > 100 gm
DD_data = DD_data %>%
  filter(!is.na(DD_data$BM_g) & !is.na(DD_data$Mean_m) & !is.na(DD_data$Mean_f) & DD_data$BM_g > 100)

## FINDING THE ALLOMETRIC RELATIONSHIP BETWEEN DISPERSAL DISTANCE AND BODY MASS.

# plotting log10 - log10 scale
#using only male values because females are nearly equal to males

df = DD_data %>%
  select(Family, Species, Mean_m, Mean_f, BM_g) %>%
  filter(pmax(Mean_m, Mean_f)/pmin(Mean_m, Mean_f) < 1.2) %>%
  mutate(ratio = pmax(Mean_m, Mean_f)/pmin(Mean_m, Mean_f))


ggplot(df, aes(x = BM_g, y = Mean_m))+
  geom_point(size = 0.5)+
  scale_x_continuous(trans = 'log10')+
  scale_y_continuous(trans = 'log10')+
  ylab("log10(Mean Dispersal distance in km)")+
  xlab("log10(body mass in grams)")+
  theme_bw()+
  stat_smooth(method="lm")


model = lm(log(df$Mean_m) ~ log(df$BM_g))
intercept = model$coefficients[1]
slope = model$coefficients[2]
model



x = c(10.81, 6.09, 76.34, 38.65, 20.65)*1000  #body mass in grams
y = ((x)^(0.5588))*0.0454
d = data.frame(x,y)

x1 = c(330, 330, 130, 130, 52, 52)*1000   # body masses for different densities from allometry reported in Damuth 1981.
y1 = c(19, 32, 19, 32, 19, 32)            # Dispersal distance 
d1 = data.frame(x1, y1)



#plotting BM vs DD for species that have 
ggplot(BM_DD, aes(x = BM_g, y = Mean_m, color = "Data points from Santini et al. 2013"))+
  geom_point()+
  geom_point(data = d, aes(x = x, y = y,  color = "DD with allometry"), shape = 4, size = 3)+ 
  geom_point(data = d1, aes(x = x1, y = y1, color = 'Arenas et al., 2012 data points \n assuming deme edge of 100 km'), shape = 9, size = 3 )+
  annotate("text", x=52000, y=36, label="K = 200")+
  annotate("text", x=130000, y=36, label="K = 100")+
  annotate("text", x=330000, y=36, label="K = 50")+
  ylab("Mean dispersal distance (km)")+
  scale_x_continuous(breaks=seq(0,350000, 20000),
                     labels = seq(0, 350, 20))+
  scale_color_manual(name = "", values = c("DD with allometry" = "blue",
                                                  "Data points from Santini et al. 2013" = "black",
                                                  'Arenas et al., 2012 data points \n assuming deme edge of 100 km' = "red"))+
  xlab("Body mass (kgs)")+
  theme_bw()+
  theme(axis.text = element_text(angle = 0, hjust = 1, size = rel(1.5)),
        axis.title=element_text(size=18), legend.text=element_text(size=14), legend.title = element_text(size = 14),
        plot.title = element_text(size=18))


## TABLE S1: PARAMETER VALUES INCORPORATING ALLOMETRIC RELATIONSHIPS
# https://docs.google.com/spreadsheets/d/15SqI2fKsLleEF_3NOnDP-2qcICGkmpysrS915yHkM30/edit?usp=sharing

