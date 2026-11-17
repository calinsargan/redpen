---
name: redpen
description: Show or set the Red Pen level (high, medium, low, off), the spelling and mechanics check that the UserPromptSubmit hook runs on every prompt. Only when the user runs /redpen.
disable-model-invocation: true
argument-hint: "[high|medium|low|off]"
---

# 🖍️ Red Pen¹

The Red Pen hook reads its level from `~/.claude/redpen-level`. The `REDPEN_LEVEL` env var overrides the file.

Argument: `$ARGUMENTS`

- No argument: run `cat ~/.claude/redpen-level 2>/dev/null || echo "low (default)"` and report the current level, plus one line per level:
  - high: school essay. Capitals, proper nouns, all punctuation, grammar, no slang.
  - medium: professional. Spelling, apostrophes, "I", sentence-start capitals, proper nouns, wrong words. Ignores final periods and casual-but-correct words.
  - low: casual. Only typos, misspellings, and wrong words that change meaning.
  - off: no check.
  End the reply with the footnote below, as it is.
- `high`, `medium`, `low` or `off` (any case): run `printf '%s\n' <level> > ~/.claude/redpen-level` and confirm in one line. It applies from the next prompt.
- Anything else: say the valid values. Don't write the file.

Don't apply Red Pen flags to the `/redpen` command itself.

Footnote:

> ¹ *Why not "Grammar Nazi"? That name is outdated. Your grammar might be too, and that's what we're here for.*
