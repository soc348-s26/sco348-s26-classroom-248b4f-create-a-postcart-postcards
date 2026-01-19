# Generate Postcard Site
# This script creates a postcard-style personal website using the postcards package

# Function to install required packages if not already installed
install_if_needed <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      message("Installing package: ", pkg)
      install.packages(pkg, repos = "https://cran.r-project.org")
    }
  }
}


# Function to render a postcard to HTML
render_postcard <- function(input_file = "index.Rmd", output_dir = NULL) {

  # Install required packages
  required_packages <- c("rmarkdown")
  install_if_needed(required_packages)

  library(rmarkdown)

  if (!file.exists(input_file)) {
    stop(paste("Input file not found:", input_file))
  }


  # Render the R Markdown file

    rmarkdown::render(input_file)

  output_file <- sub("\\.Rmd$", ".html", input_file)
  if (!is.null(output_dir)) {
    output_file <- file.path(output_dir, basename(output_file))
  }

}

render_postcard()
