#!/usr/bin/env bash

readonly UPSTREAM_REPOSITORY='better-lyrics/better-lyrics'
readonly SEMVER_BUILD_METADATA_PREFIX='safari.'
readonly SEMVER_TRIPLET_REGEX='^[0-9]+\.[0-9]+\.[0-9]+'

version_ge() {
  [ "$(printf "%s\n" "$1" "$2" | sort -V | head -n 1)" = "$2" ]
}

version_gt() {
  [ "$1" != "$2" ] && version_ge "$1" "$2"
}

check() {
  # Get the latest release version of the upstream and current repository
  # If the command fails, exit with the command status
  if upstream_version=$(gh release view -R "$UPSTREAM_REPOSITORY" --json tagName -q .tagName); then
    echo "Upstream latest release tag: $upstream_version"
  else
    code=$?
    echo "::error::Failed to get the latest release's tag name of the upstream repository"
    exit $code
  fi
  if current_version=$(gh release view -R "$GITHUB_REPOSITORY" --json tagName -q .tagName); then
    echo "Current latest release tag: $current_version"
  else
    code=$?
    echo "::error::Failed to get the latest release's tag name of the current repository"
    exit $code
  fi

  upstream_triplet=$(grep -oE "$SEMVER_TRIPLET_REGEX" <<< "${upstream_version#v}")
  current_triplet=$(grep -oE "$SEMVER_TRIPLET_REGEX" <<< "${current_version#v}")
  echo "::debug::upstream_triplet=$upstream_triplet"
  echo "::debug::current_triplet=$current_triplet"

  if version_gt "$upstream_triplet" "$current_triplet"; then
    echo "new-upstream-version=${upstream_version}" >> "$GITHUB_OUTPUT"
    release_name="${upstream_version#v}+${SEMVER_BUILD_METADATA_PREFIX}0"
    echo "release-name=$release_name" >> "$GITHUB_OUTPUT"

    echo "## Create release $release_name" >> "$GITHUB_STEP_SUMMARY"
  else
    echo "## The current version is in sync with upstream" >> "$GITHUB_STEP_SUMMARY"
  fi

  {
    echo "| Repository | Latest release |"
    echo "| --- | --- |"
    echo "| Upstream | $upstream_version |"
    echo "| Current | $current_version |"
  } >> "$GITHUB_STEP_SUMMARY"
}

check
