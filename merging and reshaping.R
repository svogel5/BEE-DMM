# Set the working directory to where your path abundance files are located
setwd("~/Library/CloudStorage/Dropbox/BASELab/DMMProject/Data/Microbiomedata/18 month/sequencing/NON-HOST/HUMANN/All_paths/filtered")

library(dplyr)
library(readr)
library(tidyr)
library(reshape2)
file_list <- list.files(pattern = "*.csv")

# Read and merge files
merged_data <- lapply(file_list, function(file) {
  # Extract sequencing ID from the filename
  sequencing_id <- gsub("_L001_pathabundance.tsv_pathways_data.csv", "", file)
  
  # Read the file
  data <- read.csv(file, header = T, stringsAsFactors = FALSE)
  
  # Add sequencing ID as a column
  data$Sequencing_ID <- sequencing_id
  
  return(data)
}) %>%
  bind_rows()

head(merged_data)

sequencing_ids <- unique(merged_data$Sequencing_ID)
paths <- unique(merged_data$pathway)
str(merged_data$abundance)

# Load the reshape2 package
#transposed_data <- data.frame(clade_name = merged_data$clade_name, stringsAsFactors = FALSE)
transposed_data <- dcast(merged_data, pathway ~ Sequencing_ID, value.var = "abundance", fun.aggregate = sum, fill = 0)

write.csv(transposed_data, "path_abundances_18mo.csv")
write_tsv(transposed_data, "path_abundances_18mo.tsv")
