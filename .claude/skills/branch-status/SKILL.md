---
name: branch-status
description: Show which Kodesh branches are not yet merged into dev-deployed (the branch behind the live website) or master, what each contains, and whether it is finished. Use when asked where things stand, what is deployed, or before merging/cleaning branches.
---

# Branch status

`dev-deployed` is what the website shows: every push to it runs
`.github/workflows/deploy.yml` and publishes to GitHub Pages. `master` is the stable
line. Work happens on `fix/*`, `feature/*`, `release/*` and `claude/*` branches.

## Steps

1. `git fetch --all --prune`
2. For every remote branch, count what is missing from `dev-deployed` and `master`:

   ```bash
   for b in $(git branch -r --format='%(refname:short)' | grep -v -E 'HEAD|origin/(dev-deployed|master|gh-pages|audit-results)$'); do
     n=$(git rev-list --count origin/dev-deployed..$b)
     [ "$n" -gt 0 ] && echo "$n  $(git log -1 --format=%cs $b)  $b"
   done | sort -k2 -r
   ```

3. For each branch with unmerged commits: `git log --oneline origin/dev-deployed..<branch>`
   and `git diff --stat origin/dev-deployed...<branch>`, then decide:
   - **Finished**: the work is complete and it passes the `verify` skill (run it on a
     temporary merge — `git checkout -b tmp origin/dev-deployed && git merge --no-ff <branch>`).
   - **Already in**: the content is in `dev-deployed` under other commits (empty diff).
   - **Unfinished / stale**: say what's missing.
4. Check the last deploy: `gh run list --workflow deploy.yml -L 3`. A failed deploy
   leaves the previous version live.

## Report

A table: branch / last commit date / what it contains / status / recommendation.
Then list what the live site is missing compared to the newest work.

Merging into `dev-deployed` changes the live site — use the `deploy-dev` command, and
only after the user agrees. Never delete branches without asking.
