# breathe

A `/breathe` slash command for [Claude Code](https://claude.com/claude-code) that opens a calming WebGPU-rendered water scene and walks you through a 4-7-8 breathing session — singing-bowl chimes, real wave physics, then a quiet affirmation and the window closes itself.

[**Try it live →**](https://jayvee6.github.io/breathe/)

## What it does

You type `/breathe` in Claude Code. A chromeless Chrome window pops open with a still pool of water and a stone resting at its center. You click to begin. A Tibetan-bowl tone strikes, ripples radiate out across the water, and the breath cycle begins — 4 seconds in, 7 seconds held, 8 seconds out — for as many cycles as you asked for. At the end, the scene quiets, a single line lands ("Welcome back to now."), the room dims, and the window closes itself.

Real wave physics. Real bowl harmonics. No interruption to your terminal flow.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/jayvee6/breathe/main/install.sh | bash
```

This drops a single file (`breathe.md`) into `~/.claude/commands/`. No clone, no dependencies, nothing else.

Restart Claude Code (or just start a new session) so the slash command registers.

## Use

```
/breathe        → 4 cycles (~76 seconds, Dr. Weil's standard prescription)
/breathe 1      → quick reset (~19s)
/breathe 7      → longer session (~133s)
```

Range is 1–10.

## How it works

Three layers, all in one self-contained HTML file:

**Water surface** — a 2D discrete wave equation runs on a WebGPU compute shader. Three ping-pong height textures rotate each frame. Each chime injects a soft Gaussian impulse at the center; the wave propagates, reflects off the canvas edges, and damps out over a few seconds. The render shader reads the height field, computes per-pixel surface normals from neighbor heights, and lights them with diffuse + specular + a hint of fresnel.

**Singing bowls** — Web Audio API, four sine partials per strike at inharmonic ratios (1.0 / 2.76 / 5.40 / 8.93) that approximate a Tibetan bowl spectrum. Each partial gets its own gain envelope: the fundamental sustains over 6–7 seconds, while higher overtones decay progressively faster (0.55× / 0.28× / 0.16× of the base decay) — that's the authentic "shimmer fades, hum sustains" quality. Slight detuning across partials produces natural beating.

**The breath** — GSAP timelines drive the stone scale, halo opacity, phase label, and countdown. Each strike triggers bowl + ripple + a tiny "press" of the stone into the water. The HUD is a glass-blur aesthetic that stays out of the way.

## Roadmap

**v4 — more exercises, learned preferences.** Box breathing (4/4/4/4), coherent breathing (5.5/5.5), physiological sigh (double-inhale + long exhale). Claude tracks which ones work for you over time and picks accordingly when you call `/breathe` without an exercise specified. The slash command becomes a conversational coach rather than a one-shot launcher.

**v5 — ambient mode.** A way to run a continuous low-intensity water scene as a focus background while you work, without the structured breath cycle.

## Uninstall

```bash
rm ~/.claude/commands/breathe.md
```

## Credit

Built by [Joey Villarreal](https://github.com/jayvee6) with Claude. Bokeh atmosphere and glass panel system adapted from the `sj-design` aesthetic toolkit.

## License

MIT — see [LICENSE](LICENSE).
