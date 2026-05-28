# Graphite stack review — handling reviewer comments

This runbook covers what to do when a reviewer leaves comments on a Graphite-stacked PR series. It applies whenever you have two or more PRs linked by `gt` and at least one comment has arrived that requires a code change.

---

## 1. Fetch the reviewer's comments

Pull the raw review comments for each PR in the stack:

```
gh api repos/{owner}/{repo}/pulls/{N}/comments
```

Run this command once per PR number in the stack (bottom to top). The response is a JSON array; each element has `path`, `line`, `body`, and `diff_hunk`. Collect all comments before triaging — a comment on PR 3 may describe a line that was introduced in PR 1.

---

## 2. Triage by layer

For each comment, identify which layer actually introduced the changed line:

1. Note the `path` and `line` from the comment.
2. Run `git log --all --oneline -- <path>` across the stack to see which branch first touched that file.
3. Assign the comment to the branch (layer) where the line was introduced, regardless of which PR number the reviewer left it on.

A comment left on PR 3 about a line introduced in PR 1 is a PR-1 fix — make the change there, not in PR 3.

---

## 3. Amend bottom-up

Work layer by layer, starting from the lowest layer that has comments:

1. Check out the target layer: `gt checkout <bottom-branch>`
2. Make the fix in the working tree.
3. Stage the changes: `git add <changed-files>`
4. Amend the commit: `git commit --amend --no-edit`
5. Stay on that layer until the commit is complete before moving to the next layer.

Do not cascade upward manually. Restack handles parent-SHA propagation in the next step.

---

## 4. Propagate with restack

After amending every affected layer, run:

```
gt restack
```

`gt restack` walks the stack from the amended layer upward, rebasing each higher layer onto the new parent SHA. Every branch in the stack will point at the correct, amended history when it completes.

If restack reports a conflict, resolve it in the working tree, run `git add <resolved-files>`, then `gt restack --continue`.

---

## 5. Force-push the stack

Push all amended layers to GitHub in one command:

```
gt submit --stack
```

After the push, verify that GitHub's head SHA matches your local branch for each PR:

```
gh pr view {N} --json headRefOid
git rev-parse <branch-name>
```

The two SHAs must match. A mismatch means the push didn't land cleanly — re-run `gt submit --stack` and check for push-protection errors before assuming success.
