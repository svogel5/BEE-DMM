# Define the path to the "Human" folder
human_folder <- "C:/Users/scvogel/Dropbox/BASELab/DMMProject/Data/Microbiomedata/2 week/sequencing/NON-HOST/HUMANN"

# Create a folder named "All" if it doesn't exist
all_folder <- file.path(human_folder, "All")
if (!file.exists(all_folder)) {
  dir.create(all_folder)
}

# List all subdirectories in the "Human" folder
subfolders <- list.dirs(human_folder, recursive = TRUE)
subfolders
# Loop through each subfolder
for (subfolder in subfolders) {
  # List files in the current subfolder
  files <- list.files(subfolder, full.names = TRUE)
  
  # Filter files containing the word "metaphlan"
  metaphlan_files <- files[grep("metaphlan", files)]
  
  # Copy metaphlan files to the "All" folder
  file.copy(metaphlan_files, all_folder, overwrite = TRUE)
}

# Print a message indicating the task is complete
cat("Files containing 'metaphlan' have been copied to the 'All' folder.\n")
