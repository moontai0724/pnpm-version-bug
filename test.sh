#!/bin/bash

# Fetch tags from the GitHub API
response=$(curl -s "https://api.github.com/repos/pnpm/pnpm/tags")

# Extract version strings from the response
versions=$(echo "$response" | grep -oE '"name": "[^"]+"' | cut -d'"' -f4 | sed 's/^v//')

# Filter out non-release versions
release_versions=()
for version in $versions; do
  if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    release_versions+=("$version")
  fi
done

# Iterate over each release version
for version in "${release_versions[@]}"; do
  # Execute npm run version-test command with the version string
  npm run version-test --pnpm_version="$version"
done
