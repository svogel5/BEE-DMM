# Set the working directory to where your genus files are located
setwd("C:/Users/scvogel/Dropbox/BASELab/DMMProject/Data/Microbiomedata/2 week/sequencing/NON-HOST/HUMANN/All/genus")
setwd("/Users/sarahvogel/Library/CloudStorage/Dropbox/BASELab/DMMProject/Data/Microbiomedata/2 week/sequencing/NON-HOST/HUMANN/All/genus")
library(dplyr)
library(readr)
library(tidyr)
library(reshape2)
file_list <- list.files(pattern = "*.tsv")

# Read and merge files
merged_data <- lapply(file_list, function(file) {
  # Extract sequencing ID from the filename
  sequencing_id <- gsub("_L001_metaphlan.tsv_genus_data.csv", "", file)
  
  # Read the file
  data <- read.csv(file, header = FALSE, stringsAsFactors = FALSE, skip = 1)
  
  # Add sequencing ID as a column
  data$Sequencing_ID <- sequencing_id
  
  return(data)
}) %>%
  bind_rows()

colnames(merged_data) <- c("clade_name", "NCBI_tax_id", "relative_abundance", "additional_species", "SeqID")

#merged_data <- merged_data %>%
#  separate(V1, into = c("clade_name", "NCBI_tax_id", "relative_abundance", "additional_species"), sep = ",") %>%
#  mutate(across(everything(), trimws)) # Remove leading and trailing whitespace


merged_data$NCBI_tax_id <- NULL
merged_data$additional_species <- NULL

head(merged_data)

sequencing_ids <- unique(merged_data$SeqID)
clades <- unique(merged_data$clade_name)

str(merged_data$relative_abundance)
#merged_data$relative_abundance <- as.numeric(as.character(merged_data$relative_abundance))


#transposed_data <- data.frame(clade_name = merged_data$clade_name, stringsAsFactors = FALSE)
transposed_data <- dcast(merged_data, clade_name ~ SeqID, value.var = "relative_abundance", fun.aggregate = sum, fill = 0)

write.csv(transposed_data, "genus_abundances_2weeks.csv")
write_tsv(transposed_data, "genus_abundances_2weeks.tsv")
