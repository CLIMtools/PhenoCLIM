require(shiny)
require(shinydashboard)
require(shinyjs)
require(leaflet)
require(ggvis)
library(plyr)
require(dplyr)
library(RColorBrewer)
require(raster)
require(gstat)
require(rgdal)
require(Cairo)
library(sp)
library(htmltools)


FULL.val <-read.csv("data/phenoclim.csv")
class(FULL.val)  
na.omit(FULL.val)
# a data.frame


colnames(FULL.val) <-c("lng"="lng", "lat"="lat", "id"="id","name"="name",	"country"="country", "CS_number"="CS_number", "group"="group","CO_Spring" = "CO Spring (ppbv)" ,"CO_Summer"= "CO Summer (ppbv)", "NO2_Spring"= "NO2 Spring (billion molecules/mm2)",	"NO2_Summer"= "NO2 Summer (billion molecules/mm2)",	"O3_Spring"="O3 Spring (Dobson Units)",	"O3_Summer"= "O3 Summer (Dobson Units)",
                                              "SIB3_carbon_flux_spring"="SIB3 carbon flux spring (mol/m2/seg)",	"SIB3_carbon_flux_summer"="SIB3 carbon flux summer (mol/m2/seg)",	"UV_index_spring"="UV index spring",	"UV_index_summer"="UV index summer",	"Solar_insolation_spring"= "Solar insolation spring (W/m2)",	"Solar_insolation_summer"= "Solar insolation summer (W/m2)",	"Net_radiation_spring" ="Net radiation spring (W/m2)",	"Net_radiation_summer"="Net radiation summer (W/m2)",	"WATER_EQUIVALENT_ANOMALY_spring" = "Water eq. anomaly spring (cm)",	"WATER_EQUIVALENT_ANOMALY_summer"= "Water eq. anomaly summer (cm)",	"Rainfall_spring"= "Rainfall spring (mm)",	"Rainfall_summer"= "Rainfall summer (mm)",	"Precipitable_water_spring"= "Precipitable water spring (cm)",	"Precipitable_water_summer"= "Precipitable water summer (cm)",	"LTemp_day_spring"="LTemp day spring (°C)",	"LTemp_day_summer"="LTemp day summer (°C)",	"Ltemp__night_spring"="LTemp night spring (°C)",	"Ltemp__night_summer"="LTemp night summer (°C)", 
                                              "NDVI_Spring"="NDVI Spring",	"NDVI_Summer"="NDVI Summer",	"LAI_Spring"="LAI Spring (m2/m2)",	"LAI_Summer"="LAI Summer (m2/m2)",	"PET" ="PET (mm/yr)",	"ET"="ET (mm/yr)",	"LE"="LE (W/m2)",	"Aridity_index"="Aridity index",	"Climatic_water_deficit"="Climatic water deficit (mm/yr)",	"Number_of_dry_months"="Number of dry months (days)",	"GPP_Spring"="GPP Spring (gC/m2/day)",	"GPP_Summer"="GPP Summer (gC/m2/day)",	"NPP_Spring"="NPP Spring (gC/m2/day)",	"NPP_Summer"="NPP Summer (gC/m2/day)",	"Topography"="USGS:GTOPO30 Topography (m)",	"SRTM elevation"= "NASA: SRTM elevation (m)",	"SMT_Spring"="AVHRR Smoothed Brightness Temperature summer",	"SMT_Summer"="AVHRR Smoothed Brightness Temperature spring",	"SMN_Spring"="AVHRR Smoothed NDVI spring",	"SMN_Summer"="AVHRR Smoothed NDVI summer",	"TCI_Spring"="AVHRR Temperature Condition Index spring",	"TCI_Summer"="AVHRR Temperature Condition Index summer",	"VCI_Spring"="AVHRR Vegetation Condition Index spring",	"VCI_Summer"="AVHRR Vegetation Condition Index summer",	"VHI_Spring"="AVHRR Vegetation Health Index spring",	"VHI_Summer"="AVHRR Vegetation Health Index summer",	"CO2_Emissions"= "ISLSCP II CO2 EMISSIONS (C/cm2/sec)",	"WB_PVOUT"= "WB PVOUT (kWh/kWp)",	"WB_GHI"= "WB GHI (kWh/m2)",	"WB_DIF"= "WB DIF (kWh/m2)",	"WB_GTI"=	"WB GTI (kWh/m2)",	"WB_OPTA"= "WB OPTA (degrees)",	"WB_DNI"="WB DNI (kWh/m2)",	"WB_TEMP"= "WB TEMP (°C)",	"WC_ELE"="WB ELE (m)",	"GPCC_Spring"="GPCC Spring (mm)",	"GPCC_Summer"="GPCC Summer (mm)",
                                              "WC2_Tmin_spring"="WC2 Tmin spring (°C)",	"WC2_Tmin_summer"="WC2 Tmin summer (°C)",	"WC2_Tmax_spring"="WC2 Tmax spring (°C)",	"WC2_Tmax_summer"="WC2 Tmax summer (°C)",	"WC2_Pre_spring"="WC2 Pre spring (mm)",	"WC2_Pre_summer"="WC2 Pre summer (mm)",	"WC2_Solar_radiation_spring"="WC2 Solar radiation spring (kJ m-2 day-1)",	"WC2_Solar_radiation_summer"="WC2 Solar radiation summer (kJ m-2 day-1)",	"WC2_Average_temperature_spring"="WC2 Average temperature spring (°C)",	"WC2_Average_temperature_summer"="WC2 Average temperature summer (°C)",	"WC2_Water_vapor_pressure_spring"="WC2 Water vapor pressure spring (kPa)",	"WC2_Water_vapor_pressure_summer"="WC2 Water vapor pressure summer (kPa)",	"WC2_BIO1"= "WC BIO1 (°C)",	"WC2_BIO2"="WC2_BIO2 (°C)",	"WC2_BIO3"="WC2_BIO3 (°C)",	"WC2_BIO4"="WC2 BIO4 (°C)",	"WC2_BIO5"="WC2 BIO5 (°C)",	"WC2_BIO6"="WC2 BIO6 (°C)",	"WC2_BIO7"="WC2 BIO7 (°C)",	"WC2_BIO8"="WC2 BIO8 (°C)",	"WC2_BIO9"="WC2 BIO9 (°C)",	"WC2_BIO10"="WC2 BIO10 (°C)",	"WC2_BIO11"="WC2 BIO11 (°C)",	"WC2_BIO12"="WC2 BIO12 (mm)",	"WC2_BIO13"="WC2 BIO13 (mm)",	"WC2_BIO14"="WC2 BIO14 (mm)",	"WC2_BIO15"="WC2 BIO15 (mm)",	"WC2_BIO16"= "WC2 BIO16 (mm)",	"WC2_BIO17"= "WC2 BIO17 (mm)",	"WC2_BIO18"="WC2 BIO18 (mm)",	"WC2_BIO19"="WC2 BIO19 (mm)",
                                              "CHELSA_Tmin_Spring"="CHELSA Tmin Spring (°C)",	"CHELSA_Tmin_spring"="CHELSA Tmin spring (°C)",	"CHELSA_Tmax_spring"="CHELSA Tmax spring (°C)",	"CHELSA_Tmax_summer"="CHELSA Tmax summer (°C)",	"CHELSA_Tmean_spring"="CHELSA Tmean spring (°C)",	"CHELSA_Tmean_summer"="CHELSA Tmean summer (°C)",	"CHELSA_Interann_Temp"="CHELSA Interann_Temp (°C)",	"CHELSA_Pre_spring"="CHELSA Pre spring (mm)",	"CHELSA_Pre_summer"="CHELSA Pre summer (mm)",	"CHELSA_Interann_pre"="CHELSA Interann pre (mm)",	"CHELSA_BIO1"="CHELSA BIO1 (°C) ",	"CHELSA_BIO2"="CHELSA BIO2 (°C)",	"CHELSA_BIO3"= "CHELSA BIO3 (°C)",	"CHELSA_BIO4"="CHELSA BIO4 (°C)",	"CHELSA_BIO5"="CHELSA BIO5 (°C)",	"CHELSA_BIO6"="CHELSA BIO6 (°C)", "CHELSA_BIO7"="CHELSA BIO7 (°C)",	"CHELSA_BIO8"="CHELSA BIO8 (°C)",	"CHELSA_BIO9"="CHELSA BIO9 (°C)",	"CHELSA_BIO10"="CHELSA BIO10 (°C)",	"CHELSA_BIO11"="CHELSA BIO11 (°C)",	"CHELSA_BIO12"="CHELSA BIO12 (mm)",	"CHELSA_BIO13"="CHELSA BIO13 (mm)",	"CHELSA_BIO14"="CHELSA BIO14 (mm)",	"CHELSA_BIO15"="CHELSA BIO15 (mm)",	"CHELSA_BIO16"="CHELSA BIO16 (mm)",	"CHELSA_BIO17"="CHELSA BIO17 (mm)",	"CHELSA_BIO18"="CHELSA BIO18 (mm)",	"CHELSA_BIO19"="CHELSA BIO19 (mm)",
                                              "CRU_Cld_spring" ="CRU Cld spring (%)",	"CRU_Cld_summer"="CRU Cld summer (%)",	"CRU_Dtr_spring"="CRU Dtr spring (°C)",	"CRU_Dtr_summer"="CRU Dtr summer (°C)",	"CRU_Frs_spring"="CRU Frs spring (days)",	"CRU_Frs_summer"="CRU Frs summer (days)",	"CRU_Pre_spring"="CRU Pre spring (mm)",	"CRU_Pre_summer"="CRU Pre summer (mm)",	"CRU_Tmp_spring"="CRU Tmp spring (°C)",	"CRU_Tmp_summer"="CRU Tmp summer (°C)",	"CRU_Tmn_spring"="CRU Tmn spring (°C)",	"CRU_Tmn_summer"="CRU Tmn summer (°C)",	"CRU_Tmx_spring"="CRU Tmx spring (°C)",	"CRU_Tmx_summer"="CRU Tmx summer (°C)",	"CRU_Vap_spring"="CRU Vap spring (hPa)",	"CRUVap_summer"="CRUVap_summer (hPa)",	"CRU_Wet_spring"="CRU Wet spring (days)",	"CRU_Wet_summer"="CRU Wet summer (days)",	"CRU_PET_Spring"="CRU PET Spring (mm)",	"CRU_PET_Summer"="CRU PET Summer (mm)",	"Bedrock_topography"="Bedrock topography (meters)",
                                              "dNPPdP"="dNPPdP (g/m2/mm)",	"dNPPdT"="dNPPdT (g/m2/ºC)",	"CRU_NPP"="CRU NPP (g/m2)",	"NPP_based_on_GPCP"="NPP based on GPCP (g/m2)",	"NPP_based_on_GPCP_VASClimO"="NPP based on GPCP VASClimO  (g/m2)",	"GPCC_VASClimO_Precipitation"= "GPCC VASClimO Precipitation (mm)",	"CRU_Precipitation"="CRU Precipitation (mm)",	"CRU_Temperature"="CRU_Temperature (ºC)",	"Griesser_Precip_GPCC"="Griesser_Precip_GPCC (mm)",	"GPCC_Fulldata_Precipitation"="GPCC Fulldata Precipitation",	"Aridity_index_of_De_Martonne_GPCC_Fulldata"="Aridity index of De Martonne GPCC Fulldata",	"Aridity_index_of_De_Martonne_GPCC_VASClimO"="Aridity index of De Martonne GPCC VASClimO",	"Aridity_index_of_De_Martonne_CRU"="Aridity index of De Martonne CRU",	"HWSD_Topsoil_ref_bulk_dens"="HWSD Topsoil ref bulk dens (kg/dm3)",	"HWSD_Topsoil_clay_fraction"="HWSD Topsoil clay fraction (%)",	"HWSD_Topsoil_gravel_content"="HWSD Topsoil gravel content (%)",	"HWSD_Topsoil_silt_fraction"="HWSD Topsoil silt fraction (%)",	"HWSD_Topsoil_sand_fraction"="HWSD Topsoil sand fraction (%)",	"HWSD_Topsoil_organic_carbon"="HWSD Topsoil organic carbon (%)",	"HWSD_Topsoil_pH"="HWSD Topsoil pH (-log(H+))",	"HWSD_Subsoil_ref_bulk_dens"="HWSD Subsoil ref bulk dens (kg/dm3)",	"HWSD_Subsoil_clay_fraction"= "HWSD Subsoil clay fraction (%)",	"HWSD_Subsoil_gravel_content"="HWSD Subsoil gravel content (%)",	"HWSD_Subsoil_silt_fraction"="HWSD Subsoil silt fraction (%)",	"HWSD_Subsoil_sand_fraction"="HWSD Subsoil sand fraction (%)",	"HWSD_Subsoil_organic_carbon"="HWSD Subsoil organic carbon (%)",	"HWSD_Subsoil_pH"="HWSD Subsoil pH (-log(H+))",	"HWSD_Spatially_dominan_major_soil_group_FAO"= "HWSD Spatially dominan major soil group FAO",	"ISRIC_WISE_SoilCarbonate_Carbon_Dens"="ISRIC WISE SoilCarbonate Carbon Dens (kg C/m)",	"ISRIC_WISE_Soil_Org_Carbon_Dens"= "ISRIC WISE Soil Org Carbon Dens (kg C/m)",	"ISRIC_WISE_Soil_pH"="ISRIC WISE Soil pH (log(H+))",	"ISRIC_WISE_Total_AvailWater_cap"="ISRIC WISE Total AvailWater cap (mm)", 
                                              "SoilGrids_BDRICM"="SoilGrids absolute depth to bedrock (cm)",	"SoilGrids_BLDFIE"= "SoilGrids bulk density (kg/m3)",	"SoilGrids_CECSOL"="SoilGrids cation exchange capacity of soil (meq/100 g)",	"SoilGrids_CLYPPT"="SoilGrids clay content (%)",	"SoilGrids_CRFVOL"="SoilGrids course fragments volumetric (%)",	"SoilGrids_OCSTHA"="SoilGrids soil organic carbon stock per ha (kg/m3)",	"SoilGrids_ORCDRC"="SoilGrids soil organic carbon content (‰)",	"SoilGrids_PHIHOX"="SoilGrids soil pH H2O (log(H+))",	"SoilGrids_PHIKCL"="SoilGrids soil pH KCL (log(H+))",	"SoilGrids_SLTPPT"="SoilGrids silt content (%)",	"SoilGrids_SNDPPT"= "SoilGrids sand content (%)",	"SoilGrids_TAXNWRB"="SoilGrids observed taxonomic class (WRB system)",	"SoilGrids_TAXOUSDA"="SoilGrids observed taxonomic class(USDA system)",	"GAEZ_Nutrient_availability" ="GAEZ Nutrient availability",	"GAEZ_Nutrient_retention_capacity"="GAEZ Nutrient retention capacity",	"GAEZ_Rooting_conditions"="GAEZ Rooting conditions",	"GAEZ_Oxygen_availability_to_roots"="GAEZ Oxygen availability to roots",	"GAEZ_Excess_salts"="GAEZ Excess salts",	"GAEZ_Toxicity"="GAEZ Toxicity",	"Plant_Extractable_Water_Capacity_of_Soil"="Plant extractable water capacity of Soil (cm/cm)",	"IGBP_DIS_Soil_pH"="IGBP DIS Soil pH (-log(H+))",	"Suitability_for_Agriculture"="Suitability for Agriculture (index)",	"Growing_degree_days"="Growing degree (days)",	"Distance_to_the_coast"="Distance_to_the_coast (Km)",	"Bailey_ecoregions"="Bailey ecoregions",	"Land_cover_2000"="Land cover 2000",	"UMD_Land_cover_classification"="UMD Land cover classification",	"Distribution_of_Cultivation_Intensity"="Distribution of Cultivation Intensity",	"Koppen_Geiger"="Koppen Geiger",	"Geological_ages"= "Geological ages",	"Soil_types"="Soil types (Zobler)",
                                              
                      ##1001 genomes
                       "FT10_1001_Genomes"="Flowering time at 10 °C (days)",	"FT16_1001_Genomes"="Flowering time at 16 °C (days)",
                      ####Vasseur_et al PNAS2018
                      "Vasseur_et_al_Lifespan"= "Lifespan (days)",	"Vasseur_et_al_Fruit_number"="Fruit number",	"Vasseur_et_al_RGR"= "Relative growth rate (mg d-1 g-1)", 	"Vasseur_et_al_rosette_DM"="Rosette dry mass (mg)",	"Vasseur_et_al_Growt_rate"="Absolute growth rate (mg d-1)", 	"Vasseur_et_al_Scaling_Exponent"="Scaling exponent",
                     
                      ####Mejion et. al.  Nature Genetics 2014
                       "Mature_cell_length"="Mature cell length (µm)",	"Meristem_zone_length"= "Meristem zone length (µm)",
                      #####Satbhai et. al. Nature Communications 2017
                       "Root_length__Day_1"="Root length Day 1 (mm)",	"Root_length__Day_2"="Root length Day 2 (mm)",	"Root_length__Day_3"="Root length Day 3 (mm)",	"Root_length__Day_4"="Root length Day 4 (mm)",	"Root_length__Day_5"="Root length Day 5 (mm)",
                       
                      ###ionomics David Salt
                       "As75"="As75 (µg g-1 DW)", "Ca43"="Ca43 (µg g-1 DW)",	"Cd111"= "Cd111 (µg g-1 DW)",	"Cd114"= "Cd114 (µg g-1 DW)",	"Co59"= "Co59 (µg g-1 DW)",	"Cu65"="Cu65 (µg g-1 DW)",	"Fe56"="Fe56 (µg g-1 DW)",	"Fe57"= "Fe57 (µg g-1 DW)",		"K39"="K39 (µg g-1 DW)",	"Li7"="Li7 (µg g-1 DW)",		"Mg25"="Mg25 (µg g-1 DW)",	"Mn55"="Mn55 (µg g-1 DW)",	"Mo98"="Mo98 (µg g-1 DW)","Ni60"= "Ni60 (µg g-1 DW)", "Na23"="Na23 (µg g-1 DW)", "P31"="P31 (µg g-1 DW)","Rb85"="Rb85 (µg g-1 DW)",	"S34"="S34 (µg g-1 DW)","Se82"= "Se82 (µg g-1 DW) ","Zn66"= "Zn66 (µg g-1 DW)",
                       
                      ##Li et. al. PNAS 2010
                      "Area_sweden_2009__1st_experiment"="Area Sweden 2009 1st experiment (cm2)",	"Area_sweden_2009__2nd_experiment"="Area Sweden 2009 2nd experiment (cm2)",
                      "DTF_spain_2008__1st_experiment"="Flowering time Spain 2008 1st experiment (Days)", 	"DTF_spain_2008__2nd_experiment"="Flowering time Spain 2008 2nd experiment (Days)", "DTF_spain_2009__1st_experiment"="Flowering time Spain 2009 1st experiment (Days)", "DTF_spain_2009__2nd_experiment"="Flowering time Spain 2009 2nd experiment (Days)",
                      "DTF_sweden_2008__1st_experiment"="Flowering time Sweden 2008 1st experiment (Days)",	"DTF_sweden_2008__2nd_experiment"="Flowering time Sweden 2008 2nd experiment (Days)", "DTF_sweden_2009__1st_experiment"="Flowering time Sweden 2009 1st experiment (Days)", "DTF_sweden_2009__2nd_experiment"="Flowering time Sweden 2009 2nd experiment (Days)",
                      "Size_spain_2009__1st_experiment"="Size Spain 2009 1st experiment (cm)",	"Size_spain_2009__2nd_experiment"="Size Spain 2009 2nd experiment (cm)",
                      "Size_sweden_2009__1st_experiment"="Size Sweden 2009 1st experiment (cm)","Size_sweden_2009__2nd_experiment"="Size Sweden 2009 2nd experiment (cm)",
                      "Yield_spain_2009__1st_experiment"="Yield Spain 2009 1st experiment (g)", "Yield_spain_2009__2nd_experiment"="Yield Spain 2009 2nd experiment (g)",	
                      "Yield Sweden 2009 1st experiment (g)"= "Yield Sweden 2009 1st experiment (g)",	"Yield_sweden_2009__2nd_experiment"= "Yield sweden 2009 2nd experiment (g)",
                      "YieldPlantingSummer2009"="Yield Planting Summer 2009 (g)", 
                      "YieldLocSweden2009"="Yield Loc Sweden 2009 (g)",	"YieldMainEffect2009"="Yield Main Effect 2009 (g)",	
                      "YieldPlantingSummerLocSweden2009"= "Yield Planting Summer Loc Sweden 2009 (g)",	 	
                      
                       ####Strauch et. al. PNAS 2015
                       "M216T665",	"M130T666",	"M172T666",
                      
                  
                       
                       
                      ######Flowering
                       "LD"="Flowering time long days/no vernalization (days)","LDV"="Flowering time long days and vernalization (days)",	"SD"="Flowering time short days/no vernalization (days)", "SDV"="Flowering time long days and vernalization (days)",
                       "_0W"="Flowering time after 0 weeks of vernalization (days)",	"_2W"="Flowering time after 2 wks of vernalization (days)",	"_4W"="Flowering time after 4 wks of vernalization (days)",	"_8W"="Flowering time after 8 wks of vernalization (days)",
                       "FLC"="FLC gene expression levels", "FRI"="FRI gene expression levels",                   	
                       "FT10"="Flowering time at 10°C (days)", "FT16"="FT time at 16°C (days)","FT22"="Flowering time at 22°C (days)","LN10"="Leaf number at 10°C", "LN16"="Leaf number at 16°C", "LN22" ="Leaf number at 22°C",
                       "0W_GH_FT"= "FT, no vernalization (Greenhouse)", "8W_GH_FT"="FT, 8 wks vernalization (Greenhouse)", "_0W_GH_LN"="Leaf number, no vernalization (Greenhouse)", "8W_GH_LN"="Leaf number, 8 wks vernalization (Greenhouse)",  
                      
                      
                       "FT_Field"="Flowering time in the field (days)", "FT_Diameter_Field"="plant diameter in the field (cm)",	"FT_GH"="Flowering time in the greenhouse (days)",

                       #####Developmental
                       "FW"="Fresh Weight (g)", "DW"= "Dry Weight (g)",
                       "Seed_Dormancy"="Seed dormancy (days)", 
                       "Germ_10"="Germination at 10°C (days)","Germ_16"="Germination at 16°C (days)","Germ_22"="Germination at 22°C (days)",
                       "Seedling_Growth"="Seedling growth rate (cm2/day)","Vern_Growth"= "Vegetative growth rate during vernalization (%)", "After_Vern_Growth"="Vegetative growth rate after vernalization (%)", "Secondary_Dormancy"="Secondary dormancy (%)",	'Germ_in_dark'="Germination in the dark after cold exposure (%)","DSDS50"= "DSDS50 (days)","Storage_7_days"="Primary dormancy after 7 days of dry storage (%)","Storage_28_days"="Primary dormancy after 28 days of dry storage (%)", "Storage_56_days"="Primary dormancy after 56 days of dry storage (%)", "Hypocotyl_length"= "Hypocotyl length (cm)",
                       "Width_10"="Diameter at 10 °C (cm)","Width_22"="Diameter at 22 °C (cm)",
                       "Silique_16"="Silique lenght at 16°C (cm)","Silique_22"="Silique lenght at 22°C (cm)",
                       "FT_Duration_GH"="Flowering period (days)","LC_Duration_GH"= "Life cycle period (days)", "LFS_GH"="Last flower senescence (days)", "MT_GH"="Maturation (days)", "RP_GH"="Reproduction period (days)",
                      
                       
                       ##Resistance
                       "Trichome_avg_C"="Trichome density Control",	"Trichome_avg_JA"="Trichome density JA","Bacterial_titer"="Bacterial titers of P. syringae (CFUs)", "Aphid_number"="Aphid number",
                       "As2"="P. viridiflava strain As2 severity (CFU)","At1"="P. viridiflava strain At1 severity (CFU)",	"At2"="P. viridiflava strain At2 severity (CFU)","Bs"="P. viridiflava strain Bs severity (CFU)", 
                       "As_CFU2"="P. viridiflava strain As growth (CFU)", "As2_CFU2"="P. viridiflava strain As2 growth (CFU)","At1_CFU2"="P. viridiflava strain At1 growth (CFU)","Bs_CFU2"="P. viridiflava strain Bs growth (CFU)",
                       
                      
                       #Ionomics
                       "As75_Atwell_et_al"="As75 Atwell et. al. (µg g-1 DW)",	"B11_Atwell_et_al" ="B11 Atwell et. al. (µg g-1 DW)","Ca43_Atwell_et_al"="Ca43 Atwell et. al. (µg g-1 DW)","Co59_Atwell_et_al"="Co59 Atwell et. al. (µg g-1 DW)","Cu65_Atwell_et_al"="Cu65 Atwell et. al. (µg g-1 DW)", "K39_Atwell_et_al"= "K39 Atwell et. al. (µg g-1 DW)", "Li7_Atwell_et_al"="Li7 Atwell et. al. (µg g-1 DW)",	
                       "Mg25_Atwell_et_al"="Mg25 Atwell et. al. (µg g-1 DW)","Mn55_Atwell_et_al"="Mn55 Atwell et. al. (µg g-1 DW)","Mo98_Atwell_et_al"="Mo98 Atwell et. al. (µg g-1 DW)", "Na23_Atwell_et_al"="Na23 Atwell et. al. (µg g-1 DW)", "Ni60_Atwell_et_al"="Ni60 Atwell et. al. (µg g-1 DW)",	"P31_Atwell_et_al"="P31 Atwell et. al. (µg g-1 DW)",	"S34_Atwell_et_al"="S34 Atwell et. al. (µg g-1 DW)", "Se82_Atwell_et_al"="Se82 Atwell et. al. (µg g-1 DW)",	"Zn66_Atwell_et_al"="Zn66 Atwell et. al. (µg g-1 DW)"
                       
                       
                       
                       )
                       
                       # a data.frame
FULL <- SpatialPointsDataFrame(FULL.val[,c("lng", "lat")], FULL.val[,1:351])


                       #########
PHENOTYPES <-read.csv("data/PHENOTYPES.csv", fileEncoding = "latin1")

                     descriptiondataset <-read.csv("data/datadescription.csv")

datasets <- list(
  'FULL'=  FULL
  
)

baselayers <- list(
  'FULL'='Esri.WorldImagery'
)

