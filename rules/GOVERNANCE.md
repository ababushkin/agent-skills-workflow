# Workflow governance

The always-on index for the `workflow` pack. The SessionStart hook injects this file every
session; the bulky governance modules are not injected — this index points to them. Inline
below are the short rules that must hold at all times. Linear is one module among several
in this pack, not the whole of governance. If this index and a module ever disagree, the
module is canonical and the drift is a bug — fix the index.

## Completion gate — always on

No work is done until, in order: **review** the working-tree changes (run
`/code-review-and-quality` via a sub-agent) → **fix** every Critical and Required finding →
**commit + push**. The steps are sequential; reordering or skipping is not permitted. Work
that exists only locally is not done. After the gate, the caller posts a completion summary
and transitions the work item to its terminal state — these steps are tracker-specific (for
Linear, see below).
Read `rules/code-review.md` for the full tracker-agnostic gate and its rationale.

## Comments — always on

A comment explains the code *as it stands* — an invariant, a non-obvious constraint, a
workaround the next reader would otherwise trip on. It never narrates how the code came to
look this way. Never put in a comment: ticket / issue IDs (`ABA-NNN`), story or task labels,
commit SHAs, PR numbers, or fix-history narration ("added for…", "fixes the bug where…",
"previously this…"). That context belongs in the commit message, the PR, the Linear issue,
or `docs/design-decisions.md`. Fixing an offending comment: strip the reference and keep the
explanatory prose; reword if the label was the grammatical subject; delete the comment if
nothing of value remains. Leave alone: sample-data IDs in tests, schema placeholders
(`"issue_identifier": "ABA-NNN"`), and references to in-repo docs (`README §1`).

## Linear lifecycle — always on

- An initiative is Ready only when all **six** fields are filled: Goal; Key results (3–5,
  each with baseline / target / window / source and a committed|aspirational tag); Affected
  repos; Appetite; Kill condition; Project type. Six fields, not four.
- Every cycle is **3 initiatives + 1 ops slot**. The ops slot is not a fourth initiative.
- **Done = KRs observed, not issues closed.** An initiative whose issues all closed but whose
  KRs didn't hold is Paused for a retrospective, not Done.
- On completion, after the gate: post a review-summary comment on the issue, then transition
  it to Done.
Read `rules/linear-workflow.md` for the full cycle / backlog / capture / issue-workflow rubric.

## Shaper pack — read when installed

If the Shaper pack is installed, defer to it for initiative *authoring*: the canonical
six-field shape definition and verification rubric live in its `initiative-shape` skill, and
the product and engineering principles live in `PRODUCT_RULES.md` and `eng-principles-*.md`.
Use `rules/linear-workflow.md` here for the tracker mechanics either way. If Shaper is not
installed, its inline authoring fallback applies — the tracker module stays authoritative.
