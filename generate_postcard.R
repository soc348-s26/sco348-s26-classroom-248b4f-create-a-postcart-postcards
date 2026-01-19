#!/usr/bin/env Rscript

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

# Function to create a postcard site
create_postcard <- function(name = "index.Rmd", 
                           template = "jolla",
                           output_dir = ".",
                           title = "Your Name",
                           author = "Your Name",
                           email = "your.email@example.com",
                           github = "yourusername",
                           linkedin = "yourusername",
                           open_file = TRUE) {
  
  # Install required packages
  required_packages <- c("postcards", "rmarkdown")
  install_if_needed(required_packages)
  
  # Load postcards library
  library(postcards)
  
  # Available templates: jolla, jolla-blue, trestles, onofre, solana
  valid_templates <- c("jolla", "jolla-blue", "trestles", "onofre", "solana")
  
  if (!(template %in% valid_templates)) {
    stop(paste("Invalid template. Choose from:", paste(valid_templates, collapse = ", ")))
  }
  
  # Create the postcard
  message("Creating postcard with template: ", template)
  
  # Set the output path
  output_path <- file.path(output_dir, name)
  
  # Check if file already exists
  if (file.exists(output_path)) {
    response <- readline(prompt = sprintf("File '%s' already exists. Overwrite? (y/n): ", output_path))
    if (tolower(response) != "y") {
      message("Cancelled. No files were created.")
      return(invisible(NULL))
    }
  }
  
  # Create the postcard file
  postcards::create_postcard(
    file = output_path,
    template = template,
    edit = FALSE
  )
  
  # Read the created file and customize it with provided information
  if (file.exists(output_path)) {
    content <- readLines(output_path)
    
    # Update YAML header with provided information
    content <- gsub('title: ".*"', paste0('title: "', title, '"'), content)
    content <- gsub('name: ".*"', paste0('name: "', author, '"'), content)
    
    # Add or update links section if not present
    links_section <- which(grepl("^links:", content))
    if (length(links_section) == 0) {
      # Find the end of YAML header
      yaml_end <- which(content == "---")[2]
      if (!is.na(yaml_end)) {
        # Insert links before the closing ---
        new_links <- c(
          "links:",
          sprintf('  - label: Email'),
          sprintf('    url: "mailto:%s"', email),
          sprintf('  - label: GitHub'),
          sprintf('    url: "https://github.com/%s"', github),
          sprintf('  - label: Linkedin'),
          sprintf('    url: "https://linkedin.com/%s"', linkedin)
        )
        content <- c(content[1:(yaml_end-1)], new_links, content[yaml_end:length(content)])
      }
    }
    
    # Write the updated content
    writeLines(content, output_path)
    
    message("\n✓ Postcard created successfully: ", output_path)
    message("\nNext steps:")
    message("1. Edit ", output_path, " to customize your content")
    message("2. Add your photo as 'image.jpg' in the same directory")
    message("3. Render the postcard with: rmarkdown::render('", output_path, "')")
    
    if (open_file && interactive()) {
      file.edit(output_path)
    }
    
    return(invisible(output_path))
  } else {
    stop("Failed to create postcard file")
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
  
  message("Rendering postcard: ", input_file)
  
  # Render the R Markdown file
  if (is.null(output_dir)) {
    rmarkdown::render(input_file)
  } else {
    rmarkdown::render(input_file, output_dir = output_dir)
  }
  
  output_file <- sub("\\.Rmd$", ".html", input_file)
  if (!is.null(output_dir)) {
    output_file <- file.path(output_dir, basename(output_file))
  }
  
  message("✓ Postcard rendered successfully: ", output_file)
  
  return(invisible(output_file))
}

# Main execution function
main <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  
  if (length(args) == 0) {
    # Interactive mode - create a basic postcard
    cat("\n=== Postcard Generator ===\n\n")
    cat("Available templates: jolla, jolla-blue, trestles, onofre, solana\n\n")
    
    template <- readline(prompt = "Enter template name (default: jolla): ")
    if (template == "") template <- "jolla"
    
    name <- readline(prompt = "Enter your name: ")
    if (name == "") name <- "Your Name"
    
    email <- readline(prompt = "Enter your email: ")
    if (email == "") email <- "your.email@example.com"
    
    github <- readline(prompt = "Enter your GitHub username: ")
    if (github == "") github <- "yourusername"
    
    linkedin <- readline(prompt = "Enter your Linkedin username: ")
    if (linkedin == "") linkedin <- "yourusername"
    
    create_postcard(
      template = template,
      title = name,
      author = name,
      email = email,
      github = github,
      linkedin = linkedin
    )
    
    cat("\nWould you like to render the postcard now? (y/n): ")
    render_now <- readline()
    if (tolower(render_now) == "y") {
      render_postcard()
    }
    
  } else if (args[1] == "create") {
    # Command line mode - create postcard
    template <- ifelse(length(args) >= 2, args[2], "jolla")
    create_postcard(template = template, open_file = FALSE)
    
  } else if (args[1] == "render") {
    # Command line mode - render postcard
    input_file <- ifelse(length(args) >= 2, args[2], "index.Rmd")
    render_postcard(input_file = input_file)
    
  } else {
    cat("\nUsage:\n")
    cat("  Rscript generate_postcard.R                    # Interactive mode\n")
    cat("  Rscript generate_postcard.R create [template]  # Create postcard with specified template\n")
    cat("  Rscript generate_postcard.R render [file]      # Render postcard to HTML\n")
    cat("\nAvailable templates: jolla, jolla-blue, trestles, onofre, solana\n")
  }
}

# Run main function if script is executed directly
if (!interactive()) {
  main()
}
