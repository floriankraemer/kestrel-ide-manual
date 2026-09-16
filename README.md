# Kestrel IDE Manual

This repository contains the user manual and documentation for [Kestrel IDE](https://github.com/floriankraemer/kestrel-ide).

The docs are built with [Zensical](https://zensical.org/) and published to GitHub Pages.

## Working on the docs

Everything runs in Docker, nothing is installed on the host. See [CLAUDE.md](CLAUDE.md) for the full workflow, including preview, build, and versioned deploys.

```bash
UID=$(id -u) GID=$(id -g) docker compose up docs
```

Then open http://localhost:8000.
