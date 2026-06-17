Merge the current branch into the `dev-deploy` branch.

Steps to follow:
1. Run `git branch --show-current` to get the name of the current branch. Save it.
2. Run `git status --short` — if there are any uncommitted changes, stop and tell the user to commit or stash them first.
3. Run `git fetch origin dev-deploy` to make sure the remote branch is up to date.
4. If `dev-deploy` does not exist locally, create it by running `git checkout -b dev-deploy origin/dev-deploy`. Otherwise switch to it with `git checkout dev-deploy`.
5. Run `git pull origin dev-deploy` to sync local with remote.
6. Run `git merge <saved-branch-name> --no-ff -m "Merge <saved-branch-name> into dev-deploy"` to merge.
7. If there are merge conflicts, stop and describe them clearly to the user — do NOT resolve them automatically.
8. If the merge succeeded, run `git push -u origin dev-deploy`.
9. Switch back to the original branch with `git checkout <saved-branch-name>`.
10. Report success: which branch was merged, into which target, and confirm the push.
