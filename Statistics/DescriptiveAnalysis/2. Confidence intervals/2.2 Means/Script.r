library(moments)

O3 <- c(33.95372381, 33.49052381, 33.95349524, 34.10675873, 34.05137825,
        34.04715095, 34.02463094, 34.06629979, 34.05040444, 34.04570474,
        34.04579229, 34.05567988, 32.89337)
NO2 <- c(4.80486667, 4.86587302, 4.77093651, 4.85249175, 4.84526222,
        4.8214419 , 4.84047825, 4.83565975, 4.83476022, 4.83904357,
        4.83619301, 4.83699085, 3.58526)
NO <- c(0.84972698, 0.85766349, 0.8156381 , 0.84724857, 0.85850667,
        0.81304762, 0.84328152, 0.8364407 , 0.83735025, 0.83751867,
        0.84000759, 0.83769175, 0.30561)
CO <- c(0.33206349, 0.33031429, 0.33089206, 0.33120476, 0.33205079,
        0.33171079, 0.33110156, 0.33110267, 0.33105756, 0.3311495 ,
        0.33110144, 0.33096524, 0.26518)
PM10 <- c(24.54711111, 24.61392063, 24.78251429, 24.58076413, 24.39960286,
        24.51986032, 24.5301686 , 24.54368695, 24.5467974 , 24.53645071,
        24.52238799, 24.52657762, 17.55617)
PM2_5 <- c(17.28567619, 17.67840952, 17.71896508, 17.57001778, 17.52792317,
        17.51177111, 17.5853861 , 17.58828879, 17.58254968, 17.57853323,
        17.57928312, 17.57872909, 14.90175)
Temp_Avg <- c(18.3393546 , 18.19324317, 18.29738286, 18.29209959, 18.28127356,
        18.25598302, 18.28993467, 18.29728673, 18.29588122, 18.29642439,
        18.29455963, 18.29424163, 16.0269)
RH_Avg <- c(60.77113968, 61.11344127, 60.92345397, 60.81274848, 60.78249124,
        60.9675319 , 60.81330887, 60.78699846, 60.78920405, 60.79757757,
        60.80104288, 60.79508987, 87.03095)
WSpeed_Avg <- c(1.56010889, 1.53279587, 1.55049937, 1.54361114, 1.54715546,
        1.54685613, 1.54737667, 1.55005939, 1.54941415, 1.54857646,
        1.54871868, 1.54821131, 2.376192)
WDir_Avg <- c(144.48093683, 140.99351365, 144.02127587, 144.77962137,
        144.90469943, 145.1362021 , 144.56240364, 144.54697282,
        144.54958425, 144.54364312, 144.60201731, 144.61763097,
        162.528878)
Rain_Tot <- c(0.00114286, 0.00114286, 0.00092063, 0.00094921, 0.00115238,
        0.00100635, 0.00102349, 0.00100095, 0.00103905, 0.00099638,
        0.00100533, 0.00100927, 0.1754)
Press_Avg <- c(805.82034984, 805.84739238, 805.82305238, 805.82673006,
        805.83350917, 805.84282238, 805.82852366, 805.82704437,
        805.82722278, 805.82829833, 805.82766581, 805.82858034,
        806.438254)
Rad_Avg <- c(448.51391514, 472.04664676, 461.26289502, 472.43953678,
        471.65763498, 471.51242878, 470.20113399, 470.93134852,
        470.69878028, 470.89952182, 470.27230128, 471.06085766,
         50.66536364)

shapiro.test(O3)
ks.test(O3, "pnorm", mean(O3), sd(O3))
# p-value < 0.05 -> No normality

shapiro.test(NO2)
ks.test(NO2, "pnorm", mean(NO2), sd(NO2))
# p-value < 0.05 -> No normality

shapiro.test(NO)
ks.test(NO, "pnorm", mean(NO), sd(NO))
# p-value < 0.05 -> No normality

shapiro.test(CO)
ks.test(CO, "pnorm", mean(CO), sd(CO))
# p-value < 0.05 -> No normality

shapiro.test(PM10)
ks.test(PM10, "pnorm", mean(PM10), sd(PM10))
# p-value < 0.05 -> No normality

shapiro.test(PM2_5)
ks.test(PM2_5, "pnorm", mean(PM2_5), sd(PM2_5))
# p-value < 0.05 -> No normality

shapiro.test(Temp_Avg)
ks.test(Temp_Avg, "pnorm", mean(Temp_Avg), sd(Temp_Avg))
# p-value < 0.05 -> No normality

shapiro.test(RH_Avg)
ks.test(RH_Avg, "pnorm", mean(RH_Avg), sd(RH_Avg))
# p-value < 0.05 -> No normality

shapiro.test(WSpeed_Avg)
ks.test(WSpeed_Avg, "pnorm", mean(WSpeed_Avg), sd(WSpeed_Avg))
# p-value < 0.05 -> No normality

shapiro.test(WDir_Avg)
ks.test(WDir_Avg, "pnorm", mean(WDir_Avg), sd(WDir_Avg))
# p-value < 0.05 -> No normality

shapiro.test(Rain_Tot)
ks.test(Rain_Tot, "pnorm", mean(Rain_Tot), sd(Rain_Tot))
# p-value < 0.05 -> No normality

shapiro.test(Press_Avg)
ks.test(Press_Avg, "pnorm", mean(Press_Avg), sd(Press_Avg))
# p-value < 0.05 -> No normality

shapiro.test(Rad_Avg)
ks.test(Rad_Avg, "pnorm", mean(Rad_Avg), sd(Rad_Avg))
# p-value < 0.05 -> No normality

# The distributions could be normal if the number of sample means would be higher