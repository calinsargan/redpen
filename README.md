# 🖍️ Red Pen

A [Claude Code](https://claude.com/claude-code) plugin that marks the spelling, punctuation and capitalization mistakes in your prompts, like a teacher with a red pen.

It **never fixes them for you**. It lists what you wrote and what it should be, at the top of Claude's reply, so you learn from your own mistakes instead of leaning on autocorrect. If your message is clean, you see nothing.

```
🖍️ Red Pen (high)
- "lets" -> "let's" (short for "let us")
- "mispell" -> "misspell" (two s's)
- "github" -> "GitHub" (product name)
```

## Install

In Claude Code:

```
/plugin marketplace add calinsargan/redpen
/plugin install redpen@redpen
```

Restart Claude Code. Your next prompt gets checked.

## Levels

| Level | Standard | What it flags |
|---|---|---|
| `high` (default) | School essay | Everything: spelling, capitals (sentence start, "I", names), all punctuation including final periods, grammar, and slang like "yo", "gonna" or "ok" |
| `medium` | Work email or Slack | Spelling, apostrophes (lets → let's), "I", capitals at sentence start and on names, wrong words (their/there), sloppy grammar. A missing final period, lowercase bullets and "ok" are fine. |
| `low` | Texting a friend | Only typos, misspellings, and wrong words that change the meaning (their/there, its/it's). All lowercase, no punctuation, "dont" and "u" are fine. |
| `off` | | No check |

Change the level with the slash command:

```
/redpen:redpen medium   # set the level (applies from your next prompt)
/redpen:redpen          # show the current level
```

Or set it by hand:

- `~/.claude/redpen-level` holds the level for every session.
- The `REDPEN_LEVEL` environment variable overrides the file, for example for one session.

## What it checks

Only your own words. Pasted text, code, logs, file paths, commands and identifiers are skipped.

## How it works

A `UserPromptSubmit` hook runs on every prompt and adds the rules for your level to Claude's context. Claude does the checking. No extra tools are needed: the hook is a small POSIX shell script.

## Uninstall

```
/plugin uninstall redpen@redpen
```

---

¹ *Why not "Grammar Nazi"? That name is outdated. Your grammar might be too, and that's what we're here for.*
