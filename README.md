# postcards

A template project for creating a personal postcard site using the [postcards](https://github.com/seankross/postcards) R package.

## Overview

This repository contains a template for building a single-page personal website (postcard) using R Markdown and the postcards package. The site is automatically built and deployed using a custom GitHub Actions workflow.

## Getting Started

### Prerequisites

- R (version 4.0.0 or higher)
- RStudio (optional, but recommended)
- The following R packages:
  - `rmarkdown`
  - `postcards`

### Local Development

1. Clone this repository
2. Open `postcards.Rproj` in RStudio (or open the directory in your preferred R environment)
3. Install required packages:
   ```r
   install.packages(c('rmarkdown', 'postcards'))
   ```
4. Edit `index.Rmd` with your personal information
5. (Optional) Add a `profile.jpg` image to the root directory
6. Render the site:
   ```r
   rmarkdown::render('index.Rmd')
   ```
7. Open `index.html` in your browser to preview

## Customization

### Editing Your Postcard

Edit the `index.Rmd` file to customize your postcard:
- Update the `title` field with your name
- Add your profile image filename to the `image` field
- Update social links under `links`
- Modify the Bio, Education, and Experience sections

### Changing the Template

The postcards package includes several templates:
- `trestles` (default)
- `jolla`
- `jolla-blue`
- `onofre`
- `solana`

To use a different template, change the `output` field in `index.Rmd`:
```yaml
output:
  postcards::jolla
```

## Deployment

### GitHub Actions Workflow

This repository includes a custom GitHub Actions workflow (`.github/workflows/build-postcards.yml`) that:
1. Automatically builds the postcard site when changes are pushed to the `main` branch
2. Uploads the built site as an artifact
3. Deploys to GitHub Pages (optional)

### Enabling GitHub Pages

To deploy your postcard site to GitHub Pages:
1. Go to your repository Settings
2. Navigate to Pages
3. Select the `gh-pages` branch as the source
4. Your site will be available at `https://<username>.github.io/<repository-name>/`

## License

This template is provided as-is for anyone to use and modify.
