setwd("C:/Users/scvogel/Dropbox/BASELab/DMMProject/Data/Microbiomedata/2 week/sequencing/NON-HOST/HUMANN/All")
setwd("/Users/sarahvogel/Library/CloudStorage/Dropbox/BASELab/DMMProject/Data/Microbiomedata/18 month/sequencing/NON-HOST/HUMANN/All")#laptop
files <- list.files(pattern = "\\.tsv$")
files
species_data_list <- list()

# Loop through each file
# Loop through each file
# Loop through each file
# Loop through each file
# Loop through each file
for (file in files) {
  # Read MetaPhlAn file
  data <- read.table(file, header = TRUE, skip = 4, sep = "\t", stringsAsFactors = FALSE)
  colnames(data)[1] <- "clade_name"
  colnames(data)[2] <- "NCBI_tax_id"
  colnames(data)[3] <- "relative_abundance"
  colnames(data)[4] <- "additional_species"
  # Filter data to include only species-level information
  species_data <- data[grepl("\\|s__", data$clade_name), ]
  species_data <- species_data[!grepl("\\|t__", species_data$clade_name),] #filter out the strain-level taxa
  # Extract sample ID from file name
  sample_id <- gsub("\\.txt", "", file)
  
  # Save filtered species data to a new file with sample ID
  write.csv(species_data, paste0(sample_id, "_species_data.csv"), row.names = FALSE)
  
  # Add filtered species data to the list
  species_data_list[[sample_id]] <- species_data
}

#this works for most, but not all, need to do the rest manually?

