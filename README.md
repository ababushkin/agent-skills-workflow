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

## License

MIT
