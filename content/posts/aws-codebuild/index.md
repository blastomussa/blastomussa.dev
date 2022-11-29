---
title: "How create an Nginx Docker image from a Hugo static site using AWS CodeBuild"
date: 2022-11-28
draft: false

tags: ["AWS", "Hugo", "Golang", "CodeBuild", "Docker", "Devops"]
showEdit: false
showTaxonomies: true
---

In this article, I will go over the basic principles of building a Docker image using AWS Codebuild. I will be using Hugo, an open-sourced static site generator written in Golang, to create a demo blog. AWS Codebuild will be used to build and test the site. Codebuild will also be used to create a Docker image for the site which will then be pushed to an Elastic Container Registry. 

## Hugo

[Hugo](https://gohugo.io ) is a powerful static site generator that has a reputation for speed and flexibility. One of the project's highlights is its focus on maintaining high SEO scores for the sites that it generates. Sites built using the framework consistently score 100 on performance for both mobile and desktop environments using [Google's Pagespeed tool](https://pagespeed.web.dev/). Pages in Hugo can be written in both Markdown and HTML which allows for the speedy development of content. 

Installing Hugo is straightforward but requires that Golang and Git be installed on the system. macOS users can install Hugo using Homebrew: 
`brew install hugo` and Linux users can use snap: `sudo snap install hugo`. You can also install Hugo from the source using Golang. This method will be used later within the buildspec.yml file used in the Codebuild project.
```
go install -tags extended github.com/gohugoio/hugo@latest
```

### Creating a Hugo site

Once Hugo is installed a site template can be created with a few commands. 

```
hugo new site demo-blog
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke themes/ananke
echo "theme = 'ananke'" >> config.toml
```

The `hugo new site` command generates the directory structure needed for the site as well as the default site configuration files. One of the most powerful aspects of the Hugo framework is its use of [themes](https://themes.gohugo.io), of which there are over 400 open-sourced options. Themes can be added as Git submodules to the project and referenced in the config.toml file for use on the site. 

### Building a Hugo site locally 

For development, a Hugo site can be served dynamically using the `hugo serve` command. By default, this will deploy the site on http://127.0.0.1:1313/ and update the site's content with any change to a file in the site's directory. However, serving the site in this way is only meant for development.

In order to build the site into a production ready state, the `hugo` command is used. This compiles the content within the site's file structure into a sub-directory called ***public***. 
