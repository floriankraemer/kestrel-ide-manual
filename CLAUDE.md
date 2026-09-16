# kestrel-ide-manual

Documentation site built with [Zensical](https://zensical.org/).

## Container-only workflow

Zensical is never installed on the host.
All commands run through Docker Compose.

- Preview with live reload: `UID=$(id -u) GID=$(id -g) docker compose up docs` then open http://localhost:8000
- Production build (outputs to `site/`, gitignored): `UID=$(id -u) GID=$(id -g) docker compose --profile build run --rm docs-build`
- One-time bootstrap of a new `zensical.toml`/`docs/` scaffold (already done for this repo): `docker run --rm -u "$(id -u):$(id -g)" -v "$PWD":/docs -w /docs $(docker compose build -q docs) zensical new .`

Passing `UID`/`GID` keeps generated files (`site/`, `.cache/`) owned by your user instead of root.

## Publishing

`.github/workflows/deploy-docs.yml` builds the site in the same Docker image on every push to `main` and publishes it to GitHub Pages via `actions/upload-pages-artifact` + `actions/deploy-pages`.

One-time manual step (not automatable from here): in the repo's GitHub Settings → Pages, set Source to "GitHub Actions".
