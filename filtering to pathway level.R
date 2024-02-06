setwd("/Users/sarahvogel/Library/CloudStorage/Dropbox/BASELab/DMMProject/Data/Microbiomedata/2 week/sequencing/NON-HOST/HUMANN/All_paths")

files <- list.files(pattern = "\\.tsv$")
files

pathway_list <- list()


# Loop through each file
for (file in files) {
  # Read MetaPhlAn file
  data <- read.table(file, header = TRUE, skip = 1, sep = "\t", stringsAsFactors = FALSE)
  colnames(data)[1] <- "pathway"
  
  # Filter data to include only species-level information
  pathways_data <- data[!grepl("\\|g__", data$pathway), ]
  
  # Extract sample ID from file name
  sample_id <- gsub("\\.txt", "", file)
  
  # Save filtered species data to a new file with sample ID
  write.csv(pathways_data, paste0(sample_id, "_pathways_data.csv"), row.names = FALSE)
  
  # Add filtered species data to the list
  species_data_list[[sample_id]] <- species_data
}



