# Python projects: development and maintenance approach

The default setup for every Python project. When starting or touching a Python repo, bring it in line with this, and record the project's own specifics (commands, check names, versions, traps) in that repo's `CLAUDE.md`. Reference implementations: `~/Projects/py-ev` (single Python version) and `~/Projects/superenums` (Python version matrix, multiple type checkers). Copy files from them rather than rewriting from memory. Update this file when the approach changes.

## Tooling

- **uv for everything**: environments, dependencies, running tools (`uv run ...`, `uv add --dev ...`). No bare `pip`, no globally installed tools. src layout, `uv_build` backend.
- **uv itself is pinned** with `[tool.uv] required-version = "==X.Y.Z"` in `pyproject.toml`, and the `[build-system]` bound matches it (`uv_build>=X.Y.Z,<X.(Y+1)`). setup-uv reads the pin in CI; without it, CI silently uses the latest uv and drifts from local. Upgrade uv deliberately in one PR (pin, build bound, `uv lock`). Locally, uv comes from the standalone installer (`~/.local/bin`), so `uv self update <version>` works.
- **Dev dependencies pinned exactly** (`==`), so `uv.lock`, pre-commit and CI run identical versions.
- **ruff** for lint and format. Rule set: `E, W, F, I, B, UP, SIM, RUF`, `target-version` = the minimum Python. If ruff should skip some paths (`extend-exclude`), also set `force-exclude = true`, because pre-commit passes files explicitly and ruff ignores excludes for explicit files otherwise.
- **Type checking**: ty at least. Add pyright and/or mypy (strict) where typing is part of the product. Put pyright config in `pyrightconfig.json`, not `[tool.pyright]`: a `pyrightconfig.json` in a parent directory (e.g. `~`) wins over a pyproject section.
- **pytest**, with doctests where the project has them.
- **Version**: single source in `pyproject.toml`. The package's `__version__ = importlib.metadata.version("<dist-name>")`, with a test that it matches `pyproject.toml`.
- **Taskfile.yml** ([Task](https://taskfile.dev)) for common commands: `test`, `lint`, `fmt`, plus project-specific ones, and `version` / `bump` (`uv version --bump {{.CLI_ARGS}}`). Without `task` installed: `uvx --from go-task-bin task <name>`.

## pre-commit

- `uv run pre-commit install` once per clone. `uv run pre-commit run --all-files` is exactly what CI runs.
- Hooks: `pre-commit/pre-commit-hooks` (trailing-whitespace, end-of-file-fixer, check-yaml, check-toml, check-json, debug-statements, check-added-large-files), then local hooks through `uv run --locked` (so they use `uv.lock`'s versions, and fail if it's stale): ruff check `--fix`, ruff format, the type checker(s), actionlint (also shellchecks workflow `run:` steps), shellcheck on shell scripts, and the tests (`pass_filenames: false`).
- actionlint and shellcheck come from PyPI as dev dependencies (`actionlint-py`, `shellcheck-py`), not system installs.

## CI (GitHub Actions)

- `ci.yml`: one job named `pre-commit` that runs `uv sync --locked` then `uv run --locked pre-commit run --all-files --show-diff-on-failure`. Triggers: every `pull_request`, and `push` to `main` only on `paths: [uv.lock]` (PRs must be up to date and green before merge, so re-running on main only matters for warming the uv cache PRs restore from).
- Several Python versions: a matrix, job named `pre-commit (${{ matrix.python-version }})`, with `env: UV_PYTHON: ${{ matrix.python-version }}` so every `uv` call, including the hooks', uses it. One version: no matrix.
- `permissions: contents: read`, a `concurrency` group cancelling superseded runs, `astral-sh/setup-uv` with `enable-cache: true`.
- **Pin actions to exact versions** (`astral-sh/setup-uv@v10.3.0`). setup-uv publishes no floating major tags.

## Releases

- `release.yml` + `.github/scripts/release-check.sh` (copy from py-ev): on every push to `main`, if `v<version>` isn't tagged, build, tag and publish a GitHub Release with the distributions and generated notes; on PRs a dry run, failing if the PR changes the version to one already tagged.
- **Feature PRs never change the version.** A release is its own PR that only bumps it (`task bump -- patch|minor|major`). Never tag by hand. Hotfixes fix forward (fix, then a patch-bump PR).
- **Merging a version bump publishes a release: ask before merging it.**
- A tag created by `GITHUB_TOKEN` triggers no other workflows, so release work belongs in `release.yml` itself.

## GitHub repo settings and branch protection

- Merge settings: squash merge only (no merge commits, no rebase), delete branch on merge.
- A `main` **ruleset** (Settings → Rules, or `gh api -X POST repos/<owner>/<repo>/rulesets --input ruleset.json`): block deletion and non-fast-forward; require a PR with 0 approvals and `allowed_merge_methods: ["squash"]`; required status checks = the CI job names (`integration_id` 15368, GitHub Actions) with `strict_required_status_checks_policy: true` (branch must be up to date); no bypass actors. Copy py-ev's with `gh api repos/samthorold/py-ev/rulesets/<id>`.
- Create the ruleset only after CI has reported under the exact job names, and record the required check names in the repo's `CLAUDE.md`: renaming the job or changing the matrix breaks merging until the ruleset is updated.

## Workflow

- Every change goes through a branch and a PR, never straight to `main`.
- A PR whose checks all pass may be squash-merged without asking (`gh pr merge <n> --squash --delete-branch`, then `git switch main`, `git pull`), except version bumps (above). Wait for green with `gh pr checks <n> --watch`; never merge with failing or pending checks.
- A PR that falls behind `main`: `gh pr update-branch <n>`, then wait for CI again.
- Repos using this flow need the per-project allowlist in `.claude/settings.local.json` (see the global CLAUDE.md).

## Known traps

- `actionlint-py` ships only an sdist that downloads the binary on build. On macOS with python.org Python that fails with `CERTIFICATE_VERIFY_FAILED` until `Install Certificates.command` has run; one-off workaround `SSL_CERT_FILE=/etc/ssl/cert.pem uv sync`.
- pre-commit only sees tracked files: stage a new file before expecting a hook (e.g. shellcheck) to check it.
