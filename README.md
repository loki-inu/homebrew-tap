# loki-inu/homebrew-tap

Homebrew formulae for loki-inu tools.

## relnote

[relnote](https://github.com/loki-inu/relnote) turns a git range into clean GitHub release notes, or prepends a Keep a Changelog section to `CHANGELOG.md`. Pure standard-library Python, no config file, no GitHub API.

```bash
brew install loki-inu/tap/relnote
relnote --help
```

Or tap first:

```bash
brew tap loki-inu/tap
brew install relnote
```

Usage:

```bash
relnote                                   # notes since the latest tag
relnote --since v1.2.0 --until v1.3.0     # explicit range
relnote --changelog CHANGELOG.md --changelog-title v1.3.0
```

Docs: https://loki-inu.github.io/relnote/

Works on macOS and Linux (Homebrew on Linux). Tested in CI on both.

## Other ways to install relnote

```bash
pip install git+https://github.com/loki-inu/relnote.git
gh extension install loki-inu/gh-relnote
```

## License

Formulae: MIT. Each tool keeps its own license (relnote is MIT).
