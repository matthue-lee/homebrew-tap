# homebrew-tap

Homebrew formulae for my small macOS tools.

```bash
brew tap matthue-lee/tap
```

## Tools

### [repo-fresh](https://github.com/matthue-lee/repo-fresh)
Keep local git repos fast-forwarded to their upstreams on a schedule
(fast-forward-only, no sudo).

```bash
brew install matthue-lee/tap/repo-fresh
repo-fresh add /path/to/repo
brew services start repo-fresh      # daily at 07:00
```

### [tz-guard](https://github.com/matthue-lee/tz-guard)
Reset your Mac's system timezone back to your home zone after a chosen hour, so
a work timezone switch never sticks overnight.

```bash
brew install matthue-lee/tap/tz-guard
sudo "$(brew --prefix)/opt/tz-guard/libexec/install.sh"   # root daemon setup
```

## License

Each tool is MIT-licensed in its own repository.
