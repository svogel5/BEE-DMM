# Define the path to the "Human" folder
human_folder <- "~/Library/CloudStorage/Dropbox/BASELab/DMMProject/Data/Microbiomedata/18 month/sequencing/NON-HOST/HUMANN"

# Create a folder named "All" if it doesn't exist
all_folder <- file.path(human_folder, "All_paths")
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
  abundance_files <- files[grep("pathabundance", files)]
  
  # Copy metaphlan files to the "All" folder
  file.copy(abundance_files, all_folder, overwrite = TRUE)
}

