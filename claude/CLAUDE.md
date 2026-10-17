# Global working preferences

## Where these instructions live

This file (`~/.claude/CLAUDE.md`) and the files it imports are symlinks into `~/Projects/dotfiles/claude/`, a git repo (github.com/samthorold/dotfiles, public). When asked to change these global instructions or the Python playbook, or when a better practice is agreed:

- Edit the file in `~/Projects/dotfiles/claude/` (writing through the symlink also works, but never replace the symlink with a regular file).
- Then commit and push in `~/Projects/dotfiles`, as the repo's history does: straight to `main`, no PR.
- New global files go in `~/Projects/dotfiles/claude/` too, symlinked into `~/.claude/` and listed in the dotfiles README.
- Keep it free of secrets and private details: the repo is public.

## Durable knowledge goes in source control, not private memory

- **Don't keep project knowledge in auto-memory.** Anything worth remembering across sessions (workflow, runtimes, known traps, vision, how to work on the project) goes in the repo's `CLAUDE.md` or the docs it points to, so it is committed, reviewed and visible. Update those docs instead of writing a memory file.

## Python projects

The standard development, CI, release and repo-settings approach for every Python project (`~/Projects/dotfiles/claude/python-projects.md`). Update it as the approach changes.

@~/.claude/python-projects.md

## Permissions & allowlists (Claude Code)

- **Run allowlisted Bash commands as plain standalone invocations.** Allow rules in settings are prefix matches against the command string, so wrapping a command in a brace group or adding redirection / `&&` chaining (`{ gh issue create ...; } > out.txt`) makes the string start with `{` and miss the rule — it falls through to the auto-mode classifier, which denies external writes it can't tie to explicit authorization. One allowlisted action per call.
- **The `grind-issues` / commit→PR→squash-merge flow runs in sub-agents**, whose permission classifier cannot see authorization given conversationally to the parent — only `settings.json` allow-rules flow down the control chain. When setting up that flow in a new repo, add to that repo's `.claude/settings.local.json` (gitignored, local): `Bash(git add*)`, `Bash(git commit*)`, `Bash(git push*)`, `Bash(git switch*)`, `Bash(gh pr create*)`, `Bash(gh pr merge*)`. Scope these **per-project, not user-global**, so the irreversible `gh pr merge` blast radius stays confined to repos explicitly opted in.
