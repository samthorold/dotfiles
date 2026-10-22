# Global working preferences

## Where these instructions live

This file (`~/.claude/CLAUDE.md`) is a symlink into `~/Projects/dotfiles/claude/`, a git repo (github.com/samthorold/dotfiles, **public**). It holds only Claude Code wiring and harness-specific rules. The shared approach for all projects (vocabulary, Guides, Skills, Lessons) is the **Commons**: `~/Projects/commons` (github.com/samthorold/commons, **public**), symlinked to `~/.claude/commons`. Read `~/.claude/commons/CONTEXT.md` before changing it.

- Approach (Conventions, Stances, Procedures) goes in the Commons; wiring and Claude Code harness rules go here.
- Edit files in their repo (writing through a symlink also works, but never replace a symlink with a regular file), then commit and push straight to `main`, no PR, in both repos.
- Both repos are public: keep them free of secrets and private details, **including the names of private projects**. Anything about the projects themselves lives in the private portfolio repo, Imported below.

@~/.claude/commons/MAP.md

@~/.claude/commons/guides/global.md

@~/.claude/commons/guides/agentic-development.md

@~/.claude/commons/guides/project-knowledge.md

## Python Guide

Imported here for every session until Python projects Import it themselves.

@~/.claude/commons/guides/python.md

## Portfolio (private)

@~/Projects/portfolio/projects.md

## Permissions & allowlists (Claude Code)

- **The auto-mode classifier can block commands after `gh pr merge`**, flagging follow-up commands as "Merge Without Review" even when the merge was authorized. When it does, stop and ask the owner; don't work around it (e.g. by rephrasing or chaining the command). *Remove when:* the classifier recognises merges the allowlist authorizes.
- **Run allowlisted Bash commands as plain standalone invocations.** Allow rules in settings are prefix matches against the command string, so wrapping a command in a brace group or adding redirection / `&&` chaining (`{ gh issue create ...; } > out.txt`) makes the string start with `{` and miss the rule — it falls through to the auto-mode classifier, which denies external writes it can't tie to explicit authorization. One allowlisted action per call.
- **The `grind-issues` / commit→PR→squash-merge flow runs in sub-agents**, whose permission classifier cannot see authorization given conversationally to the parent — only `settings.json` allow-rules flow down the control chain. When setting up that flow in a new repo, add to that repo's `.claude/settings.local.json` (gitignored, local): `Bash(git add*)`, `Bash(git commit*)`, `Bash(git fetch*)`, `Bash(git merge*)`, `Bash(git push*)`, `Bash(git switch*)`, `Bash(gh pr create*)`, `Bash(gh pr merge*)`. Where agents work in worktrees, also `Bash(git worktree remove*)` and `Bash(git worktree prune*)`, so the parent can clean up after a hand-back. Never add them user-global: this is how Claude Code implements the Agentic development Guide's Stance that merge authority is granted per repo.
