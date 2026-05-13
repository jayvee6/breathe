Open a 4-7-8 breathing session in a chromeless Chrome app window.

**Argument:** `$ARGUMENTS` — optional integer 1–10 for the number of cycles. Default: 4.

## What to do

1. **Parse cycles from `$ARGUMENTS`:**
   - Empty/missing → use `4`
   - A bare integer from `1` to `10` → use it
   - Anything else (non-numeric, out of range) → respond with: `That doesn't look like a cycle count. Try /breathe, or /breathe N where N is 1–10.` and stop.

2. **Launch the session.** Run exactly this Bash command, substituting the cycle count for `N`:

   ```bash
   open -na "Google Chrome" --args --app="https://jayvee6.github.io/breathe/?cycles=N"
   ```

   If Chrome isn't installed (the command fails), fall back to:

   ```bash
   open "https://jayvee6.github.io/breathe/?cycles=N"
   ```

   The Chrome `--app` flag opens a chromeless window that can self-close after the session. The plain `open` fallback opens in the default browser and the user closes it manually with ⌘W.

3. **Reply with one sentence in chat** confirming the launch. Estimated duration is `N × 19` seconds. Examples:
   - `/breathe` → "Opening a 4-cycle 4-7-8 session — see you in about 76 seconds."
   - `/breathe 2` → "Opening a 2-cycle 4-7-8 session — see you in about 38 seconds."
   - `/breathe 1` → "Opening a 1-cycle 4-7-8 session — see you in about 19 seconds."

Do not narrate the steps, do not show the command, do not explain anything else. Just launch and reply.
