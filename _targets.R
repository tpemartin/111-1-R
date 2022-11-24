library(targets)
library(econDV2)
source("R/support.R")
tar_option_set(packages = c("readr", "dplyr", "ggplot2", "econDV2"))

list(
  # fun3(realGDPPPPperCapita,getRealGDPPPPperCapita()),
  realGDPPPPperCapita %t=% getRealGDPPPPperCapita(),
  # tar_target(
  #   realGDPPPPperCapita, getRealGDPPPPperCapita()
  # ),
  tar_target(
    top30realGDPPPPperCapita, getRealGDPPPPperCapita()
  ),
  tar_target(nominalGDPUSDmillions, getNominalGDPUSDmillions(realGDPPPPperCapita)),
  tar_target(top30countryCodes, selectedCountries()),
  tar_target(mergedTop30,getMergedDataForTop30Intersect(top30realGDPPPPperCapita, nominalGDPUSDmillions, top30countryCodes)),
  tar_target(df4plot, prepareDfForPlot(mergedTop30, top30countryCodes)),
  tar_target(file, "economicGrowth.Rds", format = "file"),
  tar_target(soybeanfile,"PSOYBUSDM.csv", format = "file"),
  tar_target(foodCommodityFile, "./PCPS_11-03-2022 13-29-30-05_timeSeries.csv", format="file"),
  tar_target(cpiFile, "./PR0101A1Mc.csv", format='file'),
  tar_target(commodityPrices, getCommodityPriceIndex(foodCommodityFile)),
  tar_target(soyBeanData, getSoybeanData(soybeanfile)),
  tar_target(economicGrowth, readRDS(file)),
  tar_target(economicGrowthAndGDPPPPpercapita, prepareDfForPlot2(economicGrowth)),
  tar_target(scwData, getCornSoybeanWheatData(commodityPrices)),
  tar_target(scwDataReBase, 
             changeBaseTime_scwData(scwData)),
  tar_target(
    scwPlotLabelDF, getLabelDFforCommodityPrice(scwDataReBase)
  ),
  tar_target(
    cpiDataQuarterly, getCPIdataQuarterly(cpiFile)
  ),
  meanQuarterlyInflationRate %t=%
    summariseMeanQuarterlyInflationRate(cpiDataQuarterly),
  tar_target(
    cpiData, getCPIdata(cpiDataQuarterly)
  ),
  tar_target(
    cpiDataReBase, changeBaseTime_cpiData(cpiData)
  ),
  gdpGrowthAndLevel %t=% getgdpGrowthAndLevel(),

# plots -------------------------------------------------------------------
tar_target(plt, plotCompareGDPAcrossCountries(df4plot)),
tar_target(pltEconomicGrowth, plotAsiaPacificEconomicGrowth(economicGrowthAndGDPPPPpercapita)),
tar_target(
  pltSCWCpi, plotSCWCpi(scwDataReBase, scwPlotLabelDF, cpiDataReBase),
  pltTaiwanGrowthAndLevel %t=% getPlotTaiwanGrowthAndLevel(gdpGrowthAndLevel)
)

  
)

