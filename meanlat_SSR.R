# univariate SSR for mean latitude of CalCOFI larval distribution (1951-2002)
# Crystal Tu 2015/07/13
library(rEDM)
library(dplyr)
setwd('work/Fishery/calcofi')
meanlat = read.csv(file = "coastal_meanlat.csv",header = TRUE)

# normalization scale
meanlat_scale=scale(meanlat[,2:30])
# 1st difference lag1
meanlat_lag1=meanlat_scale[2:52,]-meanlat_scale[1:51,]

index=c(1:NROW(meanlat_lag1))
outE=numeric(0);
out_rho=numeric(0);
out_theta=numeric(0);

for (N in 1:29) {
  time_series = data.frame(index,meanlat_lag1[,N]) 
  # simplex
  simplex_out = simplex(time_series, lib = c(1,25), pred = c(26,51), norm_type = c("L2 norm","L1 norm"), E=1:10,tau = 1, tp = 1, num_neighbors = "e+1", stats_only = TRUE, exclusion_radius = NULL,epsilon = 100000, silent = FALSE)
  outE[N]=simplex_out$E[simplex_out$mae==min(simplex_out$mae)]
  # Smap
  if (is.numeric(outE[N])==1) {
    smap_out = s_map(time_series, lib = c(1,25), pred = c(26,51),norm_type = c("L2 norm", "L1 norm"), E = outE[N],
                    tau = 1, tp = 1, num_neighbors = 0, theta = c(0, 1e-04, 3e-04, 0.001,0.003, 0.01, 0.03, 0.1, 0.3, 0.5, 0.75, 1, 1.5, 2, 3, 4, 6, 8),
                    stats_only = TRUE, exclusion_radius = NULL, epsilon = NULL,
                    silent = FALSE, save_smap_coefficients = FALSE)
    out_rho[N] = max(smap_out$rho)
    out_theta[N] = smap_out$theta[smap_out$rho==max(smap_out$rho)]
  } else{
    out_rho[N] = NA
    out_theta[N] = NA
  }  
}
output=data.frame(outE,out_rho,out_theta)
write.table(output,file="meanlat_SSR.csv",col.names=TRUE)
