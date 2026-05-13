---
name: breathe
description: Open a guided breathing session in a chromeless Chrome app window. Use when the user explicitly types /breathe, or asks to run a breathing exercise. Supports four exercises (4-7-8, box, coherent, physiological sigh) and remembers user preferences across sessions.
disable-model-invocation: true
---

Open a breathing session in a chromeless Chrome app window. Multiple exercises supported. Picks one based on user preferences when not specified.

**Arguments:** `$ARGUMENTS` — free-form. Each token is either an exercise name or a cycle count (integer 1–10). Order doesn't matter.

## Exercises

| Name | Aliases | Pattern | Default cycles | Best for |
|---|---|---|---|---|
| `478` | `4-7-8`, `four-seven-eight` | 4 in / 7 hold / 8 out | 4 | Stress, sleep onset (Dr. Weil's prescription) |
| `box` | `square`, `tactical` | 4 in / 4 hold / 4 out / 4 rest | 4 | Focus, concentration, pre-performance |
| `coherent` | `resonance`, `hrv`, `5.5` | 5.5 in / 5.5 out | 6 | Sustained calm, HRV training |
| `sigh` | `physiological`, `reset`, `physsigh` | double inhale + long exhale | 3 | Quick reset between tasks |

## What to do

### 1. Parse `$ARGUMENTS`

Split on whitespace. For each token (case-insensitive):
- If it matches an exercise name or alias above → that's the exercise
- If it's an integer between 1 and 10 → that's the cycle count
- Otherwise → reject with a friendly message that lists the exercises

If multiple exercise names are given, use the last one. If multiple integers, use the last one. If something is unparseable, stop and say so — don't guess.

### 2. Pick an exercise (if not specified)

If the user didn't specify an exercise, check memory for a file like `user_breathing_preferences.md`. Two cases:

**No preferences yet:** Pick `478` as a default, and after launching, note in chat: "Picked 4-7-8 today. After this session, tell me how it felt and I'll start learning what works for you." Don't update memory yet.

**Preferences exist:** Pick based on what the user has responded well to, with some variety (don't repeat the last one chosen unless they explicitly liked it). Pick silently and just launch.

### 3. Launch

Build the URL with the canonical exercise key and cycle count. Run:

```bash
open -na "Google Chrome" --args --app="https://jayvee6.github.io/ripple/?exercise=KEY&cycles=N"
```

If Chrome isn't installed (the command fails), fall back to:

```bash
open "https://jayvee6.github.io/ripple/?exercise=KEY&cycles=N"
```

### 4. Reply in chat

One sentence. Include the exercise, cycle count, and rough duration. Examples:

- `/ripple:breathe` (no prefs) → "Opening 4-cycle 4-7-8 — see you in about 76 seconds. Tell me afterwards how it felt."
- `/ripple:breathe box 6` → "Opening 6-cycle box breathing — about 96 seconds."
- `/ripple:breathe coherent` → "Opening 6-cycle coherent breathing (5.5/5.5) — about 66 seconds."
- `/ripple:breathe sigh` → "Opening a physiological sigh reset — about 23 seconds."

Duration formulas:
- 478: 19 × cycles
- box: 16 × cycles
- coherent: 11 × cycles
- sigh: ~7.5 × cycles

### 5. After the session — listen for feedback

When the user comes back and says anything about how the session felt (positive, negative, neutral, or even just "again"), update or create `user_breathing_preferences.md` in memory with their reaction. Note which exercise it was, what they said, and the date. This is how the rotation learns.

Examples of feedback worth saving:
- "that was great" → positive for that exercise
- "felt too long" → negative or "wants shorter"
- "loved the box one" → strong positive
- "didn't help" → negative

Don't ask for feedback proactively unless they offered one already — that gets annoying. Just listen.

Do not narrate the steps, do not show the command, do not explain anything else unless asked. Launch and reply.
