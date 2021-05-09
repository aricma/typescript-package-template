#!/usr/bin/env bash


# given:
# - you have homebrew installed
# - you have git installed
# - you have node, npm and yarn installed


# setup npm typescript package

BUILD_DIR=build

function changePackageJson {
  JQ_JOB=$1
  cat < package.json | jq "$JQ_JOB" > tmp_package.json
  mv tmp_package.json package.json
}

# setup node environment
git init

# setup node package
yarn init -y

# add packages
yarn add --dev @babel/core @babel/cli @babel/preset-env
yarn add --dev typescript @babel/preset-typescript
yarn add --dev jest babel-jest @types/jest
yarn add --dev eslint

# add jq for json manipulation
brew install jq

# set main in package.json
changePackageJson ".main = \"$BUILD_DIR/index.js\""

# set types
changePackageJson ".types = \"$BUILD_DIR/index.d.ts\""

# set scripts
changePackageJson ".scripts = {}"
changePackageJson ".scripts.build = \"tsc\""
changePackageJson ".scripts.test = \"jest src --watchAll=true\""
changePackageJson ".scripts.coverage = \"jest src --watchAll=false --coverage\""
changePackageJson ".scripts.lint = \"eslint src\""

# use all configs
cp configs/* .
mv gitignore .gitignore
