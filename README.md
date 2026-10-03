# minecraft-paperweight-skills

Agent skills for the Minecraft PaperMC / Paperweight toolchain ecosystem.

## Overview

Paperweight consists of three Gradle plugins:

- **paperweight-core**: Used to build Paper itself from upstream Mojang/Spigot sources.
- **paperweight-patcher**: Used to create and maintain forks of Paper or other paperweight-patcher-based forks (e.g., Purpur, Folia, Gale, custom server forks).
- **paperweight-userdev**: Used to develop internal (NMS) plugins using Mojang mappings.

### Summary of Differences

| Plugin | Purpose | Target Use Case |
| --- | --- | --- |
| `paperweight-core` | Build Paper | Core PaperMC server development |
| `paperweight-patcher` | Create/maintain server forks | Custom server forks with layered patches |
| `paperweight-userdev` | Develop NMS plugins | Plugins needing direct access to Mojang-mapped server internals |

## Available Skills

| Skill | Status | Description |
| --- | --- | --- |
| [`minecraft-paperweight-patcher`](skills/paperweight-patcher/SKILL.md) | Available | Patching, building, and maintaining Minecraft server forks layered on top of Paper |
| `minecraft-paperweight-core` | Planned | Building Paper server core from upstream Mojang/Spigot |
| `minecraft-paperweight-userdev` | Planned | Developing NMS plugins using Mojang mappings |

## Installation

Install using the `skills` CLI:

```bash
npx skills add https://github.com/YueMi-Development/minecraft-paperweight-skills
```
