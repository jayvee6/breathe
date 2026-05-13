# ripple

A `/breathe` slash command for [Claude Code](https://claude.com/claude-code) that opens a calming WebGPU-rendered water scene and walks you through a breathing session — singing-bowl chimes, real wave physics, then a quiet affirmation and the window closes itself.

[**Try it live →**](https://jayvee6.github.io/ripple/)

## What it does

You type `/breathe` in Claude Code. A chromeless Chrome window pops open with a still pool of water and a stone resting at its center. You click to begin. A Tibetan-bowl tone strikes, ripples radiate out across the water, and the breath cycle begins — for as many cycles as you asked for. At the end, the scene quiets, a single line lands ("Welcome back to now."), the room dims, and the window closes itself.

Real wave physics. Real bowl harmonics. No interruption to your terminal flow.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/jayvee6/ripple/main/install.sh | bash
```

This drops a single file (`breathe.md`) into `~/.claude/commands/`. No clone, no dependencies, nothing else.

Restart Claude Code (or just start a new session) so the slash command registers.

## Use

The slash command accepts an exercise name and/or a cycle count, in any order:

```
/breathe                  → 4-7-8, 4 cycles (~76s)
/breathe 1                → 4-7-8, 1 cycle (~19s)
/breathe box              → box breathing, 4 cycles (~64s)
/breathe coherent         → coherent breathing, 6 cycles (~66s)
/breathe sigh             → physiological sigh, 3 cycles (~23s)
/breathe box 6            → box breathing, 6 cycles
/breathe coherent 10      → coherent, 10 cycles
```

Cycle range is 1–10.

### The exercises

| Exercise | Pattern | Best for |
|---|---|---|
| **4-7-8** | 4 in / 7 hold / 8 out | Stress relief, falling asleep (Dr. Weil's standard prescription) |
| **Box** | 4 in / 4 hold / 4 out / 4 rest | Focus, concentration, pre-performance |
| **Coherent** | 5.5 in / 5.5 out | Sustained calm, HRV training |
| **Physiological Sigh** | Double inhale + long exhale | Quick reset between tasks |

When you call `/breathe` with no exercise specified, Claude picks one — defaulting to 4-7-8 the first time, then learning from your reactions over time. After a session, just tell Claude how it felt ("that was great," "felt too long," "loved the box one") and the preference gets saved.

You can also visit [ripple's web app](https://jayvee6.github.io/ripple/) directly — the bare URL shows a glass-pane exercise picker.

## How it works

Three layers, all in one self-contained HTML file:

**Water surface** — a 2D discrete wave equation runs on a WebGPU compute shader. Three ping-pong height textures rotate each frame. Each chime injects a soft Gaussian impulse at the center; the wave propagates, reflects off the canvas edges, and damps out over a few seconds. The render shader reads the height field, computes per-pixel surface normals from neighbor heights, and lights them with diffuse + specular + a hint of fresnel.

**Singing bowls** — Web Audio API, four sine partials per strike at inharmonic ratios (1.0 / 2.76 / 5.40 / 8.93) that approximate a Tibetan bowl spectrum. Each partial gets its own gain envelope: the fundamental sustains over 6–7 seconds, while higher overtones decay progressively faster (0.55× / 0.28× / 0.16× of the base decay) — that's the authentic "shimmer fades, hum sustains" quality. Slight detuning across partials produces natural beating.

**The breath** — GSAP timelines drive the stone scale, halo opacity, phase label, and countdown. Each strike triggers bowl + ripple + a tiny "press" of the stone into the water. The HUD is a glass-blur aesthetic that stays out of the way.

## Why "ripple"?

The whole visual is a stone striking a pool of water and the rings radiating outward — a literal ripple. (And Apple has a `Breathe` watch app, so we kept the verb but renamed the project.)

## Roadmap

**v5 — ambient mode.** A way to run a continuous low-intensity water scene as a focus background while you work, without the structured breath cycle.

**v6 — per-exercise audio variations.** Right now all four exercises share the same three bowl pitches (inhale / hold / exhale). Each exercise could get its own pitch set so they feel acoustically distinct — e.g. box gets lower / more grounded, coherent gets warmer and more sustained.

## Uninstall

```bash
rm ~/.claude/commands/breathe.md
```

## Credit

Built by [Joey Villarreal](https://github.com/jayvee6) with Claude. Bokeh atmosphere and glass panel system adapted from the `sj-design` aesthetic toolkit.

## License

MIT — see [LICENSE](LICENSE).
