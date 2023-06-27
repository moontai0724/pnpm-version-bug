#!/bin/bash

release_versions=$(find "." -type d -name "version-*" | sed 's|.*/version-||')

# Define available titles
titles=("v2.0" "major-v2.0" "minor-v2.0")

# Create a markdown table header
header="| | ${titles[0]} (add) | ${titles[0]} (install)"
for ((i = 1; i < ${#titles[@]}; i++)); do
  header+=" | ${titles[i]} (add) | ${titles[i]} (install)"
done
header+=" |"

# Create a markdown table separator
separator=$(echo "$header" | sed 's/|[^|]*/|:---:/g')

# Initialize the markdown report
report="$header\n$separator|"

# Iterate over each release version
for version in $release_versions; do
  row="| $version"

  # Iterate over each title
  for title in "${titles[@]}"; do
    add_log_file="version-$version/add-$title.log"
    install_log_file="version-$version/install-$title.log"
    package_file="version-$version/package.add-$title.json"

    # Check if log files exist
    if [ -f "$add_log_file" ] && [ -f "$install_log_file" ]; then
      # Extract Vue versions from log files
      add_vue_version=$(grep -oE '+ vue [0-9]+\.[0-9]+\.[0-9]+' "$add_log_file" | cut -d' ' -f3)
      install_vue_version=$(grep -oE '+ vue [0-9]+\.[0-9]+\.[0-9]+' "$install_log_file" | cut -d' ' -f3)

      if [ -z "$add_vue_version" ]; then
        add_vue_version="-"
      fi
      if [ -z "$install_vue_version" ]; then
        install_vue_version="-"
      fi

      row+=" | + $add_vue_version | + $install_vue_version"
    else
      row+=" | -"
    fi
  done

  report+="\n$row |"
done

# Print the markdown report
echo -e "$report"
