# postcards

A template project for creating a personal postcard site using the [postcards](https://github.com/seankross/postcards) R package.

## Overview

This repository contains a template for building a single-page personal website (postcard) using R Markdown and the postcards package. The site is automatically built and deployed using a custom GitHub Actions workflow.

## Getting Started


### Development Right on Github

1. For our class, accept the classroom project.  (If someone else wants to use this, fork or clone the project).
2. Working right on Github, edit `index.Rmd` with your personal information. Commit your changes (green button, top right, write a short message).
3. (Optional) Add a `profile.jpg` image to the root directory
4. Wait while Github works on rendering your site.  You can see this by going to the "Actions" tab. 

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

### Enabling GitHub Pages

To deploy your postcard site to GitHub Pages:
1. Go to your repository.
2. Click on Fork.
3. When the forking starts _uncheck_ the box that says "Copy the main branch only"
4. Go to your new repository and go to Settings
5. Navigate to Pages (on the left)
6. Select the `gh-pages` branch as the source
7. Click on the Actions tab. (in the horizontal tabs above the code)
8. You will likely see a message that says, "Workflows aren't being run on this forked repository."
Click the button that says "I understand my workflows, go ahead and enable them".
9. Still in the actions tab on the left, click on Run and Deploy Postcards.
10. Click on Run Workflow. It takes a while to run. It is done when you see the green check mark. 
11. Your site will be available at `https://<username>.github.io/<repository-name>/`

## License

This template is provided as-is for anyone to use and modify.
