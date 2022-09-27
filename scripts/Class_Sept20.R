#Functions - definition, body and return value

calc_vol <- function(len = 1, width = 1, height = 1){
  volume <- len * width * height
  return(volume)
}

calc_vol(45, 23, 45)

#local scope is where the variables used in the function exists, it doesn't get saved to the Global Environment to save memory 

ggsave 
#needs the file name, plot variable (optional or else it uses the latest plot), 

calc_mass_index <- function(weight =1, kg = FALSE, foot_length =1){
  if (kg == FALSE){
    weight <- weight*.454
  }
  mass_index <- weight/foot_length
  return(mass_index)
}

calc_mass_index <- function(weight =1, foot_length =1){
  mass_index <- (weight*.454)/foot_length
  return(mass_index)
}


calc_density <- function(mass = NA, unit_m = c("kg", "lbs"), volume = NA, unit_v = c("cm3, m3, in3, mm3")){
  if (unit_m == "lbs"){
    mass <- mass*0.454
  }
  if (unit_v == "cm3"){
    volume <- volume/1000000
  } else if (unit_v == "in3"){
      volume <- volume/61020
  } else if (unit_V == "mm3"){
      volume <- volume/1000000000
    }
  density <- mass/volume
  return(density)
}


calc_mass <- function(vol){
  mass <- 2.65 * vol^0.9
  return(mass)
}


cal_den <- function(len =1, widt=1, height=1){
  vol <- calc_vol(len, widt, height)
  mass <- calc_mass(vol)
  density <- mass/vol
  return(density)
}
