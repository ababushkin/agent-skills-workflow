# Workflow

Engineering workflow skills for Claude Code teams — git discipline, CI/CD automation, code review governance, and Linear integration.

## Install

### Recommended — marketplace install

Add the marketplace, then install the `workflow` plugin:

```
/plugin marketplace add ababushkin/agent-skills-workflow
/plugin install workflow@agent-skills-workflow
```

Or with the `claude` CLI:

```bash
claude plugin marketplace add ababushkin/agent-skills-workflow
claude plugin install workflow@agent-skills-workflow
```

After install, run `/reload-plugins` to activate. Skills are namespaced as `workflow:<skill-name>`.

### Alternative — direct GitHub install

Install from GitHub without adding the marketplace:

```
/plugin install github@ababushkin/agent-skills-workflow
```

## Iterate loop (developers)

After cloning the repo and making changes:

1. **Edit** — modify skills in `skills/`, rules in `rules/`, or hooks in `hooks/hooks.json`.
2. **Bump version** — increment the `version` field in `.claude-plugin/plugin.json` (semver: `0.1.0` → `0.1.1`).
3. **Push** — `git push` to the `main` branch.
4. **Update** — users pick up the new version by running:

```
/plugin marketplace update agent-skills-workflow
/reload-plugins
```

Or with the CLI (then restart Claude Code):

```bash
claude plugin marketplace update agent-skills-workflow
```

Auto-update is supported — users can enable it via the `/plugin` → Marketplaces tab to receive updates automatically at session start.

## Directory layout

```
.claude-plugin/
  plugin.json       ← plugin manifest (name, version, description)
  marketplace.json  ← marketplace catalog (lists this plugin)
rules/              ← governance rule files loaded via CLAUDE.md
skills/             ← skill directories, each containing SKILL.md
hooks/
  hooks.json        ← event hooks (PostToolUse, Stop, etc.)
```

## Framework contracts (verified against code.claude.com/docs)

| Contract | Value | Source |
|---|---|---|
| Manifest location | `.claude-plugin/plugin.json` | [/en/plugins#quickstart](https://code.claude.com/docs/en/plugins#quickstart) |
| Manifest required fields | `name` only | [/en/plugins-reference#required-fields](https://code.claude.com/docs/en/plugins-reference#required-fields) |
| Marketplace location | `.claude-plugin/marketplace.json` | [/en/plugin-marketplaces#create-the-marketplace-file](https://code.claude.com/docs/en/plugin-marketplaces#create-the-marketplace-file) |
| Marketplace required fields | `name`, `owner.name`, `plugins[].name`, `plugins[].source` | [/en/plugin-marketplaces#marketplace-schema](https://code.claude.com/docs/en/plugin-marketplaces#marketplace-schema) |
| Add marketplace CLI | `/plugin marketplace add owner/repo` | [/en/discover-plugins#add-from-github](https://code.claude.com/docs/en/discover-plugins#add-from-github) |
| Install plugin CLI | `/plugin install name@marketplace` | [/en/discover-plugins#install-plugins](https://code.claude.com/docs/en/discover-plugins#install-plugins) |
| Update marketplace CLI | `/plugin marketplace update marketplace-name` | [/en/discover-plugins#manage-marketplaces](https://code.claude.com/docs/en/discover-plugins#manage-marketplaces) |
| Plugin-root variable | `${CLAUDE_PLUGIN_ROOT}` | [/en/plugins-reference#hooks](https://code.claude.com/docs/en/plugins-reference#hooks) |
| Component directories | `skills/`, `hooks/`, `agents/` at plugin root (not inside `.claude-plugin/`) | [/en/plugins#plugin-structure-overview](https://code.claude.com/docs/en/plugins#plugin-structure-overview) |

## License

MIT
