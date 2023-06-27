#!/bin/bash

# Fetch tags from the GitHub API
# response=$(curl -s "https://api.github.com/repos/pnpm/pnpm/tags")

# Extract version strings from the response
# versions=$(echo "$response" | grep -oE '"name": "[^"]+"' | cut -d'"' -f4 | sed 's/^v//')

# Filter out non-release versions
release_versions=("8.6.5" "7.33.2" "6.35.1" "5.18.10" "4.14.4" "3.8.1" "8.5.1" "8.4.0" "8.3.1" "8.2.0" "8.1.1" "8.0.0" "7.32.5" "7.1.0")
# for version in $versions; do
#   if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
#     release_versions+=("$version")
#   fi
# done

# Iterate over each release version
for version in "${release_versions[@]}"; do
  # Execute npm run version-test command with the version string
  npm run version-test --pnpm_version="$version"
done
