### analysis of containment prob vs growth and intensity
### https://github.com/thompsdk/Fire-Contain-Prob-Viz
### Dan Thompson, Canadian Forest Service, 2021

### fist, produce either isolines or geom_tile of containment probability
library(reshape2)
library(ggplot2)
library(cffdrs) ## for later calculating FBP types from first principles
library(metR)
library(rlang)


### set reasonable limits to the plot, in this case, 20,000 kW/m and area of 0.1 to 25 hectares
HFI <- seq(from = 0, to = 20000,by = 100) ### 100 kW/m steps for the HFI axis
Area <- seq(from = 0, to = 25, by = 0.1) ## 0.1 ha steps for the area axis


Contain <- array(0,c(200,250)) #HFI (i),area(j)

## write out as 2-D array

for (i in 1:200)
  for (j in 1:250)
{{
  #Contain[i,j] <- exp(4.6389-0.3968*(Area[j])-0.00034*(HFI[i])-0.000085*((Area[j])*HFI[i]))/(1+exp(4.6389-0.3968*(Area[j])-0.00034*(HFI[i])-0.000085*((Area[j])*HFI[i])))
  Contain[i,j] <- exp(4.6835-0.7043*(Area[j])-0.00041*(HFI[i])-0.000052*((Area[j])*HFI[i]))/(1+exp(4.6835-0.7043*(Area[j])-0.00041*(HFI[i])-0.000052*((Area[j])*HFI[i])))
}}

## then melt to make into long array
Contain2 <- melt(Contain)

## add column names
col_headings <- c('HFI','Area','Prob')
names(Contain2) <- col_headings
### adjust integers to actual values
Contain2$HFI <- Contain2$HFI*100
Contain2$Area <- Contain2$Area/10

Prob90 <- subset(Contain2,Prob < 0.92 & Prob > 0.88)
Prob80 <- subset(Contain2,Prob < 0.82 & Prob > 0.78)
Prob70 <- subset(Contain2,Prob < 0.72 & Prob > 0.68)
Prob60 <- subset(Contain2,Prob < 0.62 & Prob > 0.58)
Prob50 <- subset(Contain2,Prob < 0.52 & Prob > 0.48)

###load the fire behaviour data time series, with the essential columns:
### "time" in minutes after ignition
### "HFI" calculated Byram's Head Fire Intensity at timestep (kW/m)
### "Area" modelled fire area at time (ha)
### "scen" weather (fuel moisture) scenario of choice (string category/factor)
### "WS" wind speed scenario (string category/factor, not used to compute HFI or area directly here)

### other fields necessary to calculate HFI (in needed)
### the cffdrs R package can perform all of these calculations: https://cran.r-project.org/web/packages/cffdrs/index.html
### "TFC" is the total fuel consumption based on the definition Canadian FBP System (surface+crown fuel in flaming phase)
### "ROS" forward rate of spread (m/min)


## the attached "Fire-Contain-Prob-Viz.ods" can be used as an interactive calculator to compute the above
## using the Canadian FBP mode, but any fire behaviour model can be used.

### import the data (all fuel types at once)
MatrixContain <- read.csv("~/Fire-Contain-Prob-Viz/Fire-Contain-Prob-Viz.csv")
MatrixContain$fuel <- as.factor(MatrixContain$fuel)
#above data from Marshall et al 2020, doi: 10.3390/fire3020018

#levels(MatrixContain$fuel)

### pick one fuel type for now
fueltype <- c("MW")


MatrixContain$WS <- as.factor(MatrixContain$WS)

g <- ggplot(Contain2,aes(HFI, Area)) + geom_raster(aes(fill=Prob)) + scale_y_continuous(limits=c(0,2),expand=c(0,0)) + scale_x_continuous(limits=c(0,15000),expand=c(0,0)) + stat_contour(aes(z = Prob),breaks=c(0.9,0.75,0.5,0.25),colour = "grey50",size = 1.0,show.legend = FALSE) + geom_path(data=MatrixContain, aes(x = HFI, y = Area, group=scen, linetype = rx, color = as.factor(WS)))  + geom_point(data=subset(MatrixContain,time==6), aes(x = HFI, y = Area, group=scen, linetype = rx, color = as.factor(WS)))# + scale_linetype_manual(values = c("solid", "dashed", "dotted")) #+ scale_fill_gradientn(colours=c("#FF0000FF","#FFFFFFFF","#0000FFFF"))
g

###ideally, increase the line width at 5 min intervals
