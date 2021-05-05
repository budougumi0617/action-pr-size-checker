# action-pr-size-checker

[![release](https://github.com/budougumi0617/action-pr-size-checker/workflows/release/badge.svg)](https://github.com/budougumi0617/action-pr-size-checker/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/budougumi0617/action-pr-size-checker?logo=github&sort=semver)](https://github.com/budougumi0617/action-pr-size-checker/releases)


Verify new function generates a segment for NewRelic with reviewdog on pull requests to improve code review experience.

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
```

## Usage

```yaml
name: nrseg
on: [pull_request]
jobs:
  linter_name:
    name: runner / nrseg inspect
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: budougumi0617/action-pr-size-checker@v0
        with:
          github_token: ${{ secrets.github_token }}
          nrseg_flags: "-i testing ./src"
          # Change reviewdog reporter if you need [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Change reporter level if you need.
          # GitHub Status Check won't become failure with warning.
          level: warning
```



