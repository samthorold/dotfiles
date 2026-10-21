# Global working preferences

## Where these instructions live

This file (`~/.claude/CLAUDE.md`) is a symlink into `~/Projects/dotfiles/claude/`, a git repo (github.com/samthorold/dotfiles, **public**). It holds only Claude Code wiring and harness-specific rules. The shared approach for all projects (vocabulary, Guides, Skills, Lessons) is the **Commons**: `~/Projects/commons` (github.com/samthorold/commons, **public**), symlinked to `~/.claude/commons`. Read `~/.claude/commons/CONTEXT.md` before changing it.

- Approach (Conventions, Stances, Procedures) goes in the Commons; wiring and Claude Code harness rules go here.
- Edit files in their repo (writing through a symlink also works, but never replace a symlink with a regular file), then commit and push straight to `main`, no PR, in both repos.
- Both repos are public: keep them free of secrets and private details, **including the names of private projects**. Anything about the projects themselves lives in the private portfolio repo, Imported below.

@~/.claude/commons/MAP.md

@~/.claude/commons/guides/global.md

@~/.claude/commons/guides/agentic-development.md

## Python Guide

Imported here for every session until Python projects Import it themselves.

@~/.claude/commons/guides/python.md

## Portfolio (private)

@~/Projects/portfolio/projects.md

## Permissions & allowlists (Claude Code)

- **Run allowlisted Bash commands as plain standalone invocations.** Allow rules in settings are prefix matches against the command string, so wrapping a command in a brace group or adding redirection / `&&` chaining (`{ gh issue create ...; } > out.txt`) makes the string start with `{` and miss the rule — it falls through to the auto-mode classifier, which denies external writes it can't tie to explicit authorization. One allowlisted action per call.
- **The `grind-issues` / commit→PR→squash-merge flow runs in sub-agents**, whose permission classifier cannot see authorization given conversationally to the parent — only `settings.json` allow-rules flow down the control chain. When setting up that flow in a new repo, add to that repo's `.claude/settings.local.json` (gitignored, local): `Bash(git add*)`, `Bash(git commit*)`, `Bash(git push*)`, `Bash(git switch*)`, `Bash(gh pr create*)`, `Bash(gh pr merge*)`. Scope these **per-project, not user-global**, so the irreversible `gh pr merge` blast radius stays confined to repos explicitly opted in.
