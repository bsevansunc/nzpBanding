#----------------------------------------------------------------------------*
# ----  Set up ----
#----------------------------------------------------------------------------*

options(stringsAsFactors = FALSE)

# Smart require checks to see if the libraries are present, installs them if
# necessary, and loads them:

smartRequire <- function(packages){
  # Get vector of packages listed that aren't on the current computer
  packagesToInstall <- packages[!packages %in% rownames(installed.packages())]
  if(length(packagesToInstall > 0)){
    install.packages(packagesToInstall, dependencies = TRUE)
  }
  lapply(packages, require, character.only = TRUE)
}

smartRequire(c('tidyverse', 'lubridate','stringr',
               'knitr', 'rmarkdown', 'mongolite'))

#----------------------------------------------------------------------------*
# ----  Inputs ----
#----------------------------------------------------------------------------*

# Get vector of colors:

colorVector <- c('X', 'K', 'B', 'G','M', 'O','P', 'R','W', 'Y')

# Color conversion frame:

colorFrame <- data.frame(
  colorCode = c('-', colorVector),
  color = c('-','alum', 'black', 'blue', 'green', 'purple',
            'orange','pink', 'red', 'white', 'yellow')
)

# Color named vector:

colorNamedVector <- colorFrame$color
names(colorNamedVector) <- colorFrame$colorCode

# What species are you making sheets for? 

species <- c('AMGO', 'AMRO', 'CACH', 'CARW','DEJU','EUST',
            'GRCA','HOFI','HOSP','HOWR','NOCA','NOMO',
            'SOSP','TUTI','WBNU','WTSP')

#----------------------------------------------------------------------------*
# ----  Generate markdown files ----
#----------------------------------------------------------------------------*

## Loop through species and render reports

for (i in 1:length(species)){
  rmarkdown::render(input = "generateColorCombos.Rmd",
                    output_format = "pdf_document",
                    output_file = paste("colorCombos_", species[i], ".pdf", sep=''),
                    output_dir = "nzpColorComboSheets/")
}


  



