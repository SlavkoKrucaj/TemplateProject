[![Build Status](https://travis-ci.com/SlavkoKrucaj/TemplateProject.svg?branch=master)](https://travis-ci.com/SlavkoKrucaj/TemplateProject) [![Coverage Status](https://coveralls.io/repos/github/SlavkoKrucaj/TemplateProject/badge.svg)](https://coveralls.io/github/SlavkoKrucaj/TemplateProject)

# TemplateProject

## Initial setup

 ```bash
 $ git clone git@github.com:SlavkoKrucaj/TemplateProject.git [PROJECT_NAME]
 $ cd [PROJECT_NAME]
 $ ./init.sh [PROJECT_NAME]
 $ git remote add origin [GIT_REPO_URL]
 ```

## CI/CD

You should enable [Travis-CI](https://travis-ci.com) and [Coveralls](https://coveralls.io/)to have access to your remote repo

## Templates

There are two templates that contain most of the boilerplate code for creating two types of screens. `Basic` for plain custom views with custom design. `Infinite List` for displaying content inside of a collection view. They both follow `VIPER` architecture pattern.

