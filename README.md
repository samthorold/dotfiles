## Claude Code

- `claude/CLAUDE.md`: global instructions for every Claude Code session. It holds only
  wiring and harness rules, and Imports the rest.

The shared approach for all projects (vocabulary, Guides, Skills, Lessons) lives in
[commons](https://github.com/samthorold/commons). Wiring:

```sh
ln -s ~/Projects/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -s ~/Projects/commons ~/.claude/commons
```

`CLAUDE.md` also Imports a file from a private repo; on a machine without it, that
Import resolves to nothing.

Edit files in their repo (or through the symlinks) and commit.

## Vim

- http://www.viemu.com/vi-vim-cheat-sheet.gif
- http://www.fprintf.net/vimCheatSheet.html
