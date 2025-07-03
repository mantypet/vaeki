# Gangfit PHYSICAL STANDARDS
# 
# Strength, Speed, Aerobic Fitness & Body Fat.
# 
# Deadlift: 1-rep max of 2 x bodyweigth (general strength) = 180 kg @ 90 kg bodyweight = 5 x 160
# Chin-ups: 20 (usable upperbody strength)
# 100m sprint: Under 13 secs (speed)
# One mile: Under 6 minutes (endurance)
# Body-fat: 10-12% (health)

# Mitch Hooper's standards 1RM
# https://youtu.be/JAqZk-CdcBU?feature=shared
# Squat 285 lbs (130 kg)
# Bench 217 lbs (100 kg)
# Deadlift 335 lbs (150 kg)

# Starting strength
# 1RM
# 1.75x bodyweight squat = 157.5 kg = 5 x 140 kg
# 2x bodyweight deadlift = 180 kg = 5 x 160
# 0.75x bodyweight press = 67.5 kg = 5 x 60 kg
# Note: https://startingstrength.com/training/strength-standards-and-their-usefulness

# Strengthlevel.com 5 reps to 1RM ratio 0.888

# https://marathonhandbook.com/average-400-meter-time/
# https://marathonhandbook.com/whats-a-good-mile-time/

# Omat
#
# Voima
# Kyykky 3 x 5 x 1.75 x kehonpaino = 3 x 5 x 157.5 kg
# Penkki 3 x 5 x kehonpaino = 3 x 5 x 90 kg
# Pystypunnerus 3 x 5 x 0.75 x kehonpaino =~ 3 x 5 x 67.5 kg
# Maastaveto 1 x 5 x 2 x kehonpaino = 1 x 5 x 180 kg
#
# Nopeus & kestävyys
# 400 m 1:20
# Maili 6:00
# LKT-tavoitteet (34-39 v)
# Vauhditon pituus 2,40 m
# Istumaannousu 44 / 1 min
# Etunojapunnerrus 42 / 1 min
# Cooper 3000 m

library(devtools)
# devtools::install_github("ricardo-bion/ggradar")
library(ggradar)

run400 <- lubridate::ms(c("1:50","1:38","1:20","1:08","0:53","0:48"))	
run1600 <- lubridate::ms(c("8:30","7:35","6:10","5:15","4:05","3:57"))
runcooper <- c(2400,2600,2900,3100,3700,4768)
squat <- c(0.75,1.25,1.50,2.25,2.75)
press <- c(0.35,0.55,0.80,1.10,1.40)
bench <- c(0.50,0.75,1.25,1.75,2.00)
deadlift <- c(1.00,1.50,2.00,2.50,3.00)
pullup <- c(1,5,14,25,37)






