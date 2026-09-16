# kestrel-ide-manual

Documentation site for [Kestrel IDE](https://github.com/floriankraemer/kestrel-ide), built with [Zensical](https://zensical.org/).

## Container-only workflow

Zensical (and mike, for versioning) are never installed on the host.
All commands run through Docker Compose.

- Preview with live reload: `UID=$(id -u) GID=$(id -g) docker compose up docs` then open http://localhost:8000
- Production build (outputs to `site/`, gitignored): `UID=$(id -u) GID=$(id -g) docker compose --profile build run --rm docs-build`

Passing `UID`/`GID` keeps generated files (`site/`, `.cache/`) owned by your user instead of root.

## Versioning

The manual documents released versions of Kestrel IDE, not every commit of it. Docs versions must stay aligned with Kestrel IDE releases under this rule:

- **Patch releases never matter.** A patch bump in Kestrel IDE (e.g. `1.2.3` → `1.2.4`) requires no docs version change — just update the content of the existing docs version.
- **Minor releases update the existing docs version in place** unless the minor introduces user-facing changes worth calling out as their own entry — use judgement, default to *not* creating a new docs version for a minor.
- **Major releases always get a new docs version.** When Kestrel IDE cuts a new major (e.g. `1.x` → `2.0`), create a new docs version here.
- The manual's version selector therefore shows major versions (occasionally minors), never patch-level versions.

The current version being documented is tracked in [`VERSION`](VERSION) at the repo root (major, or `major.minor` only).

Versioning is implemented with [mike](https://github.com/jimporter/mike) (via the [Zensical-compatible fork](https://github.com/squidfunk/mike)), which builds and deploys each version into its own subfolder on the `gh-pages` branch.

Commands (all via the `docs-version` compose service, which mounts your `~/.gitconfig` for commit identity):

```bash
# Deploy the version in VERSION as itself, alias it "latest", and push
docker compose run --rm docs-version mike deploy --push --update-aliases "$(cat VERSION)" latest

# Point the site root at the latest version
docker compose run --rm docs-version mike set-default --push latest

# List deployed versions
docker compose run --rm docs-version mike list
```

When Kestrel IDE cuts a new major version: update `VERSION`, then run the two commands above (CI does this automatically on push to `main`, see below).

## Publishing

`.github/workflows/deploy-docs.yml` builds the site in the same Docker image on every push to `main`, reads the target version from `VERSION`, and deploys it via `mike` to the `gh-pages` branch (`mike deploy --push --update-aliases $(cat VERSION) latest`, then `mike set-default --push latest`).

Docs are served from the `gh-pages` branch (multi-version layout managed by mike).
