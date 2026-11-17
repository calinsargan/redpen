#!/bin/sh
# Red Pen — a UserPromptSubmit hook that asks Claude to flag spelling and
# mechanics mistakes in each prompt, without fixing them for you.¹
#
# Level: $REDPEN_LEVEL, else ~/.claude/redpen-level, else "low".
# Levels: high | medium | low | off

LEVEL="${REDPEN_LEVEL:-$(cat "$HOME/.claude/redpen-level" 2>/dev/null)}"
LEVEL="$(printf '%s' "${LEVEL:-low}" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')"

case "$LEVEL" in
  off) exit 0 ;;
  high)
    SCOPE="STRICT (school essay standard). Flag everything a teacher would mark: spelling; capitalization (first word of every sentence and list item, the pronoun 'I', proper nouns, product and company names, acronyms like OK/API); all punctuation (end-of-sentence periods, commas, apostrophes, question marks, run-on sentences, comma splices); grammar (subject-verb agreement, tense, articles, wrong word forms); and informal or slang words in place of standard ones ('yo', 'gonna', 'ok', 'u')." ;;
  medium)
    SCOPE="PROFESSIONAL (work email or Slack with a manager). Flag: spelling; missing or wrong apostrophes (lets/let's, dont/don't, its/it's); the pronoun 'I'; capital letter at the start of a sentence; proper nouns and product names; wrong words (their/there, your/you're); and grammar errors that would look sloppy at work. Do NOT flag: a missing period at the end of a message or bullet, lowercase list items, Oxford commas, sentence fragments, or casual-but-correct words like 'ok' or 'yeah'." ;;
  low)
    SCOPE="CASUAL (texting a friend). All-lowercase, missing punctuation, slang ('yo', 'gonna', 'u', 'ok'), dropped apostrophes in common contractions ('dont', 'im', 'cant'), and fragments are all fine. Flag ONLY real typos, misspelled words ('mispell', 'teh', 'recieve'), and wrong words that change the meaning (their/there/they're, your/you're, its/it's, then/than, lets/let's, were/we're)." ;;
  *)
    printf '{"systemMessage":"redpen: unknown level (use high, medium, low or off)"}\n'
    exit 0 ;;
esac

# No double quotes or backslashes in the text below, so it is safe to embed in JSON as is.
CONTEXT="Red Pen spelling and mechanics check, level: $LEVEL. Before answering, scan the user's own words in this prompt (not pasted content, code, logs, file paths, commands, or identifiers) for mistakes. What counts as a mistake at this level: $SCOPE Do NOT rewrite, edit, or autocorrect the prompt. If you find mistakes, list ONLY the flagged words or phrases at the very top of your response under a '🖍️ Red Pen ($LEVEL)' header, as 'what they wrote' -> 'correct form', each with a very short reason. Keep it brief and objective. If there are zero mistakes at this level, skip the header entirely and just answer normally."

printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"%s"}}\n' "$CONTEXT"

# ¹ Why "Red Pen" and not "Grammar Nazi"? That name is outdated — unlike your
#   grammar, which this hook will happily tell you about.
