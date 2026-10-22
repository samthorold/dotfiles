## Claude Code

- `claude/CLAUDE.md`: global instructions for every Claude Code session. It holds only
  wiring and harness rules, and Imports the rest.

The shared approach for all projects (vocabulary, Guides, Skills, Lessons) lives in
[commons](https://github.com/samthorold/commons). Wiring:

```sh
ln -s ~/Projects/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -s ~/Projects/commons ~/.claude/commons
# every commons Skill
for d in ~/.claude/commons/skills/*/; do ln -s "${d%/}" ~/.claude/skills/; done
```

Hooks that belong to a Skill live in that Skill's `hooks/` directory in commons, linked
into `~/.claude/hooks/` and registered in `~/.claude/settings.json` (not tracked):

```sh
mkdir -p ~/.claude/hooks
ln -s ~/.claude/commons/skills/handoff/hooks/handoff-list.py ~/.claude/hooks/
```

```json
"hooks": {
  "SessionStart": [
    {"matcher": "clear", "hooks": [{"type": "command", "command": "python3 ~/.claude/hooks/handoff-list.py", "timeout": 10}]}
  ]
}
```

`CLAUDE.md` also Imports a file from a private repo; on a machine without it, that
Import resolves to nothing.

Edit files in their repo (or through the symlinks) and commit.

## Vim

- http://www.viemu.com/vi-vim-cheat-sheet.gif
- http://www.fprintf.net/vimCheatSheet.html
