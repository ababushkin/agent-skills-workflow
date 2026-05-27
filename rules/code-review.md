# Code review gate — completion requirement

This rule applies to every issue, regardless of tracker. Before any piece of work is declared done, the following steps must run in order.

---

## The gate

1. **Review** — Run `/code-review-and-quality` against the working-tree changes using a sub-agent. If the skill is not available, perform a five-axis diff review (correctness, readability, architecture, security, performance) manually.
2. **Fix** — Address any Critical or Required findings. Lower-severity findings are at the agent's discretion (fix inline or note in the completion summary).
3. **Commit + push** — Commit the reviewed version and push to the remote branch. Work that exists only locally is not done.

The gate is sequential: Review → Fix → Commit + push. Skipping or reordering is not permitted.

---

## Rationale

The gate exists because "compiles and tests pass" is not the same as "correct, maintainable, and safe to merge." Critical findings left unaddressed become production incidents; unreviewed pushes bypass the only asymmetric-judgement checkpoint in an agentic workflow. The gate makes the review step non-negotiable and its output visible (via the completion summary posted by the caller).

---

## Caller responsibilities

After the gate completes, the caller (the issue workflow, the skill, the human) is responsible for:
- Posting a completion summary that states the count of findings by severity and what was fixed vs deferred.
- Transitioning the work item to its terminal state in the tracker.

These steps are tracker-specific and are documented in the tracker's workflow rules (e.g. `linear-workflow.md`).
