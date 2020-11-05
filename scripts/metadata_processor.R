library(dplyr)
library(readxl)
library(stringr)

# read in raw metadata
md_raw <- read_xlsx("../data/All_conseqs_2020-10-10_metadata.xlsx")

# rename columns to suit augur commands for phylogenetic tree creation
md_renamed <- rename(md_raw, date = collection_date, strain = samplabel)

# Further processing and creation of data columns to suit augur commands
md_filtered <- md_renamed %>%
  filter(substr(gisaid_full_name, 1, 7) == "hCoV-19") %>%
  mutate(country = substr(gisaid_full_name, 9, 11)) %>%
  mutate(virus = "Severe acute respiratory syndrome coronavirus 2")

# changed to CSV file
write.csv(md_filtered, file = "../data/mod_conseqs_2020-10-10_metadata.csv", row.names = F)
