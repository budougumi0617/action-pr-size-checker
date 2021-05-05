# action-pr-size-checker

[![release](https://github.com/budougumi0617/action-pr-size-checker/workflows/release/badge.svg)](https://github.com/budougumi0617/action-pr-size-checker/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/budougumi0617/action-pr-size-checker?logo=github&sort=semver)](https://github.com/budougumi0617/action-pr-size-checker/releases)


Verify pull request size without sepecified file names.

## Input

```yaml
inputs:
  github_token:
    description: 'GITHUB_TOKEN.'
    required: true
    default: ${{ github.token }}
  max_added_count:
    description: 'allow max pr size.'
    required: true
    default: '500'
  filter_pattern:
    # https://github.com/google/re2/wiki/Syntax
    description: 'ignore file name by the regular expression syntax accepted by RE2'
    required: false
```

## Usage

```yaml
name: check-pr-size
on: [pull_request]
jobs:
  linter_name:
    name: runner / check-pr-size
    runs-on: ubuntu-latest
    steps:
      - uses: budougumi0617/action-pr-size-checker@v0
        with:
          github_token: ${{ secrets.github_token }}
          max_added_count: 300
          filter_pattern: "go.mod|go.sum|.*_test.go|.*.md|.*.golden|.*.yml"
```

## Development

### Release

#### [haya14busa/action-bumpr](https://github.com/haya14busa/action-bumpr)
You can bump version on merging Pull Requests with specific labels (bump:major,bump:minor,bump:patch).
Pushing tag manually by yourself also work.

#### [haya14busa/action-update-semver](https://github.com/haya14busa/action-update-semver)

This action updates major/minor release tags on a tag push. e.g. Update v1 and v1.2 tag when released v1.2.3.
ref: https://help.github.com/en/articles/about-actions#versioning-your-action

